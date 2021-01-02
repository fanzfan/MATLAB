% 使用蒙特卡罗算法估计 8PSK 误码率和误比特率
% 并与 QPSK 相关结果比较

% 8PSK
M = 8;
% 码元长度
k = log2(M);
% 数据点个数
dataNum = 500000;

% 均匀随机数生成信源信号
oriSignal = randi([0 M - 1], 1, dataNum);
oriSignal2 = randi([0 3], 1, dataNum);
% 将均匀随机数 8psk 调制，使用格雷码映射，为符合实验要求，设置参考相位为 pi/8
modSignal = PSKModulate(oriSignal, M, pi / M);
% 将均匀随机数 qpsk 调制，使用格雷码映射，为符合实验要求，设置参考相位为 0
modSignal2 = PSKModulate(oriSignal2, 4, 0);
% Eb/No，分贝形式
EbNodB = -10:0.5:10;

% 8PSK 实际 BER ， 先建立数组准备存储结果
realBER = zeros(length(EbNodB));
realBER2 = realBER;
% 8PSK 实际 SER ， 先建立数组准备存储结果
realSER = zeros(length(EbNodB));
realSER2 = realSER;

for index = 1:length(EbNodB)
    % 8PSK通过 AWGN 信道后接收到的信号
    receiveSignal = AddGaussWhiteNoise(EbNodB(index), modSignal, 8);
    % 8PSK解调，使用格雷码映射
    demodSignal = PSKDemodulate(receiveSignal, M, pi / 8);
    % 8PSK存储实际 BER
    [~, realBER(index)] = ErrRate(oriSignal, demodSignal,'ber');
    % 8PSK存储实际 SER
    [~, realSER(index)] = ErrRate(oriSignal, demodSignal, 'ser');
    % QPSK通过 AWGN 信道后接收到的信号
    receiveSignal2 = AddGaussWhiteNoise(EbNodB(index), modSignal2, 4);
    % QPSK解调，使用格雷码映射, 最小距离判决法
    demodSignal2 = PSKDemodulate(receiveSignal2, 4, 0, 'closest');
    % QPSK存储实际 BER
    [~, realBER2(index)] = ErrRate(oriSignal2, demodSignal2,'ber');
    % QPSK存储实际 SER
    [~, realSER2(index)] = ErrRate(oriSignal2, demodSignal2,'ser');
end

% 8PSK 计算理论误比特率和误码率
ser8 = 2 * qfunc(sqrt(2 * 10.^(EbNodB / 10) * log2(M)) * sin(pi / M));
% 根据 ber = ser / log2(M)计算误比特率
ber8 = ser8 / log2(M);
% 8PSK BER理论结果展示
semilogy(EbNodB, ber8);
hold on
% QPSK 计算理论误比特率和误码率
serQ = 2 * qfunc(sqrt(2 * 10.^(EbNodB / 10) * log2(4)) * sin(pi / 4));
berQ = qfunc(sqrt(2 * 10.^(EbNodB / 10)));
% QPSK BER理论结果展示
semilogy(EbNodB, berQ);
% 8PSK展示实际 BER
semilogy(EbNodB, realBER, 'r*')
% QPSK展示实际 BER
semilogy(EbNodB, realBER2, 'b*')
grid on
title({'Plot', [num2str(dataNum), '数据点 BER  最小距离法']})
legend('8PSK理论BER', 'QPSK理论BER', '8PSK实际BER', 'QPSK实际BER')
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('BER')

% SER理论结果展示
figure(2)
% 8PSK SER理论结果展示
semilogy(EbNodB, ser8);
hold on
% QPSK SER理论结果展示
semilogy(EbNodB, serQ);
% 8PSK展示实际 SER
semilogy(EbNodB, realSER, 'r*')
% QPSK展示实际 SER
semilogy(EbNodB, realSER2, 'b*')
grid on
title({'Plot', [num2str(dataNum), '数据点 SER  最小距离法']})
legend('8PSK理论SER', 'QPSK理论SER', '8PSK实际SER', 'QPSK实际SER')
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('SER')

%END
