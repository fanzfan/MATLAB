%% 生成 CCSDS 标准的 校验矩阵 H
% M：子矩阵维度
% inf_Rate：编码效率
function [H] = LDPC_genHmatrix(M, inf_Rate)

    % CCSDS 标准给出的参数表，决定了H中哪些列中元素不为0
    theta = [1	1	2	3	1	1	2	3	1	2	3	0	2	3	0	2	3	0	1	3	0	1	3	0	1	2];
    phi = [1787	1077	1753	697	1523	5	2035	331	1920	130	4	85	551	15	1780	1960	3	145	1019	691	132	42	393	502	201	1064
        1502	602	749	1662	1371	9	131	1884	1268	1784	19	1839	81	2031	76	336	529	74	68	186	905	1751	1516	1285	1597	1712
        1887	521	590	1775	1738	2032	2047	85	1572	78	26	298	1177	1950	1806	128	1855	129	269	1614	1467	1533	925	1886	2046	1167
        1291	301	1353	1405	997	2032	11	1995	623	73	1839	2003	2019	1841	167	1087	2032	388	1385	885	707	1272	7	1534	1965	588];

    Zm = zeros(M);
    Im = eye(M);
    L = 0:M - 1;

    % 生成PI矩阵
    for i = 1:26
        t_k = theta(i);
        f_4i_M = floor(4 * L / M);
        f_k = phi(f_4i_M + 1, i)';
        col_1 = M / 4 * (mod((t_k + f_4i_M), 4)) + ...
            mod((f_k + L), M / 4);
        row_col = col_1 + 1 + L * M;
        C_temp = zeros(M);
        C_temp(ind2sub([M, M], row_col)) = 1;
        PI{i} = C_temp';
    end

    % H矩阵
    H = [Zm Zm Zm Im (Im + PI{1})
        (Im + PI{8}) (Im + PI{7} + PI{6}) Zm Zm Im
        Zm Im (Im + PI{5}) Zm (PI{4} + PI{3} + PI{2})];
    switch (inf_Rate)
        case 1/2
            H = H;
            gridCol = 1:4;
        case 2/3
            H_23 = [Zm Zm; Im PI{11} + PI{10} + PI{9}; PI{14} + PI{13} + PI{12} Im];
            H = [H_23 H];
            gridCol = 1:6;
        case 4/5
            H_23 = [Zm Zm; Im PI{11} + PI{10} + PI{9}; PI{14} + PI{13} + PI{12} Im];
            H_45 = [Zm Zm Zm Zm; Im PI{23} + PI{22} + PI{21} Im PI{17} + PI{16} + PI{15}; ...
                    PI{26} + PI{25} + PI{24} Im PI{20} + PI{19} + PI{18} Im];
            H = [H_45 H_23 H];
            gridCol = 1:10;
    end

    % 展示校验矩阵 H
    figure;
    gridH = zeros(size(H));
    gridH([M,2*M],:) = 1;
    gridH(:,M*gridCol) = 1;
    spy(gridH,'r',4);
    hold on;
    spy(H);
    title('Check Matrix');
    hold off;

end
