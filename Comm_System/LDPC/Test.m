clc;clear all;close all;
load 'H.mat'
load 'G.mat'
M = 512;
K = 2;

%H = LDPC_genHmatrix(M, 1/2);
%G = LDPC_genGmatrix(H, M, 1/2);
%% 绘图
load 'EbN0dB.csv'
load 'BPSK_BER.csv'

EbN0dB_LDPC = log10(10.^(EbN0dB / 10) * K) * 10;
EbN0dB_Hamming = log10(10.^(EbN0dB / 10) * (7/4)) * 10;
x_axis = (50:length(EbN0dB));
semilogy(EbN0dB_LDPC(x_axis), BPSK_BER(x_axis), 'LineWidth', 2)
hold on
load 'Hamming_BER.csv'
semilogy(EbN0dB_LDPC(x_axis), Hamming_BER(x_axis), '+-', 'LineWidth', 0.5)
load 'LDPC_BER_1.csv'
semilogy(EbN0dB_LDPC(x_axis), LDPC_BER_1(x_axis), '*-', 'LineWidth', 0.5)
load 'LDPC_BER_5.csv'
semilogy(EbN0dB_LDPC(x_axis), LDPC_BER_5(x_axis), '*-', 'LineWidth', 0.5)
load 'LDPC_BER_10.csv'
semilogy(EbN0dB_LDPC(x_axis), LDPC_BER_10(x_axis), '*-', 'LineWidth', 1)
xline(10*log10(log(2)), '--')
legend('bpsk理论', '7-4汉明码','LDPC编码 迭代1次', 'LDPC编码 迭代5次', 'LDPC编码 迭代10次', '香农极限')
title('LDPC码性能仿真结果')
xlabel('$$\frac{E_b}{N_o}\space (dB)$$', 'Interpreter', 'latex')
ylabel('BER')