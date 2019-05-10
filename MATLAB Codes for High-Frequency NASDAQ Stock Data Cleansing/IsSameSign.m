%1. This function checks if the two input variables have the same signs, i.e.
%   both positive or both negative
%2. It returns 1 if the two input variables have the same sign,
%              0 if not

function y = IsSameSign(variable1, variable2)
        
if variable1>0 && variable2>0 || variable1<0 && variable2<0
    y = 1;
else
    y = 0;
end

end