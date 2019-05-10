% [CombinedTradeData,CombinedQuoteData,SumStatsTrade,SumStatsQuote,...
%     average,individual] ...
%     = DataCombiner(trade_raw_data_day1, quote_raw_data_day1,...
%     trade_raw_data_day2, quote_raw_data_day2,...
%     trade_raw_data_day3, quote_raw_data_day3,...
%     trade_raw_data_day4, quote_raw_data_day4,...
%     trade_raw_data_day5, quote_raw_data_day5,type,filename,legendname,Save)
%1. This function combines five days trading data together to generate a
%   complete and usable series ready to perform the VAR estimation
%2. Note that the input needs to be in 'raw data' form
%3. Type = 'real' if the output trade series is real-time-data signed
%        = 'approx' if the output trade series is approximated signed
%4. The output variables are also stored in a .mat file (in a struc
%   structure) in the current folder with user specified filename; use ''
%   as placeholder if the user does not save the outputs
%5. The following outputs can be generated if type = 'approx'
%   5.1. 'average' is 6-by-2 cell array that contains:
%   a. apcor  = average % of correct number of approximations across 5 trading days
%   b. apsign = average % of trades assigned as buys/sells across 5 trading days
%   c. apb    = average % of trades assigned as buys across 5 trading days
%   d. aps    = average % of trades assigned as sells across 5 trading days
%   e. arb    = average real % of buy trades across 5 trading days
%   e. arb    = average real % of sell trades across 5 trading days
%   5.2. 'individual' is 6-by-7 cell array that contains pcor, psign, pb,
%   ps, rb, rs figures for each trading day
%6. If Save = 'large' the figure is stored in current holder with name 'figure_large.png'
%           = 'medium' the figure is stored in current holder with name 'figure_medium.png'
%           = 'small' the figure is stored in current holder with name 'figure_small.png'
%7. legendname should be in string format
%8. SumStatsTrade,SumStatsQuote are summary statistics of the number of
%   trades and quotes each trading day using cleansed data

function [CombinedTradeData,CombinedQuoteData,SumStatsTrade,SumStatsQuote,...
    average,individual] ...
    = DataCombiner(trade_raw_data_day1, quote_raw_data_day1,...
    trade_raw_data_day2, quote_raw_data_day2,...
    trade_raw_data_day3, quote_raw_data_day3,...
    trade_raw_data_day4, quote_raw_data_day4,...
    trade_raw_data_day5, quote_raw_data_day5,type,filename,legendname,Save)

% Case 1. for real data signed input
if strcmpi('real',type)
    
    % cleanse the data for each individual trading day
    [TradeEventCountDay1,QuoteEventCountDay1] ...
        = EventCounter(trade_raw_data_day1, quote_raw_data_day1);
    [TradeEventCountDay2,QuoteEventCountDay2] ...
        = EventCounter(trade_raw_data_day2, quote_raw_data_day2);
    [TradeEventCountDay3,QuoteEventCountDay3] ...
        = EventCounter(trade_raw_data_day3, quote_raw_data_day3);
    [TradeEventCountDay4,QuoteEventCountDay4] ...
        = EventCounter(trade_raw_data_day4, quote_raw_data_day4);
    [TradeEventCountDay5,QuoteEventCountDay5] ...
        = EventCounter(trade_raw_data_day5, quote_raw_data_day5);
    
    % Case 2. for approximated data signed input
elseif strcmpi('approx',type)
    % cleanse the data for each individual trading day
    [TradeEventCountDay1,QuoteEventCountDay1,pcor1,psign1,pb1,ps1] ...
        = EventCounterApprox(trade_raw_data_day1, quote_raw_data_day1);
    [TradeEventCountDay2,QuoteEventCountDay2,pcor2,psign2,pb2,ps2] ...
        = EventCounterApprox(trade_raw_data_day2, quote_raw_data_day2);
    [TradeEventCountDay3,QuoteEventCountDay3,pcor3,psign3,pb3,ps3] ...
        = EventCounterApprox(trade_raw_data_day3, quote_raw_data_day3);
    [TradeEventCountDay4,QuoteEventCountDay4,pcor4,psign4,pb4,ps4] ...
        = EventCounterApprox(trade_raw_data_day4, quote_raw_data_day4);
    [TradeEventCountDay5,QuoteEventCountDay5,pcor5,psign5,pb5,ps5] ...
        = EventCounterApprox(trade_raw_data_day5, quote_raw_data_day5);
    
    % calculate the average pcor, psign, pb and ps value
    apcor  = (pcor1 + pcor2 + pcor3 + pcor4 + pcor5)/5;
    apsign = (psign1 + psign2 + psign3 + psign4 + psign5)/5;
    apb    = (pb1 + pb2 + pb3 + pb4 + pb5)/5;
    aps    = (ps1 + ps2 + ps3 + ps4 + ps5)/5;
    
    % calculate the actual percentage of buy or sell on each trading data based
    % on real time data
    LengthTradeDay1 = length(trade_raw_data_day1);
    LengthTradeDay2 = length(trade_raw_data_day2);
    LengthTradeDay3 = length(trade_raw_data_day3);
    LengthTradeDay4 = length(trade_raw_data_day4);
    LengthTradeDay5 = length(trade_raw_data_day5);
    
    % day1
    countbuy  = 0;
    countsell = 0;
    for i = 2:LengthTradeDay1
        if strcmpi(trade_raw_data_day1{i,4},'B')
            countbuy = countbuy + 1;
        else
            countsell = countsell + 1;
        end
    end
    rb1  = countbuy/(LengthTradeDay1-1);
    rs1 = countsell/(LengthTradeDay1-1);
    % day2
    countbuy  = 0;
    countsell = 0;
    for i = 2:LengthTradeDay2
        if strcmpi(trade_raw_data_day2{i,4},'B')
            countbuy = countbuy + 1;
        else
            countsell = countsell + 1;
        end
    end
    rb2  = countbuy/(LengthTradeDay2-1);
    rs2 = countsell/(LengthTradeDay2-1);
    % day3
    countbuy  = 0;
    countsell = 0;
    for i = 2:LengthTradeDay3
        if strcmpi(trade_raw_data_day3{i,4},'B')
            countbuy = countbuy + 1;
        else
            countsell = countsell + 1;
        end
    end
    rb3  = countbuy/(LengthTradeDay3-1);
    rs3 = countsell/(LengthTradeDay3-1);
    % day4
    countbuy  = 0;
    countsell = 0;
    for i = 2:LengthTradeDay4
        if strcmpi(trade_raw_data_day4{i,4},'B')
            countbuy = countbuy + 1;
        else
            countsell = countsell + 1;
        end
    end
    rb4  = countbuy/(LengthTradeDay4-1);
    rs4 = countsell/(LengthTradeDay4-1);
    % day5
    countbuy  = 0;
    countsell = 0;
    for i = 2:LengthTradeDay5
        if strcmpi(trade_raw_data_day5{i,4},'B')
            countbuy = countbuy + 1;
        else
            countsell = countsell + 1;
        end
    end
    rb5  = countbuy/(LengthTradeDay5-1);
    rs5 = countsell/(LengthTradeDay5-1);
    % compute the average
    arb = (rb1+rb2+rb3+rb4+rb5)/5;
    ars = (rs1+rs2+rs3+rs4+rs5)/5;
    
    average      = cell(6,2);
    average(:,1) = {'apcor';'apsign';'apb';'aps';'arb';'ars'};
    average(:,2) = {apcor;apsign;apb;aps;arb;ars};
    
    individual          = cell(6,7);
    individual(2:6,1)     = {'day1';'day2';'day3';'day4';'day5'};
    individual(1,2:7)   = {'pcor','psign','pb','ps','rb','rs'};
    individual(2:6,2:7) = {pcor1,psign1,pb1,ps1,rb1,rs1;...
        pcor2,psign2,pb2,ps2,rb2,rs2;pcor3,psign3,pb3,ps3,rb3,rs3;...
        pcor4,psign4,pb4,ps4,rb4,rs4;pcor5,psign5,pb5,ps5,rb5,rs5};
    
    % Graphics:
    % plot five days pcor, psign, pb and ps
    plot_pcor  = [pcor1, pcor2, pcor3, pcor4, pcor5];
    plot_psign = [psign1, psign2, psign3, psign4, psign5];
    plot_pb    = [pb1, pb2, pb3, pb4, pb5];
    plot_ps    = [ps1, ps2, ps3, ps4, ps5];
    plot_actual_buy ...
        = [rb1,rb2,rb3,rb4,rb5];
    plot_actual_sell ...
        = [rs1,rs2,rs3,rs4,rs5];
    
    % define the position of legend on the screen (note that it may differ in
    % different sized computer screen)
    PositionCell    = cell(4,1);
    PositionCell(1) = {[.433,.895,.02,.05]};
    PositionCell(2) = {[.866,.895,.02,.05]};
    PositionCell(3) = {[.433,.43,.02,.01]};
    PositionCell(4) = {[.866,.43,.02,.01]};
    
    figure
    subplot(2,2,1),plot(plot_pcor);
    title('PCOR'), xlabel('trading day'), ylabel('percentage')
    leg=legend(legendname);
    set(leg,'Position',PositionCell{1})
    
    subplot(2,2,2),plot(plot_psign);
    title('PSIGN'), xlabel('trading day'), ylabel('percentage')
    leg=legend(legendname);
    set(leg,'Position',PositionCell{2})
    
    % actual percentage of buy/sell are plotted against the approximated ones
    subplot(2,2,3),plot(1:5,plot_pb,1:5,plot_actual_buy,'r');
    title('PB'), xlabel('trading day'), ylabel('percentage')
    leg=legend(strcat(legendname,' apx'),strcat(legendname,' real'));
    set(leg,'Position',PositionCell{3})
    
    subplot(2,2,4),plot(1:5,plot_ps,1:5,plot_actual_sell,'r');
    title('PS'), xlabel('trading day'), ylabel('percentage')
    leg=legend(strcat(legendname,' apx'),strcat(legendname,' real'));
    set(leg,'Position',PositionCell{4})
    
    % save the figure in .png format
    if strcmpi(Save,'') == 0
        if strcmpi(Save,'large')
            print -dpng -r500 figure_large
        elseif strcmpi(Save,'medium')
            print -dpng -r500 figure_medium
        elseif strcmpi(Save,'small')
            print -dpng -r500 figure_small
        end
    end
    
else
    error('type should be either real or approx')
    
end

% calculate the total length of the combined series
LengthCumsumTrade = cumsum([length(TradeEventCountDay1), ...
    length(TradeEventCountDay2), length(TradeEventCountDay3), ...
    length(TradeEventCountDay4), length(TradeEventCountDay5)]);
LengthCumsumQuote = cumsum([length(QuoteEventCountDay1), ...
    length(QuoteEventCountDay2), length(QuoteEventCountDay3), ...
    length(QuoteEventCountDay4), length(QuoteEventCountDay5)]);

% preallocation
CombinedTradeData = zeros(LengthCumsumTrade(end),1);
CombinedQuoteData = zeros(LengthCumsumQuote(end),1);

% trade series
CombinedTradeData(1:LengthCumsumTrade(1)) = TradeEventCountDay1;
CombinedTradeData(LengthCumsumTrade(1)+1:LengthCumsumTrade(2)) ...
    = TradeEventCountDay2;
CombinedTradeData(LengthCumsumTrade(2)+1:LengthCumsumTrade(3)) ...
    = TradeEventCountDay3;
CombinedTradeData(LengthCumsumTrade(3)+1:LengthCumsumTrade(4)) ...
    = TradeEventCountDay4;
CombinedTradeData(LengthCumsumTrade(4)+1:LengthCumsumTrade(5)) ...
    = TradeEventCountDay5;

% quote series
CombinedQuoteData(1:LengthCumsumQuote(1)) = QuoteEventCountDay1;
CombinedQuoteData(LengthCumsumQuote(1)+1:LengthCumsumQuote(2)) ...
    = QuoteEventCountDay2;
CombinedQuoteData(LengthCumsumQuote(2)+1:LengthCumsumQuote(3)) ...
    = QuoteEventCountDay3;
CombinedQuoteData(LengthCumsumQuote(3)+1:LengthCumsumQuote(4)) ...
    = QuoteEventCountDay4;
CombinedQuoteData(LengthCumsumQuote(4)+1:LengthCumsumQuote(5)) ...
    = QuoteEventCountDay5;

% remove the first observation in trade series
CombinedTradeData(1) = [];
% perform the first difference for log quote midpoint series
CombinedQuoteData    = CombinedQuoteData(2:end)-CombinedQuoteData(1:end-1);

% summary statistics of the number of trades and quotes

% for trade
TradeEventCountDay1(TradeEventCountDay1==0) = []; % remove zero entries
TradeEventCountDay2(TradeEventCountDay2==0) = [];
TradeEventCountDay3(TradeEventCountDay3==0) = [];
TradeEventCountDay4(TradeEventCountDay4==0) = [];
TradeEventCountDay5(TradeEventCountDay5==0) = [];

LT1 = numel(TradeEventCountDay1); % calculate the effective number of trades
LT2 = numel(TradeEventCountDay2);
LT3 = numel(TradeEventCountDay3);
LT4 = numel(TradeEventCountDay4);
LT5 = numel(TradeEventCountDay5);

SumStatsTrade      = cell(6,2);
SumStatsTrade(:,1) = {'Day1';'Day2';'Day3';'Day4';'Day5';'Total'};
SumStatsTrade(:,2) = {LT1;LT2;LT3;LT4;LT5;sum([LT1;LT2;LT3;LT4;LT5])};

% for quote
QT1 = numel(QuoteEventCountDay1); % calculate the effective number of trades
QT2 = numel(QuoteEventCountDay2);
QT3 = numel(QuoteEventCountDay3);
QT4 = numel(QuoteEventCountDay4);
QT5 = numel(QuoteEventCountDay5);

SumStatsQuote      = cell(6,2);
SumStatsQuote(:,1) = {'Day1';'Day2';'Day3';'Day4';'Day5';'Total'};
SumStatsQuote(:,2) = {QT1;QT2;QT3;QT4;QT5;sum([QT1;QT2;QT3;QT4;QT5])};


% save the combined series in a .mat file
if strcmpi(filename,'') == 0
    switch type
        case 'approx'
            AllData=struct('Trade',CombinedTradeData,'QuoteRevision',CombinedQuoteData,...
                'Average',{average},'Individual',{individual});
            save(filename,'-struct','AllData');
        case 'real'
            AllData=struct('Trade',CombinedTradeData,'QuoteRevision',CombinedQuoteData,...
                'SumStatsTrade',{SumStatsTrade},'SumStatsQuote',{SumStatsQuote});
            save(filename,'-struct','AllData');
    end
end

end