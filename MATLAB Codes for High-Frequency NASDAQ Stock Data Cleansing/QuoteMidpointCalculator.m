%1. This functions calculates the mid point of quoted bid and ask spread
%2. Note that the input needs to be in 'raw data' form

function LogQuoteMidpoint = QuoteMidpointCalculator(quote_raw_data)

LogQuoteMidpoint     = QuoteDuplicatesRemover(quote_raw_data);

LogQuoteMidpoint(:,2)= log(0.5*(LogQuoteMidpoint(:,2)+LogQuoteMidpoint(:,3)));

LogQuoteMidpoint(:,3)= [];

end