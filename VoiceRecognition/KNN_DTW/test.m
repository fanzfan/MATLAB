%% 测试样本程序
% 训练集已经通过训练程序产生
% 为了方便处理，做fft将数据化为等长形式
clear all;
%% 初始化
mu = 0.5 : 0.05 : 0.9;
num = 58;
fftPoints = 1024;

% 指定PCA维度，使其与训练集匹配
n = zeros(1,length(mu));
errNum = n;
voice_fft = zeros(fftPoints, num);
typ = zeros(1, num);
% KNN系数
K = 3;
%% 加载测试样本
% 读取并作fft
for i = 1 : num
    voice_fft(:, i) = fft(audioread(['C:\Users\Vela\OneDrive\桌面\语音信号处理\KNN\数据\测试样本\' num2str(i) '.wav']), fftPoints);
end

%% PCA与KNN算法
for i = 1 : length(mu)
    [n(i), ~] = size(load(['voice_PCA_' num2str(mu(i)) '.csv']));
    test_PCA = PCA_K(abs(voice_fft), num, n(i));
    for j = 1 : num
        typ(j) = KNN_fun(test_PCA(:,j), K, mu(i));
    end
    errNum(i) = length(find(typ==5)) + length(find(typ==6));
    %% 故障率
    disp(['K = ' num2str(K) '，mu = ' num2str(mu(i)) ' 情况下的故障率：' num2str(errNum(i) / num * 100) '%']);
end
disp(['真实情况下的故障率：' num2str(13 / 58 * 100) '%']);
plot(mu, errNum/num * 100,'Color', '#77AC30', 'LineWidth', 2);title('模型预测故障发生频率')
hold on
yline(13 / 58 * 100, '-.k', 'LineWidth', 1)
ylabel('错误率 %')
axis([0.4 1 15 26])
legend('模型预测故障率', '真实故障率')