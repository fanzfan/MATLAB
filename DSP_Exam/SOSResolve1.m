% 函数定义开始，输出为 E 和 F
function [E, F, G] = SOSResolve1(A, B)
    % 由于 roots 和 poly 函数执行过程中会自动对高次项系数归一化
    % 所以 G 就是 A 与 B 的首项元素之商
    G = A(1) / B(1);

    E1 = roots(A); % 求解 A 对应的多项式的根
    F1 = roots(B); % 求解 B 对应的多项式的根
    E1 = cplxpair(E1); % 将根排列
    F1 = cplxpair(F1); % 将根排列

    % 建立矩阵存放结果
    E = zeros(length(E1) / 2, 3);
    % 建立矩阵存放结果
    F = zeros(length(F1) / 2, 3);

    index = 1; % index ，作为存放位置的标记

    for i = 1:length(E1) - 1

        if mod(i, 2) == 0% 跳过偶数项，因为其已经与之前的奇数项配对
            continue;
        end

        % poly 函数获得二阶节矩阵 E 对应的项
        E(index, :) = poly([E1(i) E1(i + 1)]);
        index = index +1;
    end

    index = 1;

    for i = 1:length(F1) - 1

        if mod(i, 2) == 0% 跳过偶数项，因为其已经与之前的奇数项配对
            continue;
        end

        % poly 函数获得二阶节矩阵 F 对应的项
        F(index, :) = poly([F1(i) F1(i + 1)]);
        index = index + 1;
    end
end