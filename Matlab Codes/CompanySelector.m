% 1. This function rearranges the 'company name.xlsx' to categorise the
% companies into large, medium and small cap groups and RANDOMLY selects n
% companies from each group with 'n' specified by user
% 2. The content in the raw data has to be the following form before enter
% the function:
%    a. the data is a column vector with both numbers and strings
%    b. the order of each company's information should be company name,
%    followed by company stock ticker, which is in turn followed by number
%    1, 2 or 3, where 1 for large cap, 2 for medium and 3 for small

function [large,medium,small] = CompanySelector(raw_data,n)

LengthData  = length(raw_data);
large       = cell(n,1);
medium      = cell(n,1);
small       = cell(n,1);
largeGroup  = {};
mediumGroup = {};
smallGroup  = {};
Lcount      = 1;
Mcount      = 1;
Scount      = 1;
% 1. categorise companies into large, medium and small group
for i = 1:LengthData
    if raw_data{i} == 1
        largeGroup{Lcount} = raw_data([i-2,i-1]);
        Lcount = Lcount + 1;
    elseif raw_data{i} == 2
        mediumGroup{Mcount} = raw_data([i-2,i-1]);
        Mcount = Mcount + 1;
    elseif raw_data{i} == 3
        smallGroup{Scount} = raw_data([i-2,i-1]);
        Scount = Scount + 1;
    end
    
end

% 2. random select n company for each group

% large
Length = length(largeGroup);
index  = randsample(Length,n); % randomly generate 5 integers between 1 and 
                               % n WITHOUT replacement
large  = largeGroup(index);
% medium
Length = length(mediumGroup);
index  = randsample(Length,n);
medium = mediumGroup(index);
% small
Length = length(smallGroup);
index  = randsample(Length,n);
small  = smallGroup(index);

end