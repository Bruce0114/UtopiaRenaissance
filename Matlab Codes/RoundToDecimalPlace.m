%function x = RoundToDecimalPlace(x,n)
%This function "Round the scalar or matrix x to n decimal places"

function x = RoundToDecimalPlace(x,n)

x = round(x.*(10^n))./10^n;