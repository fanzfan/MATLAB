% 使用蒙特卡罗算法估计 QPSK 误码率

% QPSK
M = 4;
% 码元长度
k = log2(M);
% 数据点个数
dataNum = [1000 10000 100000];
% Eb/No，分贝形式
EbNodB = -10:0.5:10;

% 最小距离法计算
for j = 1:length(dataNum)
    % 均匀随机数生成信源信号
    oriSignal = randi([0 M - 1], 1, dataNum(j));
    % 将均匀随机数 psk 调制，使用格雷码映射，为符合实验要求，设置参考相位为 0
    modSignal = PSKModulate(oriSignal, M, 0);
    figure(j)
    % 计算理论误码率
    berQ = qfunc(sqrt(2 * 10.^(EbNodB / 10)));
    % 理论结果展示
    semilogy(EbNodB, berQ);
    xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
    ylabel('BER')
    hold on
    % 实际 BER ， 先建立数组准备存储结果
    realBER = zeros(length(EbNodB));
    realBER2 = zeros(length(EbNodB));
    
    for index = 1:length(EbNodB)
        % 通过 AWGN 信道后接收到的信号
        receiveSignal = AddGaussWhiteNoise(EbNodB(index), modSignal, 4);
        % QPSK解调，使用格雷码映射, 最小距离判决法
        demodSignal = PSKDemodulate(receiveSignal, M, 0, 'closest');
        % 存储实际 BER
        [~, realBER(index)] = ErrRate(oriSignal, demodSignal, 'ber');
    end
    
    % 展示实际 BER
    semilogy(EbNodB, realBER, 'r*')
    grid on
    title({'Plot', [num2str(dataNum(j)), '数据点 BER  最小距离法']})
    legend('理论结果', '实际结果')
end

% 最大投影点法计算
% 展示实际 BER
figure(j + 1)
% 计算理论误码率
berQ = qfunc(sqrt(2 * 10.^(EbNodB / 10)));
% 理论结果展示
semilogy(EbNodB, berQ);
grid on
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('BER')
hold on
% 最大投影点法计算
for index = 1:length(EbNodB)
    % 通过 AWGN 信道后接收到的信号
    receiveSignal = AddGaussWhiteNoise(EbNodB(index), modSignal, 4);
    % QPSK解调，使用格雷码映射, 最大投影点法
    demodSignal = PSKDemodulate(receiveSignal, M, 0, 'maxProPoint');
    % 存储实际 BER
    [~, realBER(index)] = ErrRate(oriSignal, demodSignal, 'ber');
end

semilogy(EbNodB, realBER, 'r*')
grid on
title({'Plot', [num2str(dataNum(j)), '数据点 BER 最大投影点法']})
legend('理论结果', '实际结果')

%END
