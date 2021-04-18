
M = 2;
len = 500000;
data = randi([0 1], 1, len);
EbN0dB = 0 : 1 : 15;
modSig = bpskMod(data);
% 接收到的信号
recSig = zeros(2, len);
% 信号包络幅度 Rk，这里假设接收器的性能足够好，可以完美估计出 Rk 的值
R = zeros(2, len);
% 合并比 Ak
A = zeros(2, len);
% 合并后的信号
finSig = zeros(1, len);
% 解调数据
finData = zeros(1, len);
% 错误概率
errRate = zeros(1, length(EbN0dB));
ep = zeros(1, length(EbN0dB));
for i = 1:length(EbN0dB)
        % 噪声方差
    sigma_v2 = 10 ^ (EbN0dB(i) / -10) / (2 * log2(M));
    % 噪声功率 N0
    N0 = sigma_v2 / 2;
    % 通过瑞利信道
    [recSig(1,:), R(1,:)] = RayleighChannel(modSig);
    [recSig(2,:), R(2,:)] = RayleighChannel(modSig);
    recSig(1,:) = AddGWN(EbN0dB(i), recSig(1,:), M);
    recSig(1,:) = AddGWN(EbN0dB(i), recSig(1,:), M);
    % 调整为同相
    recSig = recSig .* exp (-1j * angle (R));
    % 合并比计算
    A = abs(R) / N0;
    recSig = recSig .* A;
    A = A(1 , :) + A(2, :);
    R = R(1 , :) + R(2, :);
    ep(i) = (sum(abs(A.*R).^2) ./ sum((2 * A.^2 * N0)));
    finSig = recSig(1 , :) + recSig(2 , :);
    finData = bpskDemod(finSig);
    [~, errRate(i)] = ErrRate(data, finData);
end
EbN0 = 10*log(EbN0dB);
semilogy(EbN0dB, errRate, '*');
hold on;
t = sqrt(ep ./(1+ep));
temp = ((1 - t)/2).^2 .* ((1+t)/2 + 2*((1+t)/2).^2);
semilogy(EbN0dB, temp);