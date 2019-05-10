%1. This function performs the 'event count' based on the approach stated
%   in Hasbrouck(1991b)
%2. Note that the input needs to be in 'raw data' form
%3. The each trade volume in the trade series is assigned either as a buy
%   or sell based on the APPROXIMATION approach in Hasbrouck(1991b)

function [TradeEventCountApprox,QuoteEventCountApprox,pcor,psign,pb,ps] ...
    = EventCounterApprox(trade_raw_data, quote_raw_data)

% cleanse the data applying the user defined functions
[TradeCombined,pcor,psign,pb,ps] ...
    = TradeCumulaterApprox(trade_raw_data,quote_raw_data);
LogQuoteMidpoint = QuoteMidpointCalculator(quote_raw_data);
LengthMidpoint   = length(LogQuoteMidpoint);
LengthTradeCom   = length(TradeCombined);

TradeEventCountApprox  = zeros(LengthMidpoint,1);
counter          = 1;
i                = 1;

while i <= LengthMidpoint
    if LogQuoteMidpoint(i,1) == 93000000
        TradeEventCountApprox(i) = 0;
        
        %if the program runs to the end of the trade series but there are
        %still more entries in the quote series to be gone through, then
        %set the remaining empty entries in TradeEventCountApprox to be 0
    elseif counter > LengthTradeCom;
        TradeEventCountApprox(i:end) = 0;
        
    elseif TradeCombined(counter,1) <= LogQuoteMidpoint(i,1)
        TradeEventCountApprox(i) = TradeCombined(counter,2);
        counter = counter + 1; % the counter moves 1 step forward only if
        % we copy one trade volume data from TradeCombined to TradeEventCountApprox
        
    else
        TradeEventCountApprox(i) = 0;
    end
    i = i + 1;
end

QuoteEventCountApprox = LogQuoteMidpoint(:,2);

end