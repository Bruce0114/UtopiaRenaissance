%1. This function removes leading zeros in military time string for quotes data
%2. Note that the input needs to be in 'raw data' form
%3. The output is a column vector of transformed time stamp

function military_time = LeadingZeroRemover(quote_raw_data)

military_time  = zeros(length(quote_raw_data)-1,1);

for i = 2:length(quote_raw_data)
    military_time(i-1) = str2double(quote_raw_data{i,2});
end

end