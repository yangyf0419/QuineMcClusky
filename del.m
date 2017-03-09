%------------------------------------------------------------------------
%del
%Delete a particular row from a matrix
%usage:
%modified  =   del(mat,row)
%modified  -   [OUT] (K - 1) * 10 matrix
%mat       -   [IN] K * 10 matrix
%row       -   [IN] 1 * 10 vector
%Author:
%   Yifei Yang
%   2015011089  @   Tsinghua University
%------------------------------------------------------------------------

function modified   =    del(mat,row)
    index = [];
    for i = 1:size(mat,1)
        if mat(i,:) == row
            index = i;
            break;
        end
    end
    mat(index,:) = [];
    modified = mat;
% end funtion del
