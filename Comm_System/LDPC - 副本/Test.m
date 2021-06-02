clc;clear all;close all;
load 'H.mat'
load 'G.mat'
M = 512;
K = 2;
Gm = LDPC_genGmatrix(H, M, 1/2);
A = Gm ~= G;
B = sum(sum(A))


%% 绘图
% load 'EbN0dB.csv'
% load 'BPSK_BER.csv'
% load 'LDPC_BER.csv'
% load 'Hamming_BER.csv'
% 
% EbN0dB_LDPC = log10(10.^(EbN0dB / 10) * (2560/1024)) * 10;
% x_axis = (1:length(EbN0dB));
% semilogy(EbN0dB(x_axis), BPSK_BER(x_axis), 'LineWidth', 1.5)
% hold on
% semilogy(EbN0dB_LDPC(x_axis), LDPC_BER(x_axis), '*-', 'LineWidth', 1.5)
% semilogy(EbN0dB(x_axis), Hamming_BER(x_axis), '+-', 'LineWidth', 1.5)
% xline(10*log10(log(2)), '--')
% legend('bpsk理论', 'LDPC编码', '汉明码', '香农极限')
