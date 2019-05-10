clear
clc
%% facilitator
% S  = {'BW','CDR','MOD','NXTM','PBH'};
% SS = S{1};
% S_file_T = strcat(SS,'_trade_07_11jan08.xlsx');
% S_file_Q = strcat(SS,'_quote_07_11jan08.xlsx');
% M  = {'CETV','FCN','LSTR','LPNT','CKH'};
% MM = M{1};
% M_file_T = strcat(MM,'_trade_07_11jan08.xlsx');
% M_file_Q = strcat(MM,'_quote_07_11jan08.xlsx');
% L  = {'AMZN','AMAT','DIS','GPS','GOOG'};
% LL = L{1};
% L_file_T = strcat(LL,'_trade_07_11jan08.xlsx');
% L_file_Q = strcat(LL,'_quote_07_11jan08.xlsx');
%% Step 1. data loading
% 5 days data for small
%%
S  = {'BW','CDR','MOD','NXTM','PBH'};
SS = S{5};
S_file_T = strcat(SS,'_trade_07_11jan08.xlsx');
S_file_Q = strcat(SS,'_quote_07_11jan08.xlsx');
%
tic
[~,~,small_trade_raw_data_day1] = xlsread(S_file_T,'07jan08');
[~,~,small_quote_raw_data_day1] = xlsread(S_file_Q,'07jan08');

[~,~,small_trade_raw_data_day2] = xlsread(S_file_T,'08jan08');
[~,~,small_quote_raw_data_day2] = xlsread(S_file_Q,'08jan08');

[~,~,small_trade_raw_data_day3] = xlsread(S_file_T,'09jan08');
[~,~,small_quote_raw_data_day3] = xlsread(S_file_Q,'09jan08');

[~,~,small_trade_raw_data_day4] = xlsread(S_file_T,'10jan08');
[~,~,small_quote_raw_data_day4] = xlsread(S_file_Q,'10jan08');

[~,~,small_trade_raw_data_day5] = xlsread(S_file_T,'11jan08');
[~,~,small_quote_raw_data_day5] = xlsread(S_file_Q,'11jan08');
toc
%
% 5 days data for medium
%
M  = {'CETV','FCN','LSTR','LPNT','CKH'};
MM = M{5};
M_file_T = strcat(MM,'_trade_07_11jan08.xlsx');
M_file_Q = strcat(MM,'_quote_07_11jan08.xlsx');
%
tic
[~,~,med_trade_raw_data_day1] = xlsread(M_file_T,'07jan08');
[~,~,med_quote_raw_data_day1] = xlsread(M_file_Q,'07jan08');

[~,~,med_trade_raw_data_day2] = xlsread(M_file_T,'08jan08');
[~,~,med_quote_raw_data_day2] = xlsread(M_file_Q,'08jan08');

[~,~,med_trade_raw_data_day3] = xlsread(M_file_T,'09jan08');
[~,~,med_quote_raw_data_day3] = xlsread(M_file_Q,'09jan08');

[~,~,med_trade_raw_data_day4] = xlsread(M_file_T,'10jan08');
[~,~,med_quote_raw_data_day4] = xlsread(M_file_Q,'10jan08');

[~,~,med_trade_raw_data_day5] = xlsread(M_file_T,'11jan08');
[~,~,med_quote_raw_data_day5] = xlsread(M_file_Q,'11jan08');
toc
%
L  = {'AMZN','AMAT','DIS','GPS','GOOG'};
LL = L{5};
L_file_T = strcat(LL,'_trade_07_11jan08.xlsx');
L_file_Q = strcat(LL,'_quote_07_11jan08.xlsx');
%
tic
[~,~,large_trade_raw_data_day1] = xlsread(L_file_T,'07jan08');
[~,~,large_quote_raw_data_day1] = xlsread(L_file_Q,'07jan08');

[~,~,large_trade_raw_data_day2] = xlsread(L_file_T,'08jan08');
[~,~,large_quote_raw_data_day2] = xlsread(L_file_Q,'08jan08');

[~,~,large_trade_raw_data_day3] = xlsread(L_file_T,'09jan08');
[~,~,large_quote_raw_data_day3] = xlsread(L_file_Q,'09jan08');

[~,~,large_trade_raw_data_day4] = xlsread(L_file_T,'10jan08');
[~,~,large_quote_raw_data_day4] = xlsread(L_file_Q,'10jan08');

[~,~,large_trade_raw_data_day5] = xlsread(L_file_T,'11jan08');
[~,~,large_quote_raw_data_day5] = xlsread(L_file_Q,'11jan08');
toc
%% Step 2. data cleansing
% 'approx' group
%% 
tic
[small_Trade,small_QuoteRevision,~,~,small_average,small_individual] ...
    = DataCombiner(small_trade_raw_data_day1, small_quote_raw_data_day1,...
    small_trade_raw_data_day2, small_quote_raw_data_day2,...
    small_trade_raw_data_day3, small_quote_raw_data_day3,...
    small_trade_raw_data_day4, small_quote_raw_data_day4,...
    small_trade_raw_data_day5, small_quote_raw_data_day5, 'approx',strcat(SS,'_approx'),SS,'small');
toc
%
tic
[med_Trade_A,med_QuoteRevision,~,~,med_average,med_individual] ...
    = DataCombiner(med_trade_raw_data_day1, med_quote_raw_data_day1,...
    med_trade_raw_data_day2, med_quote_raw_data_day2,...
    med_trade_raw_data_day3, med_quote_raw_data_day3,...
    med_trade_raw_data_day4, med_quote_raw_data_day4,...
    med_trade_raw_data_day5, med_quote_raw_data_day5, 'approx',strcat(MM,'_approx'),MM,'medium');
toc
%
tic
[large_Trade,large_QuoteRevision,~,~,large_average,large_individual] ...
    = DataCombiner(large_trade_raw_data_day1, large_quote_raw_data_day1,...
    large_trade_raw_data_day2, large_quote_raw_data_day2,...
    large_trade_raw_data_day3, large_quote_raw_data_day3,...
    large_trade_raw_data_day4, large_quote_raw_data_day4,...
    large_trade_raw_data_day5, large_quote_raw_data_day5, 'approx',strcat(LL,'_approx'),LL,'large');
toc
%%
% 'real' group
%% 
tic
[small_Trade_R,small_QuoteRevision_R,small_SumStatsTrade,small_SumStatsQuote] ...
    = DataCombiner(small_trade_raw_data_day1, small_quote_raw_data_day1,...
    small_trade_raw_data_day2, small_quote_raw_data_day2,...
    small_trade_raw_data_day3, small_quote_raw_data_day3,...
    small_trade_raw_data_day4, small_quote_raw_data_day4,...
    small_trade_raw_data_day5, small_quote_raw_data_day5, 'real',strcat(SS,'_real'),'','');
toc
%
tic
[med_Trade_R,med_QuoteRevision_R,med_SumStatsTrade,med_SumStatsQuote]...
    = DataCombiner(med_trade_raw_data_day1, med_quote_raw_data_day1,...
    med_trade_raw_data_day2, med_quote_raw_data_day2,...
    med_trade_raw_data_day3, med_quote_raw_data_day3,...
    med_trade_raw_data_day4, med_quote_raw_data_day4,...
    med_trade_raw_data_day5, med_quote_raw_data_day5, 'real',strcat(MM,'_real'),'','');
toc
%
tic
[large_Trade_R,large_QuoteRevision_R,large_SumStatsTrade,large_SumStatsQuote] ...
    = DataCombiner(large_trade_raw_data_day1, large_quote_raw_data_day1,...
    large_trade_raw_data_day2, large_quote_raw_data_day2,...
    large_trade_raw_data_day3, large_quote_raw_data_day3,...
    large_trade_raw_data_day4, large_quote_raw_data_day4,...
    large_trade_raw_data_day5, large_quote_raw_data_day5, 'real',strcat(LL,'_real'), '','');
toc


%% Step 3. Summary Stats with trading time raw data (before data cleansing)
%%
tic
[small_SumTradeRaw,small_SumQuoteRaw] ...
    = SumStatsRaw(small_trade_raw_data_day1, small_quote_raw_data_day1,...
    small_trade_raw_data_day2, small_quote_raw_data_day2,...
    small_trade_raw_data_day3, small_quote_raw_data_day3,...
    small_trade_raw_data_day4, small_quote_raw_data_day4,...
    small_trade_raw_data_day5, small_quote_raw_data_day5,strcat(SS,'_SumStatsRaw'));
toc
%
tic
[med_SumTradeRaw,med_SumQuoteRaw] ...
    = SumStatsRaw(med_trade_raw_data_day1, med_quote_raw_data_day1,...
    med_trade_raw_data_day2, med_quote_raw_data_day2,...
    med_trade_raw_data_day3, med_quote_raw_data_day3,...
    med_trade_raw_data_day4, med_quote_raw_data_day4,...
    med_trade_raw_data_day5, med_quote_raw_data_day5,strcat(MM,'_SumStatsRaw'));
toc
%
tic
[large_SumTradeRaw,large_SumQuoteRaw] ...
    = SumStatsRaw(large_trade_raw_data_day1, large_quote_raw_data_day1,...
    large_trade_raw_data_day2, large_quote_raw_data_day2,...
    large_trade_raw_data_day3, large_quote_raw_data_day3,...
    large_trade_raw_data_day4, large_quote_raw_data_day4,...
    large_trade_raw_data_day5, large_quote_raw_data_day5,strcat(LL,'_SumStatsRaw'));
toc
%% Load SumStatsRaw
name  = {'BW','CDR','MOD','NXTM','PBH','CETV','FCN','LSTR','LPNT','CKH',...
    'AMZN','AMAT','DIS','GPS','GOOG'};
index = 15;
load(strcat(name{index},'_SumStatsRaw'));

