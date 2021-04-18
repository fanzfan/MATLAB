%RAYLEIGHCHANNEL 模拟瑞利信道
function [outputSignal , R] = RayleighChannel(inputSignal)
    % 信号点个数
    len = length(inputSignal);
    % 叠加瑞利噪声至输入信号上，然后输出
    %rayNoise = 1/sqrt(2)*(randn(1,len) + 1j*(randn(1,len)));
    rayNoise = raylrnd(1/sqrt(2), 1, len) .* exp(2 * pi * 1j * rand(1, len));
    outputSignal = inputSignal .* rayNoise;
    R = rayNoise;
end
