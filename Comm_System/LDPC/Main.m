clc;clear all;close all;
%% 基本参数定义
k = 1024;
n = 2560;
m = n - k;
codeRate = 1/2;
EbN0dB = 1.5:0.3:3;
EbN0dB_LDPC = log10(10.^(EbN0dB / 10) * n / k) * 10;
EbN0dB_Hamming = log10(10.^(EbN0dB / 10) * (7/4)) * 10;
len = length(EbN0dB);
IterNum = 20;
NORM_FACTOR = 0.8;
LDPC_BER = zeros(1, len);
Hamming_BER = zeros(1, len);
load 'G.mat'
load 'H.mat'

%% BPSK调制、解调

bpskMod = @(msg) 2 * msg - 1;
bpskDemod = @(Signal) heaviside(real(Signal));
%% 随机数产生、调制
bpskMod = @(data) 2 * data - 1;
dataLen = 1024 * 7 * 10;
data = randi([0 1],1, 1024 * 7 * 10);

%% 编码与调制
LDPC_code = LDPC_Encoder(G, resize(data, [], 1024));
Hamming_code = Hamming_Encoder(resize(data, [], 4));
LDPC_modSig = bpskMod(resize(LDPC_code', 1, []));
Hamming_modSig = bpskMod(resize(Hamming_code', 1, []));
LDPC_finData = resize(data, [], 1024);

%% LDPC码仿真
for i = 1:length(EbN0dB_LDPC)
    LDPC_recSig = bpskAWGN(EbN0dB_LDPC(i), LDPC_modSig);
    LDPC_recSig = resize(LDPC_recSig', 2560, [])';
    [row, ~] = size(LDPC_recSig);
    for j = 1 : row
        [~, Y] = LDPC_Decoder(H, LDPC_recSig(j, :), IterNum, NORM_FACTOR);
        LDPC_finData(j, :) = Y(1:1024);
    end
    [~, LDPC_BER(i)] = ErrRate(resize(data, [], 1024), LDPC_finData);
end

%% 汉明码仿真
for i = 1:length(EbN0dB_Hamming)
    Hamming_recSig = bpskAWGN(EbN0dB_Hamming(i), Hamming_modSig);
    Hamming_recSig = resize(LDPC_recSig', 7, [])';
    Hamming_recData = bpskDemod(Hamming_recSig);
    finData = Hamming_Decoder(Hamming_recData);
    [~, Hamming_BER(i)] = ErrRate(resize(data, [], 1024), LDPC_finData);
end

semilogy(EbN0dB, LDPC_BER)
hold on
semilogy(EbN0dB, Hamming_BER)
