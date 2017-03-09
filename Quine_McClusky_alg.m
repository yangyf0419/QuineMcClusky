%------------------------------------------------------------------------
%Quine_McClusky_alg
%Using Quine McClusky Algorithms to display 10-bit minimized logic 
%expression of a set of minterms
%usage:
%expressions    =    Quine_McClusky_alg(minterms,urltminterms)
%expressions    -   [OUT] a M * 10 matrix of minimized logic expressions,
%                   each row is a vector of 10-bit binary terms
%minterms       -   [IN] a vector of minterms in decimal form
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------

function expressions = Quine_McClusky_alg(mtm,urlmtm)
    % ----- initialization -----
    mtm_bin     =   zeros(length(mtm)+length(urlmtm),10); % minterms in binary form
    % ----- transformation -----
    for i = 1:length(mtm)
        mtm_bin(i,:)    =   decimalToBinaryVector(mtm(i),10); % transform decimal minterms into binary
    end
    for i = 1:length(urlmtm)
        mtm_bin(length(mtm)+i,:)   =   decimalToBinaryVector(urlmtm(i),10);
    end
    % ----- get prime implicants -----
    [counts, partitions]    =   partition(mtm_bin); % devide minterms into groups by it's number of 1
    prm_imps    =   find_prm_imp(mtm_bin,counts,partitions); % get prime implicants
    prm_imps    =   unique(prm_imps,'rows');
    prm_imps    =   flipud(prm_imps);
    % ----- determine essential prime implicants -----
    mtm_bin     =   mtm_bin(1:length(mtm),:); % dispose unrelated minterms
    has_ess     =   zeros(1,length(mtm)); % whether a minterm has essential prime implicants
    imps        =   zeros(length(mtm),10);
    for i = 1:length(mtm)
        for j = 1:size(prm_imps,1)
            if match(mtm_bin(i,:),prm_imps(j,:))
                if has_ess(i) == 0
                    has_ess(i) = 1;
                    imps(i,:) = prm_imps(j,:);
                elseif has_ess(i) == 1
                    has_ess(i) = 0;
                    break;
                end
            end
        end
    end
    has_ess = logical(has_ess);
    % ----- remove implied minterms -----
    expressions = unique(imps(has_ess,:),'rows'); % add the essential prime implicants
    mtm_bin(has_ess,:) = []; % remove implied minterms
    implied = zeros(1,size(mtm_bin,1));
    for i = 1:size(mtm_bin,1)
        if imply(mtm_bin(i,:),expressions) % a minterm could be implied by current expressions
            implied(i) = 1;
        end
    end
    mtm_bin(logical(implied),:) = [];
    for i = 1:size(expressions,1)
        prm_imps = del(prm_imps, expressions(i,:)); % remove essential prime implicants
    end
    % ----- find least implicants sets -----
    terms = size(prm_imps,1);
    current_best = prm_imps;
    for i = 1:2^terms - 1
        flag = 1;
        set = prm_imps(logical(decimalToBinaryVector(i,terms)),:);
        for j = 1:size(mtm_bin,1)
            if ~imply(mtm_bin(j,:),set)
                flag = 0;
                break;
            end
        end
        if flag && (size(set,1) < size(current_best,1))
            current_best = set;
        end
    end
    expressions = [expressions;current_best];   
% end function Quine_McClusky_alg
    
        

