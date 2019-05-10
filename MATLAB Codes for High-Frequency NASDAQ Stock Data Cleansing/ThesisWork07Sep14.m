clear
clc

%% company selection by random number generator
tic
[~,~,firm_raw] = xlsread('company name.xlsx');
toc
%%
[large,medium,small] = CompanySelector(firm_raw,4);
%% data for modine (result:8.680322 seconds)
tic
[~,~,trade_raw_data] = xlsread('modine_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data] = xlsread('modine_quote_07_11jan08.xlsx','07jan08');
toc
%% data for lifepoint (result:8.992026 seconds)
tic
[~,~,trade_raw_data] = xlsread('lifepoint_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data] = xlsread('lifepoint_quote_07_11jan08.xlsx','07jan08');
toc
%% data for apple (result:69.331644 seconds old datasets) (50.647733 seconds new datasets)
tic
[~,~,trade_raw_data] = xlsread('apple_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data] = xlsread('apple_quote_07_11jan08.xlsx','07jan08');
toc
%% import to read excel data (result:58.687456 seconds)
tic
trade_raw_data_import = importdata('modine_trade_07_11jan08.xlsx');
quote_raw_data_import = importdata('modine_quote_07_11jan08.xlsx');
toc
%% load .mat file for modine (result:0.334829 seconds)
tic
trade_raw_data_mat = load('trade_raw_data.mat');
quote_raw_data_mat = load('quote_raw_data.mat');
toc
%% result:0.320914 second
tic
all_raw_data_mat = load('AllData.mat');
toc
%% 5 days data for modine - Elapsed time is 43.714230 seconds.
tic
[~,~,small_trade_raw_data_day1] = xlsread('modine_trade_07_11jan08.xlsx','07jan08');
[~,~,small_quote_raw_data_day1] = xlsread('modine_quote_07_11jan08.xlsx','07jan08');

[~,~,small_trade_raw_data_day2] = xlsread('modine_trade_07_11jan08.xlsx','08jan08');
[~,~,small_quote_raw_data_day2] = xlsread('modine_quote_07_11jan08.xlsx','08jan08');

[~,~,small_trade_raw_data_day3] = xlsread('modine_trade_07_11jan08.xlsx','09jan08');
[~,~,small_quote_raw_data_day3] = xlsread('modine_quote_07_11jan08.xlsx','09jan08');

[~,~,small_trade_raw_data_day4] = xlsread('modine_trade_07_11jan08.xlsx','10jan08');
[~,~,small_quote_raw_data_day4] = xlsread('modine_quote_07_11jan08.xlsx','10jan08');

[~,~,small_trade_raw_data_day5] = xlsread('modine_trade_07_11jan08.xlsx','11jan08');
[~,~,small_quote_raw_data_day5] = xlsread('modine_quote_07_11jan08.xlsx','11jan08');
toc
%% 5 days data for lifepoint - Elapsed time is 44.650949 seconds.
tic
[~,~,med_trade_raw_data_day1] = xlsread('lifepoint_trade_07_11jan08.xlsx','07jan08');
[~,~,med_quote_raw_data_day1] = xlsread('lifepoint_quote_07_11jan08.xlsx','07jan08');

[~,~,med_trade_raw_data_day2] = xlsread('lifepoint_trade_07_11jan08.xlsx','08jan08');
[~,~,med_quote_raw_data_day2] = xlsread('lifepoint_quote_07_11jan08.xlsx','08jan08');

[~,~,med_trade_raw_data_day3] = xlsread('lifepoint_trade_07_11jan08.xlsx','09jan08');
[~,~,med_quote_raw_data_day3] = xlsread('lifepoint_quote_07_11jan08.xlsx','09jan08');

[~,~,med_trade_raw_data_day4] = xlsread('lifepoint_trade_07_11jan08.xlsx','10jan08');
[~,~,med_quote_raw_data_day4] = xlsread('lifepoint_quote_07_11jan08.xlsx','10jan08');

[~,~,med_trade_raw_data_day5] = xlsread('lifepoint_trade_07_11jan08.xlsx','11jan08');
[~,~,med_quote_raw_data_day5] = xlsread('lifepoint_quote_07_11jan08.xlsx','11jan08');
toc
%% 5 days data for apple abt 390 seconds using old exported data
%                        abt 264.263750 seconds using new exported data 
tic
[~,~,trade_raw_data_day1] = xlsread('apple_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data_day1] = xlsread('apple_quote_07_11jan08.xlsx','07jan08');

[~,~,trade_raw_data_day2] = xlsread('apple_trade_07_11jan08.xlsx','08jan08');
[~,~,quote_raw_data_day2] = xlsread('apple_quote_07_11jan08.xlsx','08jan08');

[~,~,trade_raw_data_day3] = xlsread('apple_trade_07_11jan08.xlsx','09jan08');
[~,~,quote_raw_data_day3] = xlsread('apple_quote_07_11jan08.xlsx','09jan08');

[~,~,trade_raw_data_day4] = xlsread('apple_trade_07_11jan08.xlsx','10jan08');
[~,~,quote_raw_data_day4] = xlsread('apple_quote_07_11jan08.xlsx','10jan08');

[~,~,trade_raw_data_day5] = xlsread('apple_trade_07_11jan08.xlsx','11jan08');
[~,~,quote_raw_data_day5] = xlsread('apple_quote_07_11jan08.xlsx','11jan08');
toc
%% load apple .mat data Elapsed time is 0.792853 seconds.
tic
load('AppleApprox.mat');
toc
%% data for lifepoint
[~,~,trade_raw_data] = xlsread('lifepoint_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data] = xlsread('lifepoint_quote_07_11jan08.xlsx','07jan08');
%% data for apple
[~,~,trade_raw_data] = xlsread('apple_trade_07_11jan08.xlsx','07jan08');
[~,~,quote_raw_data] = xlsread('apple_quote_07_11jan08.xlsx','07jan08');
%%
modine_data = data(:,[1,3]);
%%
%convert milliseconds-from-midnight format to military time format
TimeInHour   = modine_data(:,1)/3600000; 
HourInteger  = floor(TimeInHour);
HourDecimal  = TimeInHour - HourInteger;
TimeInMinute = HourDecimal*60;
MinuteInteger= floor(TimeInMinute);
MinuteDecimal= TimeInMinute - MinuteInteger;
Milliseconds = round(MinuteDecimal*60*1000);
MilitaryTimeConverted = HourInteger*10000000 + MinuteInteger*100000 +...
    + Milliseconds;
%%
tic
MilitaryTimeConverted = TimeFormatConverter(trade_raw_data);
QuoteTime = LeadingZeroRemover(quote_raw_data);
toc
%%
%remove leading zeros in military time string
military_time = zeros(length(raw)-1,1);
for i = 2:length(raw)
    military_time(i-1) = str2double(raw{i,2});
end
%%
tradedata = TradingTimeData(trade_raw_data,0);
quotedata = TradingTimeData(quote_raw_data,1);
%%
MilitaryTimeData = TradeSignAdder(trade_raw_data);
%%
tic
DataNoDuplicates = QuoteDuplicatesRemover(quote_raw_data);
toc
%%
LogQuoteMidpoint = QuoteMidpointCalculator(quote_raw_data);
%%
TradeCombined = TradeCumulater(trade_raw_data_day4);
%% 0.284541 seconds.
tic
[TradeCombinedApprox,pcor,psign,pb,ps]...
    = TradeCumulaterApprox(trade_raw_data,quote_raw_data);
toc
%%
a = 1;
while a < 10
    a = a + 1;
end
%%
tradedataApprox = TradeSignApprox(trade_raw_data,quote_raw_data);
%%
[TradeEventCount, QuoteEventCount] ...
    = EventCounter(trade_raw_data_day1, quote_raw_data_day1);
%%
tic
[TradeEventCountApprox, QuoteEventCountApprox] ...
    = EventCounterApprox(trade_raw_data_day1, quote_raw_data_day1);
toc
%%
plot(1:length(TradeEventCount),TradeEventCount,1:length(TradeEventCountApprox),TradeEventCountApprox);
%% ADF test
ADF_TradeEventCount = adftest(CombinedTradeData);
%%
ADF_TradeEventCountApprox = adftest(TradeEventCountApprox);
ADF_QuoteEventCount = adftest(QuoteEventCount);
%%
if strcmp('c','d')
    a = 1;
else
    a = 0;
end
%% Elapsed time is 3.862884 seconds for modine 
tic
[CombinedTradeData,CombinedQuoteData,apcor,apsign,apb,aps] ...
    = DataCombiner(trade_raw_data_day1, quote_raw_data_day1,...
    trade_raw_data_day2, quote_raw_data_day2,...
    trade_raw_data_day3, quote_raw_data_day3,...
    trade_raw_data_day4, quote_raw_data_day4,...
    trade_raw_data_day5, quote_raw_data_day5, 'approx','','Yes','Modine');
toc
%% Elapsed time is 5.759627 seconds is for lifepoint
tic
[LifeCombinedTradeData,LifeCombinedQuoteData,Lifeapcor,Lifeapsign,Lifeapb,Lifeaps] ...
    = DataCombiner(life_trade_raw_data_day1, life_quote_raw_data_day1,...
    life_trade_raw_data_day2, life_quote_raw_data_day2,...
    life_trade_raw_data_day3, life_quote_raw_data_day3,...
    life_trade_raw_data_day4, life_quote_raw_data_day4,...
    life_trade_raw_data_day5, life_quote_raw_data_day5, 'approx','','Yes','Life');
toc
%% Elapsed time is 293.429692 seconds (BEFORE code modification) for apple
%  Elapsed time is 234.631846 seconds (AFTER code modification)
%  Elapsed time is 226.788121 seconds using the new export data
tic
[AppleCombinedTradeData,AppleCombinedQuoteData,Appleapcor,Appleapsign,...
    Appleapb,Appleaps,Appleaacb,Appleaacs] ...
    = DataCombiner(apple_trade_raw_data_day1, apple_quote_raw_data_day1,...
    apple_trade_raw_data_day2, apple_quote_raw_data_day2,...
    apple_trade_raw_data_day3, apple_quote_raw_data_day3,...
    apple_trade_raw_data_day4, apple_quote_raw_data_day4,...
    apple_trade_raw_data_day5, apple_quote_raw_data_day5, 'approx','','Yes','Apple','Save');
toc
%%
AllData = struct('Trade',CombinedTradeData,'QuoteRevision',CombinedQuoteData);
save('modine','-struct','AllData');
%% Elapsed time is 0.032084 seconds.
tic
ModineReal   = load('ModineReal.mat');
ModineApprox = load('ModineApprox.mat');
toc
%%
figure
plot(ModineReal.Trade)
figure
plot(ModineReal.QuoteRevision)
%%
figure
plot(CombinedTradeData)
figure
plot(CombinedQuoteData)
% %% Back up for function TradeSignApprox
% while a <=length(trade_raw_data) && b <= length(quote_raw_data)
%     
%     if a == 2 % scenario 1 - handle the initial trade observation
%         while trade_raw_data{a,1} >= quote_raw_data{b,2}
%             b = b + 1;
%         end
%         
%         if trade_raw_data{a,5}...
%                 < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%             trade_raw_data{a,3} = -trade_raw_data{a,3};
%         elseif trade_raw_data{a,5}...
%                 == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%             trade_raw_data{a,3} = 0;
%         end
%         a = a + 1;
%         
%     elseif b == 3 % scenario 2 
%         if trade_raw_data{a,5}...
%                 < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%             trade_raw_data{a,3} = -trade_raw_data{a,3};
%         elseif trade_raw_data{a,5}...
%                 == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%             trade_raw_data{a,3} = 0;
%         end
%         a = a + 1;
%         b = b + 1;
%         % scenario 3 - the stopping process
%     elseif a == length(trade_raw_data) || b == length(quote_raw_data)
%         if a == length(trade_raw_data)
%             b = b - 50;
%             while trade_raw_data{a,1} > quote_raw_data{b,2}
%                 b = b + 1;
%             end
%             
%             if trade_raw_data{a,5}...
%                     < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%                 trade_raw_data{a,3} = -trade_raw_data{a,3};
%             elseif trade_raw_data{a,5}...
%                     == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%                 trade_raw_data{a,3} = 0;
%             end
%             a = a + 1;
%         elseif b == length(quote_raw_data)
%             while a <= length(trade_raw_data)
%                 if trade_raw_data{a,5}...
%                         < (0.5*(quote_raw_data{b,3}+quote_raw_data{b,5}))
%                     trade_raw_data{a,3} = -trade_raw_data{a,3};
%                 elseif trade_raw_data{a,5}...
%                         == (0.5*(quote_raw_data{b,3}+quote_raw_data{b,5}))
%                     trade_raw_data{a,3} = 0;
%                 end
%                 a = a + 1;
%             end
%         end
%         
%         % scenario 4 - cases where 2 adjacent trades happened at DIFFERENT
%         % time
%     elseif trade_raw_data{a,1} ~= trade_raw_data{a-1,1}
%         if trade_raw_data{a,1} <= quote_raw_data{b-1,2}
%             if trade_raw_data{a,5}...
%                     < (0.5*(quote_raw_data{b-2,3}+quote_raw_data{b-2,5}))
%                 trade_raw_data{a,3} = -trade_raw_data{a,3};
%             elseif trade_raw_data{a,5}...
%                     == (0.5*(quote_raw_data{b-2,3}+quote_raw_data{b-2,5}))
%                 trade_raw_data{a,3} = 0;
%             end
%             a = a + 1;
%         elseif trade_raw_data{a,1} <= quote_raw_data{b,2}
%             if trade_raw_data{a,5}...
%                     < (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%                 trade_raw_data{a,3} = -trade_raw_data{a,3};
%             elseif trade_raw_data{a,5}...
%                     == (0.5*(quote_raw_data{b-1,3}+quote_raw_data{b-1,5}))
%                 trade_raw_data{a,3} = 0;
%             end
%             a = a + 1;
%         end
%         b = b + 1;
%         
%         % scenario 5 - cases where 2 adjacent trades happened at the SAME
%         % time
%     elseif trade_raw_data{a,1} == trade_raw_data{a-1,1}
%         if trade_raw_data{a,5}...
%                 < (0.5*(quote_raw_data{b-2,3}+quote_raw_data{b-2,5}))
%             trade_raw_data{a,3} = -trade_raw_data{a,3};
%         elseif trade_raw_data{a,5}...
%                 == (0.5*(quote_raw_data{b-2,3}+quote_raw_data{b-2,5}))
%             trade_raw_data{a,3} = 0; 
%         end
%         a = a + 1; % in this case we do NOT move b one step forward
%     end
% end
%%
tic
test =length(apple_quote_raw_data_day3);
toc
%%
A = 
tic
test = length(A);
toc
%% Elapsed time is 15.162092 seconds. for apple day1 data
tic
[AveTrade,AveQuote] = AverageTime(apple_trade_raw_data_day1,apple_quote_raw_data_day1);
toc
%% Elapsed time is 0.175840 seconds. for modine day1 data
tic
[AveTrade,AveQuote] = AverageTime(trade_raw_data,quote_raw_data);
toc