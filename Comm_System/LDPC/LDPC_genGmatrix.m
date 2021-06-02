%% 生成 CCSDS 标准的 生成矩阵 G
% H：对应的校验矩阵， M：子矩阵维度
% inf_Rate：编码效率
function [Gqc] = LDPC_genGmatrix(H, M, inf_Rate)
    switch (inf_Rate)
        case 1/2
            K = 2;
        case 2/3
            K = 4;
        case 4/5
            K = 8;
    end
    % 矩阵P, Q, W
    P = H(1:3 * M - 1, end - 3 * M + 2:end);
    Q = H(1:3 * M - 1, 1:M * K);
    W = mod((mod(inv(P), 2) * Q), 2)';
    IMK = eye(M * K);
    OMK = zeros(M * K, 1);
    G = [IMK OMK W];

    rowNum = 1:M / 4:1 + M * K - M / 4;
    Gqc = zeros(size(G));
    Gqc(rowNum, :) = G(rowNum, :);

    % 循环移位
    for m = 1:4 * K + 12
        for n = 1:M / 4 - 1
            Gqc(rowNum + n, M / 4 * (m - 1) + 1:M / 4 * m) = circshift(Gqc(rowNum, M / 4 * (m - 1) + 1:M / 4 * m), n, 2);
        end
    end

    % 展示生成矩阵Gqc
    figure
    gridG = zeros(size(Gqc));
    gridG(M:M:(K-1)*M,:) = 1;
    gridG(:,M:M:(K+2)*M) = 1;
    spy(gridG,'r',4);
    hold on;
    spy(Gqc);
    title('Generator Matrix');
    hold off;
end
