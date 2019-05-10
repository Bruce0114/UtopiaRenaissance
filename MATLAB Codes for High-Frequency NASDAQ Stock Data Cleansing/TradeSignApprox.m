%1. This function approximates the direction of a trade employing the
%   approach stated in Hasbrouck(1991a)(1991b)
%2. Note that the input needs to be in 'raw data' form
%3. pcor  = percentage of correct number of approximations
%   psign = percentage of trades assigned as either buys or sells
%   pb    = percentage of trades assigned as buys
%   pb    = percentage of trades assigned as sells

function [y,pcor,psign,pb,ps]=TradeSignApprox(trade_raw_data,quote_raw_data)

LengthTradeRaw = length(trade_raw_data);
LengthQuoteRaw = length(quote_raw_data);

% Step 1. convert the time stamp format
TradeTimeConverted = TimeFormatConverter(trade_raw_data);
QuoteTimeConverted = LeadingZeroRemover(quote_raw_data);

% Step 2. change the time stamp in the raw data sets to make the time stamp in
% trade and quote series consistent
for i = 2:LengthTradeRaw
    trade_raw_data{i,1} = TradeTimeConverted(i-1);
end

for j = 2:LengthQuoteRaw
    quote_raw_data{j,2} = QuoteTimeConverted(j-1);
end

% Step 3. removes the trade and quote observations occurred before
% 9.30am and after 4.00pm, at which market opens and closes respectively

% for trade series
for start = 2:LengthTradeRaw
    if trade_raw_data{start,1} > 93000000
        break % do NOT include the trade observation AT 9.30am by using '>'
    end
end

for terminal = 2:LengthTradeRaw
    if trade_raw_data{terminal,1} >= 160000000
        break
    end
end

if start == 2
    trade_raw_data(terminal:end,:) = [];
else
    trade_raw_data([2:start-1,terminal:end],:) = [];
end

% for quote series
for start = 2:LengthQuoteRaw
    if quote_raw_data{start,2} >= 93000000
        break % include the quote observation AT 9.30am by using '>='
    end
end

for terminal = 2:LengthQuoteRaw
    if quote_raw_data{terminal,2} >= 160000000
        break
    end
end

if start == 2
    quote_raw_data(terminal:end,:) = [];
else
    quote_raw_data([2:start-1,terminal:end],:) = [];
end

% Step 4. estimate the sign trade by trade by comparing the transaction
% price in trade observation with the prevailing quote midpoint. If the
% transaction price is above the prevailing quote midpoint the associated
% trade is assumed to be a purchase and a positive sign is added to the
% trade volume, while a negative sign is added if the transaction price is
% below the prevailing quote midpoint. If the transaction price is equal
% to the quote midpoint, the direction of trade is undetermined and x_t is
% set to 0.
LengthTradeRaw = length(trade_raw_data);
LengthQuoteRaw = length(quote_raw_data);

a = 2; % trade series count
b = 2; % quote series count

while a <=LengthTradeRaw && b <= LengthQuoteRaw
    
    if a == 2 % scenario 1 - handle the initial trade observation
        while trade_raw_data{a,1} > quote_raw_data{b,2}
            b = b + 1;
        end
        
        if trade_raw_data{a,5}...
                < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
            trade_raw_data{a,3} = -trade_raw_data{a,3};
        elseif trade_raw_data{a,5}...
                == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
            trade_raw_data{a,3} = 0;
        end
        a = a + 1;
        
        % scenario 2 - the stopping process
        % the program enters the stopping process if either trade or quote
        % series reach the end
    elseif a == LengthTradeRaw || b == LengthQuoteRaw
        if a == LengthTradeRaw% if trade series reach the end first
            b = b - 50;
            while trade_raw_data{a,1} > quote_raw_data{b,2}
                b = b + 1;
            end
            
            if trade_raw_data{a,5}...
                    < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
                trade_raw_data{a,3} = -trade_raw_data{a,3};
            elseif trade_raw_data{a,5}...
                    == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
                trade_raw_data{a,3} = 0;
            end
            a = a + 1;
        elseif b == LengthQuoteRaw% if quote series reach the end first
            while a <= LengthTradeRaw
                if trade_raw_data{a,5}...
                        < (0.5*(quote_raw_data{b,3}+quote_raw_data{b,4}))
                    trade_raw_data{a,3} = -trade_raw_data{a,3};
                elseif trade_raw_data{a,5}...
                        == (0.5*(quote_raw_data{b,3}+quote_raw_data{b,4}))
                    trade_raw_data{a,3} = 0;
                end
                a = a + 1;
            end
        end
        
        % scenario 3 - cases where 2 adjacent trades happened at DIFFERENT
        % time
    elseif trade_raw_data{a,1} ~= trade_raw_data{a-1,1}
        if trade_raw_data{a,1} <= quote_raw_data{b,2}
            if trade_raw_data{a,5}...
                    < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
                trade_raw_data{a,3} = -trade_raw_data{a,3};
            elseif trade_raw_data{a,5}...
                    == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
                trade_raw_data{a,3} = 0;
            end
            a = a + 1;
        end
        
        % KEY step: we lead 'b' one step forward ONLY IF the next trade
        % occurs AFTER the then-selected quote
        if trade_raw_data{a,1} > quote_raw_data{b,2}
            b = b + 1;
        end
        
        % scenario 4 - cases where 2 adjacent trades happened at the SAME
        % time
    elseif trade_raw_data{a,1} == trade_raw_data{a-1,1}
        if trade_raw_data{a,5}...
                < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
            trade_raw_data{a,3} = -trade_raw_data{a,3};
        elseif trade_raw_data{a,5}...
                == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,4}))
            trade_raw_data{a,3} = 0;
        end
        a = a + 1; % in this case we do NOT move b one step forward
    end
end

% Step 5. calculate pcor, psign, pb & ps

% for pcor
SignIndicator = 0;

for z = 2: LengthTradeRaw
    if trade_raw_data{z,3} > 0 && trade_raw_data{z,4} == 'B' ||...
            trade_raw_data{z,3} < 0 && trade_raw_data{z,4} == 'S'
        
        SignIndicator = SignIndicator + 1;
        
    end
end

pcor  = SignIndicator/LengthTradeRaw;

% for psign
SignIndicator = 0;

for z = 2: LengthTradeRaw
    if trade_raw_data{z,3} ~= 0
        SignIndicator = SignIndicator + 1;
    end
end

psign = SignIndicator/LengthTradeRaw;

% for pb
BuyIndicator = 0;

for z = 2: LengthTradeRaw
    if trade_raw_data{z,3} > 0
        BuyIndicator = BuyIndicator + 1;
    end
end

pb = BuyIndicator/LengthTradeRaw;

% for ps
SellIndicator = 0;

for z = 2: LengthTradeRaw
    if trade_raw_data{z,3} < 0
        SellIndicator = SellIndicator + 1;
    end
end

ps = SellIndicator/LengthTradeRaw;

% Step 6. generate the main output
y = zeros(LengthTradeRaw-1,2); % preallocation of output matrix

for count = 2:LengthTradeRaw
    y(count-1,1) = trade_raw_data{count,1};
    y(count-1,2) = trade_raw_data{count,3};
end

end