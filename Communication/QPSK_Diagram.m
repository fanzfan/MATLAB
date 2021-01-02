% QPSK 星座图

% QPSK
M = 4;
% 数据点个数
dataNum = 1000;
% 高斯随机数方差
sigma_v2 = [0.0 0.1 0.5 1];
% 高斯随机数标准差(只需修改方差即可)
sigma = sqrt(sigma_v2);

for index = 1:length(sigma)
    % 均匀随机数生成信源信号
    oriSignal = randi([0 M - 1], 1, dataNum);
    % 高斯随机数生成
    gaussNum1 = normrnd(0, sigma(index), [1 dataNum]);
    gaussNum2 = normrnd(0, sigma(index), [1 dataNum]);
    % 将均匀随机数 psk 调制，使用格雷码映射，为符合实验要求，设置参考相位为 0
    deSig = PSKModulate(oriSignal, M, 0);
    % 将高斯噪声叠加至信号实部
    pskReal = real(deSig) + gaussNum1;
    % 将高斯噪声叠加至信号虚部
    pskImag = imag(deSig) + gaussNum2;
    reSig = pskReal + pskImag .* 1j;
    % 接收端信号星座图, 方差由前面所述 sigma_v2 决定
    scatterplot(reSig);
    %plot(real(reSig),imag(reSig),'b.');
    title({'Plot', ['1000数据点，噪声方差为', num2str(sigma_v2(index)), '的接收端星座图']});
end

%END
