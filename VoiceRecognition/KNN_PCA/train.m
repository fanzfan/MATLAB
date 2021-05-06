%% mu = 0.9
mu = [0.9 0.8 0.7 0.5];
numOfVec = zeros(1, length(mu));

%% 初始化
num = 128;
fftPoints = 1024;
voice_fft = zeros(fftPoints, num);

%% PCA计算
for i = 1 : length(mu)
    % 读取并作fft
    for j = 1 : num
        voice_fft(:, j) = fft(audioread(['C:\Users\Vela\OneDrive\桌面\语音信号处理\KNN\数据\训练样本\' num2str(j) '.wav']), fftPoints);
    end
    voice_PCA = PCA(abs(voice_fft), num, mu(i));
    %% 存储变量
    save(['voice_PCA_' num2str(mu(i)) '.csv'],'voice_PCA', '-ascii');
    [numOfVec(i), ~] = size(voice_PCA);
end
plot(mu, numOfVec, 'Color','#A2142F','LineWidth', 2);title('PCA特征向量与阈值的关系')
axis([0.4 1 0 10])