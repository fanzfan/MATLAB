%% 变量声明
close all;clear all;
% M = 4，代表QPSK
M = 4;
% 数据点个数
len = 5000000;
% 随机生成的原始数据
data = randi([0 M - 1], 1, len);
data = de2bi(data, 'left-msb');
data = resize(data, [], 4);
Hamming_Frame = len / 4;
% 信噪比范围 (dB)
EbN0dB = -10:0.5:10;
errRate = zeros(1, length(EbN0dB));

%% 计算理论误码率
% 无信道纠错
berQ = qfunc(sqrt(2 * 10.^(EbN0dB / 10)));
% 理论结果展示
semilogy(EbN0dB, berQ, 'LineWidth', 1);
hold on

%% 理论计算
% EbN0转换，为了适应校验位的加入，EbN0需要一点变化
EbN0dB_Hamming = log10(10.^(EbN0dB / 10) * (7/4)) * 10;
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
code = Hamming_Encoder(G, data);
% 调制
tempCode = resize(code', 2, [])';
tempCode = bi2de(tempCode, 'left-msb');
modSig = PSKMod(tempCode, M, 0);

errC = @(err) 1 - err;
for i = 1:length(EbN0dB_Hamming)
    recSig = AWGN2(EbN0dB_Hamming(i), modSig, M);
    recData = PSKDemod(recSig, M, 0);
    recData = de2bi(recData, 'left-msb');
    recData = resize(recData', 7, [])';
    % 最终得到的数据
    finData = Hamming_Decoder(H, recData);
    [~, errRate(i)] = ErrRate(data, finData);
end


% 绘出误比特率数据
semilogy(EbN0dB, errRate, '*-', 'LineWidth', 1);
grid on
title({'Plot', [num2str(len), '汉明码编码仿真结果']})
legend('QPSK 理论结果', '(7, 4)汉明码 QPSK')
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('BER (对数坐标)')