[y,Fs] = audioread('C:\Users\Vela\OneDrive\桌面\语音信号处理\KNN\数据\处理样本\正常\1.wav');
[y2,Fs2] = audioread('C:\Users\Vela\OneDrive\桌面\语音信号处理\KNN\数据\处理样本\正常\2.wav');
y2 = y2(1:8002);
Y = zeros(8002, 2);
Y(:, 1) = y - mean(y);
Y(:, 2) = y2 - mean(y2);
C = 1/2 * Y * Y';
[V, D] = eig(C);
