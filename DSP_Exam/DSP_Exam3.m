num = [0.0528 0.0797 0.1295 0.1295 0.797 0.0528]; % 分子项的系数
den = [1 -1.8107 2.4947 -1.8801 0.9537 -0.2336]; % 分母项的系数

[h, w] = freqz(num, den, 20000, 'whole'); % 计算幅频特性，h为H(w)，w为频率坐标
% 参数 'whole'代表 w 取值为完整的0~2pi

figure(1)% 图窗1
subplot(2, 1, 1)
plot(w, abs(h)); axis([-0.1 6.34 -0.2 14])% 绘制幅频特性曲线
% 下行代码指定了坐标旁的标注
title('系统的幅频特性曲线'); xlabel('\omega'); ylabel('|H(\omega)|')
subplot(2, 1, 2)
plot(w, angle(h)); axis([-0.1 6.34 -5 5])% 绘制相频特性曲线
% 下行代码指定了坐标旁的标注
title('系统的相频特性曲线'); xlabel('\omega'); ylabel('\phi (\omega)')

figure(2)% 图窗2
zplane(num, den); title('系统的零极点图')%绘制系统的零极点图
