% 1. This function calculates the average time elapsed between two trades and
% between two quotes after trade and quote series are cleansed
% 2. The output is expressed in seconds

function [AveTrade,AveQuote] = AverageTime(trade_raw_data,quote_raw_data)

TradeCombined    = TradeCumulater(trade_raw_data);
LogQuoteMidpoint = QuoteMidpointCalculator(quote_raw_data);

LengthTrade = length(TradeCombined);
LengthQuote = length(LogQuoteMidpoint);

% preallocation
AveTrade = zeros(LengthTrade-1,1);
AveQuote = zeros(LengthQuote-1,1);

% for trade series, compute the time difference between 2 adjacent trades
for i = 2:LengthTrade
    AveTrade(i-1) = TradeCombined(i,1) - TradeCombined(i-1,1);
end

AveTrade = sum(AveTrade)/numel(AveTrade)/1000;
AveTrade = RoundToDecimalPlace(AveTrade,2); %round the number to 2 decimal places

% for quote series, compute the time difference between 2 adjacent quotes
for i = 2:LengthQuote
    AveQuote(i-1) = LogQuoteMidpoint(i,1) - LogQuoteMidpoint(i-1,1);
end

AveQuote = sum(AveQuote)/numel(AveQuote)/1000;
AveQuote = RoundToDecimalPlace(AveQuote,2); %round the number to 2 decimal places

end