%1. This function adds a sign to each trade, with '+' for purchase and '-'
%   for sell
%2. Note that the input needs to be in 'raw data' form

function MilitaryTimeData = TradeSignAdder(trade_raw_data)

LengthTradeRaw   = length(trade_raw_data);

MilitaryTimeData = TimeFormatConverter(trade_raw_data);
LengthData       = numel(MilitaryTimeData);

for i = 2:LengthTradeRaw
    MilitaryTimeData(i-1,2) = trade_raw_data{i,3};
end

for i = 1:LengthData
    if strcmpi(trade_raw_data{i+1,4},'S') % string comparison
        MilitaryTimeData(i,2) = -MilitaryTimeData(i,2);
    end
end

end