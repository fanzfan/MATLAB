%% RayAWGN 模拟瑞利信道并叠加高斯噪声
% outputSignal : 输出加噪信号
% G：衰弱系数
function [outputSignal, G] = RayAWGN(inputSignal, EbN0dB, M)
    % 信号点个数
    len = length(inputSignal);
    % 叠加瑞利噪声至输入信号上, G也是衰弱系数
    G = raylrnd(1 / sqrt(2), 1, len) .* exp(2 * pi * 1j * rand(1, len));
    outputSignal = inputSignal .* G;
    
    % 高斯随机数的方差，通过 EbNodB 换算
    sigma_v2 = 10^(EbN0dB / -10) / (2 * log2(M));
    % 高斯随机数标准差(只需修改方差即可)
    sigma = sqrt(sigma_v2);
    % 叠加高斯噪声
    outputSignal = outputSignal + normrnd(0, sigma, [1 len]) + 1j * normrnd(0, sigma, [1 len]);
end
