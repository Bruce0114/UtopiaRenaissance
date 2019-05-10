%1. This function cumulates trades that occur at the same time with the
%   SAME signs as a single observation
%2. Note that the input needs to be in 'raw data' form

function TradeCombined = TradeCumulater(trade_raw_data)

TradeData          = TradingTimeData(trade_raw_data,0);
LengthData         = length(TradeData);

TradeCombined      = zeros(length(TradeData),2); %preallocation

TradeCombined(1,:) = TradeData(1,:);

j = 1;

for i = 2:LengthData
    if TradeData(i,1) == TradeData(i-1,1) && ...
            IsSameSign(TradeData(i,2),TradeData(i-1,2)) == 1
        TradeCombined(j,2) = TradeCombined(j,2) + TradeData(i,2);
        TradeCombined(j,1) = TradeData(i,1);
    else
        j = j + 1;
        TradeCombined(j,2) = TradeData(i,2);
        TradeCombined(j,1) = TradeData(i,1);
    end
end

TradeCombined(j+1:end,:) = []; %variable size reduction

end