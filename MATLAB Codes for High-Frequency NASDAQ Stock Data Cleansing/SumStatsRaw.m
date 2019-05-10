% This function calculates number of obs. in trade and quote series for
% each stock with raw data and tabulates the figures for each series in a
% 6-by-5 table respectively

function [SumTradeRaw,SumQuoteRaw] ...
    = SumStatsRaw(trade_raw_data_day1, quote_raw_data_day1,...
    trade_raw_data_day2, quote_raw_data_day2,...
    trade_raw_data_day3, quote_raw_data_day3,...
    trade_raw_data_day4, quote_raw_data_day4,...
    trade_raw_data_day5, quote_raw_data_day5, filename)
% for trade series

% use function 'TradingTimeData' to remove non-trading time data first
TradeData1  = TradingTimeData(trade_raw_data_day1,0);
LengthT1    = length(TradeData1);
TradeData2  = TradingTimeData(trade_raw_data_day2,0);
LengthT2    = length(TradeData2);
TradeData3  = TradingTimeData(trade_raw_data_day3,0);
LengthT3    = length(TradeData3);
TradeData4  = TradingTimeData(trade_raw_data_day4,0);
LengthT4    = length(TradeData4);
TradeData5  = TradingTimeData(trade_raw_data_day5,0);
LengthT5    = length(TradeData5);

SumTradeRaw        = cell(7,2);
SumTradeRaw(2:7,1) = {'Day1';'Day2';'Day3';'Day4';'Day5';'Total'};
ticker             = strsplit(filename,'_');
SumTradeRaw(1,2)   = ticker(1);
SumTradeRaw(2:7,2) = {LengthT1;LengthT2;LengthT3;LengthT4;LengthT5;...
    sum([LengthT1;LengthT2;LengthT3;LengthT4;LengthT5])};

% for quote series
% use function 'TradingTimeData' to remove non-trading time data first
QuoteData1  = TradingTimeData(quote_raw_data_day1,1);
LengthQ1    = length(QuoteData1);
QuoteData2  = TradingTimeData(quote_raw_data_day2,1);
LengthQ2    = length(QuoteData2);
QuoteData3  = TradingTimeData(quote_raw_data_day3,1);
LengthQ3    = length(QuoteData3);
QuoteData4  = TradingTimeData(quote_raw_data_day4,1);
LengthQ4    = length(QuoteData4);
QuoteData5  = TradingTimeData(quote_raw_data_day5,1);
LengthQ5    = length(QuoteData5);

SumQuoteRaw        = cell(7,2);
SumQuoteRaw(2:7,1) = {'Day1';'Day2';'Day3';'Day4';'Day5';'Total'};
SumQuoteRaw(1,2)   = ticker(1);
SumQuoteRaw(2:7,2) = {LengthQ1;LengthQ2;LengthQ3;LengthQ4;LengthQ5;...
    sum([LengthQ1;LengthQ2;LengthQ3;LengthQ4;LengthQ5])};

% data storage
AllData=struct('SumTradeRaw',{SumTradeRaw},'SumQuoteRaw',{SumQuoteRaw});
save(filename,'-struct','AllData');

end