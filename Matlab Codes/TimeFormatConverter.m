%1. The function converts milliseconds-from-midnight time stamp format
%   to military time format for trades data
%2. Note that the input needs to be in 'raw data' form
%3. The output is a column vector of converted time stamp

function MilitaryTimeConverted = TimeFormatConverter(trade_raw_data)

LengthTradeRaw = length(trade_raw_data);

milliseconds   = zeros(LengthTradeRaw-1,1);
%
for i = 2:LengthTradeRaw
    milliseconds(i-1,1) = trade_raw_data{i,1};
end

TimeInHour   = milliseconds/3600000;
HourInteger  = floor(TimeInHour);
HourDecimal  = TimeInHour - HourInteger;
TimeInMinute = HourDecimal*60;
MinuteInteger= floor(TimeInMinute);
MinuteDecimal= TimeInMinute - MinuteInteger;
Milliseconds = round(MinuteDecimal*60*1000);
MilitaryTimeConverted = HourInteger*10000000 + MinuteInteger*100000 +...
    + Milliseconds;

end