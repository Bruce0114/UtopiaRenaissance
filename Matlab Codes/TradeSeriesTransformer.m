%This function generates two transformed trade series using the original
%combined trade data as input

function [SignedIndicator,SignedSquared] ...
    = TradeSeriesTransformer(combined_trade_data)

SignedIndicator = zeros(length(combined_trade_data),1);

% 1. create 'signed trade indicator variable': 
%    the indicator = 1 if the trade volume is positive and -1 if negative
for i = 1:length(combined_trade_data)
    if combined_trade_data(i) > 0
        SignedIndicator(i) = 1;
    elseif combined_trade_data(i) < 0
        SignedIndicator(i) = -1;  
    else
        SignedIndicator(i) = 0;
    end
end

% 2. create 'signed squared trade variable
SignedSquared = SignedIndicator.*(combined_trade_data.^2);
  
end