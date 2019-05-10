%1. This function filters original raw data into one second solution raw data
%2. Note that the input needs to be in 'raw data' form

function y = OneSecondFilter(trade_raw_data, quote_raw_data)

LengthTradeRaw = length(trade_raw_data);
LengthQuoteRaw = length(quote_raw_data);

% Step 1. convert the time stamp format
TradeTimeConverted = TimeFormatConverter(trade_raw_data);
QuoteTimeConverted = LeadingZeroRemover(quote_raw_data);

% Step 2. change the time stamp in the raw data sets to make the time stamp in
% trade and quote series consistent
for i = 2:length(trade_raw_data)
    trade_raw_data{i,1} = TradeTimeConverted(i-1);
end

for j = 2:length(quote_raw_data)
    quote_raw_data{j,2} = QuoteTimeConverted(j-1);
end

% Step 3. extract the FIRST observation of every second
intervalStart = 2;
count         = 1;
IndexVector   = zeros(LengthTradeRaw,1);

for intervalEnd = 3:LengthTradeRaw
    if (trade_raw_data{intervalEnd,1} - trade_raw_data{intervalStart,1}) ...
            >= 1000
        if intervalEnd - intervalStart > 2          
            IndexVector(count)   = trade_raw_data{intervalStart+1,1};
            IndexVector(count+1) = trade_raw_data{intervalEnd-1,1};
            count                = count + 2;
        elseif intervalEnd - intervalStart == 2
            IndexVector(count)   = trade_raw_data{intervalStart+1,1};
            count                = count + 1;
        else
            intervalStart = intervalEnd;
        end        
    end
end

IndexVector(IndexVector==0) = []; % delete the zero entries

% Step 4. delete the rest observations
LengthIndex = length(IndexVector);

for n = 1:LengthIndex-1 
    trade_raw_data(IndexVector(n):IndexVector(n+1)) = []; 
end

end