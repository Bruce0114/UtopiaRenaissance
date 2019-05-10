%1. This function removes the trade and quote observations occurred before
%   9.30am and after 4.00pm, at which market opens and closes respectively
%2. If trades data enters the function, datatype = 0
%   If quotes data enters the function, datatype = 1
%3. Note that the input needs to be in 'raw data' form

function output = TradingTimeData(raw_data,datatype)



% for quotes data
if datatype == 1
    LengthQuoteRaw   = length(raw_data);
    MilitaryTimeData = LeadingZeroRemover(raw_data);
    LengthData       = numel(MilitaryTimeData);
    output           = zeros(LengthData,3);
    output(:,1)      = MilitaryTimeData;
    
    for i = 2:LengthQuoteRaw
        output(i-1,2) = raw_data{i,3}; % bid quote
        output(i-1,3) = raw_data{i,4}; % ask quote
    end
    
    for start = 1:LengthData
        if output(start,1) >= 93000000
            break % include the quote observation AT 9.30am by using '>='
        end
    end
    
    for terminal = 1:LengthData
        if terminal ~= LengthData
            if output(terminal,1) >= 160000000
                output = output(start:terminal-1,:);
                break
            end
        else % the case when terminal runs to the END of the series
            if output(terminal,1) >= 160000000
                output = output(start:terminal-1,:);
            else % include the LAST observation if it occurs BEFORE 4.00pm
                output = output(start:terminal,:);
            end
        end
    end
    
    %for trades data
elseif datatype == 0
    MilitaryTimeData = TradeSignAdder(raw_data); % add sign to each trade
    LengthData       = length(MilitaryTimeData);
    
    for start = 1:LengthData
        if MilitaryTimeData(start,1) > 93000000
            break % do NOT include the trade observation AT 9.30am
        end
    end
    
    for terminal = 1:LengthData
        if terminal ~= LengthData
            if MilitaryTimeData(terminal,1) >= 160000000
                output = MilitaryTimeData(start:terminal-1,:);
                break
            end
        else % the case when terminal runs to the END of the series
            if MilitaryTimeData(terminal,1) >= 160000000
                output = MilitaryTimeData(start:terminal-1,:);
            else % include the LAST observation if it occurs BEFORE 4.00pm
                output = MilitaryTimeData(start:terminal,:);
            end
        end
    end
    
else
    error('datatype should be either 1 or 0')
    
end

end