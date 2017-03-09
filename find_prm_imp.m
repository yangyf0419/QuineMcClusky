%------------------------------------------------------------------------
%find_prm_imp
%Display prime implicants of a group of minterms
%usage:
%prime_implicants   =    find_prm_imp(counts,partitions)
%prime_implicants   -   [OUT] a K * 10 matrix of prime implicants
%                   1 and 0 are corresponding with binary expressions
%                   -1 means both one or zero are contained
%implicants         -   [IN] K * 10 matrix of implicants
%counts             -   [IN] 1 * N vector which shows size of each group
%partitions         -   [IN] a M * 10 * N matrix of partitions
%                   M   - maxium size of each group
%                   each row is a vector of 10-bit binary terms
%                   each layer is correspond to no 1 to ten 1 in a minterm
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------

function prime_implicants   =    find_prm_imp(implicants,counts,partitions)
    %----- initialization ---------
    new_prt     =   zeros([],10,size(partitions,3)-1); % new partitions
    new_ct   =   zeros(1,size(partitions,3)-1); % new counts
    new_imp     =   zeros([],10); % new inplicants
    count   =   0; % count of new implicants
    
    for i = 1:size(partitions,3)-1 % index of groups
        for j = 1:counts(i)
            for k = 1:counts(i+1) % choose neighboring groups
                diff    =   partitions(j,:,i) - partitions(k,:,i+1); % different bits
                if norm(diff,1) == 1 % only one bit is different
                    count = count + 1; % one more implicant
                    newterm = partitions(j,:,i);
                    newterm(logical(diff)) = -1; % -1 is a wildcard
                    group = sum(newterm == 1) + 1;
                    new_ct(group) = new_ct(group) + 1;
                    new_prt(new_ct(group),:,i) = newterm;
                    new_imp(count,:) = newterm;
                    implicants = del(implicants,partitions(j,:,i));
                    implicants = del(implicants,partitions(k,:,i+1));
                end
            end
        end
    end
    if size(new_imp,1)
        prime_implicants    =   [implicants;find_prm_imp(new_imp,new_ct,new_prt)];
    else
        prime_implicants    =   implicants;
    end
% end function find_prm_imp
                    
                    

