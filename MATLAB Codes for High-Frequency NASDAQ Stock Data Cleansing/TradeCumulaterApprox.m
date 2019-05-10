%1. This function cumulates trades that occur at the same time with the
%   SAME approximated signs as a single observation
%2. Note that the input needs to be in 'raw data' form
%3. pcor  = percentage of correct number of approximations
%   psign = percentage of trades assigned as either buys or sells
%   pb    = percentage of trades assigned as buys
%   pb    = percentage of trades assigned as sells

function [ApproxCombined,pcor,psign,pb,ps] ...
    =TradeCumulaterApprox(trade_raw_data,quote_raw_data)

[TradeData,pcor,psign,pb,ps]= TradeSignApprox(trade_raw_data,quote_raw_data);
LengthTradeData             = length(TradeData);

ApproxCombined              = zeros(LengthTradeData,2); %preallocation

ApproxCombined(1,:)         = TradeData(1,:);

j = 1;

for i = 2:LengthTradeData
    if TradeData(i,1) == TradeData(i-1,1) && ...
            IsSameSign(TradeData(i,2),TradeData(i-1,2)) == 1
        ApproxCombined(j,2) = ApproxCombined(j,2) + TradeData(i,2);
        ApproxCombined(j,1) = TradeData(i,1);
    else
        j = j + 1;
        ApproxCombined(j,2) = TradeData(i,2);
        ApproxCombined(j,1) = TradeData(i,1);
    end
end

ApproxCombined(j+1:end,:) = []; %variable size reduction

end