clc;clear all;close all;
%% 基本参数定义
k = 1024;
n = 2560;
m = n - k;
inf_Rate = 1/2;
EbN0dB = -10:0.1:10;
EbN0dB_LDPC = log10(10.^(EbN0dB / 10) / (inf_Rate)) * 10;
len = length(EbN0dB);
Max_IterNum = [1 5 10];
LDPC_err = zeros(1, len);
% 为了加快速度，这里直接使用已经计算出来的生成矩阵与校验矩阵
load 'G.mat'
load 'H.mat'
% H = LDPC_genHmatrix(M, inf_Rate);
% G = LDPC_genGmatrix(H, M, inf_Rate);


%% BPSK调制、解调
bpskMod = @(msg) 1 - 2 * msg;
bpskDemod = @(Signal) heaviside(-real(Signal));

%% 计算理论误码率
% 无信道纠错
BPSK_BER = qfunc(sqrt(2 * 10.^(EbN0dB / 10)));
%% 随机数产生、调制
dataLen = 1024 * 7 * 100;
LDPC_Frame = dataLen / 1024;

for k = Max_IterNum
    LDPC_err = zeros(1, len);
    % LDPC码仿真
    for i = 1:length(EbN0dB_LDPC)
        for j = 1 : LDPC_Frame
            LDPC_msg = randi([0 1],1, 1024);
            LDPC_code = LDPC_Encoder(G, LDPC_msg);
            LDPC_modSig = bpskMod(LDPC_code);
            LDPC_recSig = bpskAWGN(EbN0dB_LDPC(i), LDPC_modSig);
            [~, Y] = LDPC_Decoder(H, LDPC_recSig, k);
            LDPC_finData = Y(1:1024);
            [err, ~] =  ErrRate(LDPC_msg, LDPC_finData);
            LDPC_err(i) = LDPC_err(i) + err;
        end
    end
    LDPC_BER = LDPC_err / dataLen;
    save(['LDPC_BER_' num2str(k) '.csv'], 'LDPC_BER', '-ascii');
end

%% 绘图描述结果
semilogy(EbN0dB, BPSK_BER, 'LineWidth', 1)
hold on
semilogy(EbN0dB, LDPC_BER, '*-', 'LineWidth', 1)
xline(10*log10(log(2)), '--')
legend('bpsk理论', 'LDPC编码', '汉明码', '香农极限')

% save('BPSK_BER2.csv', 'BPSK_BER', '-ascii')
% save('LDPC_BER2.csv', 'LDPC_BER', '-ascii')
