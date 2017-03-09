%------------------------------------------------------------------------
%imply
%Determin whether a minterm could be implied by a set of implicants
%usage:
%implied = imply(minterm, prime_implicants)
%implied            -   [OUT] boolean
%minterm            -   [IN] 1 * 10 vector
%prime_implicants   -   [IN] K * 10 matrix
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------
function implied = imply(minterm, prime_implicants)
    implied = false;
    for i = 1:size(prime_implicants, 1)
        if match(minterm, prime_implicants(i,:))
            implied = true;
            break;
        end
    end
% end function imply