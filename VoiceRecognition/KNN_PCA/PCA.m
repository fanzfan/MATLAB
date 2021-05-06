% 一维PCA实现，这里将MEL谱得到的9维数据压缩成1维返回
% inputArg1：待处理的信息
% num：信息条数，也是文件个数
% mu：阈值设定
function [outputArg1] = PCA(inputArg1, num, mu)
    X = inputArg1;
    % 零均值化
    X_zeroMean = X - mean(X);
    % 协方差矩阵
    C = 1 / num * (X_zeroMean * X_zeroMean');
    % 求特征值与特征向量
    [V, D] = eig(C);
    [d, ind] = sort(diag(D), 'descend');
    % 根据阈值选择 降低的维数
    for k = 1:length(d)
        if (sum(d(1:k)) / sum(d) >= mu)
            break;
        end
    end

    Ds = D(ind, ind);
    Vs = V(:, ind);
    outputArg1 = Vs(:, k)' * X;
end
