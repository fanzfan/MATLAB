%% RESIZE 调整矩阵形状
% 改变矩阵的长宽，同时保持元素的相对顺序不变
function [output] = resize(input, sz1, sz2)
    siz = size(input);
    % 总长度
    len = siz(1) * siz(2);
    if (isempty(sz1))
        sz1 = len / sz2;
    end
    if (isempty(sz2))
        sz2 = len / sz1;
    end
    if (sz1 * sz2 < len)
        error('要求的维度不匹配');
    end
    % 预分配内存，加快速度
    output = zeros(sz1, sz2);
    for i = 1:len
        output(i) = input(i);
    end
end
