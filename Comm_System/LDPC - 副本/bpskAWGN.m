% 给输入 BPSK 信号添加高斯白噪声，方差由指定 EbNodB 指定
% 函数定义开始，输出addedNoiseSignal数组
% EbNodB: 输入每比特信噪比(分贝形式)
% modSignal 调制后的，需要加噪声的信号
% M :调制指数
% addedNoiseSignal 加噪后的信号
function addedNoiseSignal = bpskAWGN(EbNodB, modSignal)

    % 高斯随机数的方差，通过 EbNodB 换算
    sigma_v2 = 10^(EbNodB / -10);

    % 高斯随机数标准差(只需修改方差即可)
    sigma = sqrt(sigma_v2);

    % 返回加噪信号
    addedNoiseSignal = modSignal + normrnd(0, sigma, [1 length(modSignal)]);
end
