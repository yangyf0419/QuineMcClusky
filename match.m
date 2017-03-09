%------------------------------------------------------------------------
%match
%Determin whether a prime implicant implies a minterm
%usage:
%matched  =   match(minterm,prime_implicant)
%matched            -   [OUT] boolean
%minterm            -   [IN] 1 * 10 vector
%prime_implicant    -   [IN] 1 * 10 vector
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------

function matched = match(minterm,prime_implicant)
    diff  =  prime_implicant(minterm ~= prime_implicant); % get different bits 
    matched = sum(diff) == - length(diff); % assure all the bits are -1
% end function match