% 函数定义开始，输出为 E 和 F
function [E, F, G] = SOSResolve (A, B)
    % 调用 tf2zp函数 将系数向量 A 和 B 转换成因式分解的形式
    [z, p, k] = tf2zp(A, B);
    % 调用 zp2sos 函数求解系统二阶节形式
    [sos, G] = zp2sos(z, p, k);
    % 返回二阶节系数，E 为分子系数， F为分母系数，C为首项常数
    E = [sos(:, 1) sos(:, 2) sos(:, 3)];
    F = [sos(:, 4) sos(:, 5) sos(:, 6)];
end
