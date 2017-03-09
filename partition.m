%------------------------------------------------------------------------
%partition
%Partition minterms into groups by the number of 1s in it's bin vector
%usage:
%[counts, partitions]   =   partition(minterms)
%counts         -   [OUT] 1 * 11 vector which shows size of each group
%partitions     -   [OUT] a M * 10 * 11 matrix of partitions
%                   M   - maxium size of each group
%                   each row is a vector of 10-bit binary terms
%                   each layer is correspond to no 1 to ten 1 in a minterm
%minterms       -   [IN] a M * 10 matrix of minimized logic expressions,
%                   each row is a vector of 10-bit binary terms
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------

function [counts, partitions] = partition(minterms)
    counts  =   zeros(1,11);
    partitions  =   zeros([],10,11);
    for i = 1:size(minterms,1)
        one_ct  =   norm(minterms(i,:),1) + 1; % counts of one plus one
        counts(one_ct)  =   counts(one_ct) + 1;
        partitions(counts(one_ct),:,one_ct)     =   minterms(i,:);
    end
% end funtion partition