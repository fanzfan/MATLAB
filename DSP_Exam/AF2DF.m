% 将 AF 转换至 DF 函数
% 利用冲激响应不变法求解
% c为输入分子项系数，d为输入分母项系数, T 为采样参数
% A 为输出分子系数，而 B 为输出分母系数
function [A, B] = AF2DF(c, d, T)
    [A, B, k] = residue(d, c);
    % 计算 z^-1 前的系数
    B = exp(B * T);
    % 合并分式，输出结果
    [A, B] = residue(A, B, k);
end
