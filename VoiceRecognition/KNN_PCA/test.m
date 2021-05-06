%% 测试样本程序
% 训练集已经通过训练程序产生
% 为了方便处理，做fft将数据化为等长形式

%% 加载训练集
P1 = load('voice_PCA_0.9.csv');
P2 = load('voice_PCA_0.8.csv');
P3 = load('voice_PCA_0.7.csv');
P4 = load('voice_PCA_0.5.csv');
%% 初始化
mu = 0.5 : 0.05 : 0.9;
num = 58;
fftPoints = 1024;

% 指定PCA维度，使其与训练集匹配
K = zeros(1,4);
errNum = K;
[K(1), ~] = size(P1);
[K(2), ~] = size(P2);
[K(3), ~] = size(P3);
[K(4), ~] = size(P4);
voice_fft = zeros(fftPoints, num);
typ = zeros(1, num);
errNum = K;
%% 加载测试样本
% 读取并作fft
for i = 1 : num
    voice_fft(:, i) = fft(audioread(['C:\Users\Vela\OneDrive\桌面\语音信号处理\KNN\数据\测试样本\' num2str(i) '.wav']), fftPoints);
end

%% PCA与KNN算法
for i = 1 : length(mu)
    [K(i), ~] = size(load(['voice_PCA_' num2str(mu(i)) '.csv']));
    test_PCA = PCA_K(abs(voice_fft), num, K(i));
    for j = 1 : num
        typ(j) = KNN_fun(test_PCA(:,j), mu(i));
    end
    errNum(i) = length(find(typ==5)) + length(find(typ==6));
    %% 故障率
    disp(['mu = ' num2str(mu(i)) ' 情况下的故障率：' num2str(errNum(i) / num * 100) '%']);
end
disp(['真实情况下的故障率：' num2str(13 / 58 * 100) '%']);
plot(mu, errNum/num * 100,'Color', '#77AC30', 'LineWidth', 2);title('模型预测故障发生频率')
hold on
yline(13 / 58 * 100, '-.k', 'LineWidth', 1)
ylabel('错误率 %')
axis([0.4 1 15 26])
legend('模型预测故障率', '真实故障率')


