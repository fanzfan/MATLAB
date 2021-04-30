%% 变量声明
% M = 4，代表QPSK
M = 4;
% 数据点个数
len = 50000;
% 随机生成的原始数据
data = randi([0 M - 1], 1, len);
data = de2bi(data, 'left-msb');
data = resize(data, [], 4);
% 信噪比范围 (dB)
EbN0dB = 0:0.5:10;
errRate = zeros(1, length(EbN0dB));

%% 计算理论误码率
% 无信道纠错
berQ = qfunc(sqrt(2 * 10.^(EbN0dB / 10)));
% 理论结果展示
semilogy(EbN0dB, berQ, 'LineWidth', 1);
hold on
% % 汉明码纠错
% berQ = (16 - 1) *qfunc(sqrt(3 * 2 * 10.^((EbN0dB - 1) / 10)));
% % 理论结果展示
% semilogy(EbN0dB, berQ, 'LineWidth', 1);

%% 理论计算
% EbN0转换，为了适应校验位的加入，EbN0需要一点变化
EbN0dB2 = log10(10.^(EbN0dB / 10) * (7/4)) * 10;
% 监督矩阵H
H = [1 1 1 0 1 0 0
    1 1 0 1 0 1 0
    1 0 1 1 0 0 1];
% 生成矩阵G
G = [1 0 0 0 1 1 1
    0 1 0 0 1 1 0
    0 0 1 0 1 0 1
    0 0 0 1 0 1 1];
% 汉明编码后序列
dataHamming = bitand(data * G, 1);
% 调制
tempData = resize(dataHamming', 2, [])';
tempData = bi2de(tempData, 'left-msb');
modSig = PSKMod(tempData, M, 0);

errC = @(err) 1 - err;
for i = 1:length(EbN0dB2)
    recSig = AWGN2(EbN0dB2(i), modSig, M);
    recData = PSKDemod(recSig, M, 0);
    recData = de2bi(recData, 'left-msb');
    recData = resize(recData', 7, [])';
    % 校验子 S
    S = bitand(H * recData', 1)';
    S = bi2de(S, 'left-msb');
    % 校验过程
    for j = 1:length(S)
        if (S(j) > 0)
            recData(j, 8 - S(j)) = -recData(j, 8 - S(j)) + 1;
        end
    end
    % 最终得到的数据
    finData = recData(:, 1:4);
    [~, errRate(i)] = ErrRate(data, finData);
end

% 绘出误比特率数据
semilogy(EbN0dB, errRate, '*-', 'LineWidth', 1);
grid on
title({'Plot', [num2str(len), '汉明码编码仿真结果']})
legend('QPSK 理论结果', '(7, 4)汉明码 QPSK')
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('BER (对数坐标)')