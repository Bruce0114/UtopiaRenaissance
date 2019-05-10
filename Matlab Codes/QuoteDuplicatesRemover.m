%1. This Function removes the quote duplicates
%2. If, after a quote revision, the subsequent quotes remain unchanged as
%   time goes by, the initial quote revision is kept and the rest quote
%   duplicates are remove
%3. Note that the input needs to be in 'raw data' form

function DataNoDuplicates = QuoteDuplicatesRemover(quote_raw_data)

QuoteData             = TradingTimeData(quote_raw_data,1);
LengthData            = length(QuoteData);

DataNoDuplicates      = zeros(length(QuoteData),3); %preallocation

DataNoDuplicates(1,:) = QuoteData(1,:);

j = 2;

for i = 2:LengthData
    if QuoteData(i,2)~= QuoteData(i-1,2) ||...
            QuoteData(i,3) ~= QuoteData(i-1,3)
        
        DataNoDuplicates(j,:) = QuoteData(i,:);
        j = j + 1;
    end
end

DataNoDuplicates(j:end,:) = []; %variable size reduction

end