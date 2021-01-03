n = 0:15; % x(n)中n的取值范围
x = cos(5 * pi / 16 * n); % 序列x(n)
U1 = fft(x, 16); % 计算16点DFT
U2 = fft(x, 32); % 计算32点DFT

figure(1)
subplot(2, 1, 1)
stem(abs(U1)); % 16点DFT的幅频特性曲线
title('16点DFT的幅频特性曲线'); axis([0.5 16.5 -1 8])
subplot(2, 1, 2)
stem(abs(U2)); % 32点DFT的幅频特性曲线
title('32点DFT的幅频特性曲线'); axis([0.5 33 -1 10])

figure(2)
[h, w] = freqz(x, 1, 2000, 'whole'); % 计算DTFT幅频特性，h为H(w)，w为频率坐标
% 参数 'whole'代表 w 取值为完整的0~2pi
plot(w, abs(h)); %  绘制DTFT的幅频特性曲线
title('幅频特性曲线 DFT'); axis([-0.05 6.34 -1 10])

% 猜想 DFT 是 DTFT 在 exp(-j*w*k/n) 上的抽样
% 下面开始验证
% 我们做2000个点的DFT并且用plot折线绘出，观察其与figure(2)中图像是否一致
figure(3)
stem(abs(fft(x, 2000)))% 做2000个点的DFT并且用plot折线绘出
title('2000点FFT连线'); axis([-0.1 2001 -1 10])
