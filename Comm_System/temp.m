t = -600 : 0.1 : 600;
len = length(t);
x = square(t);
snrdb = 5;
% 高斯
figure
y = x + randn(1 , len) * 10^(-snrdb / 10);
plot(t, y)
axis([-30 30 -5 5])
% 瑞利
figure
y = real(x * (raylrnd(1 / sqrt(2), 1, 1) * exp(2 * pi * 1j * rand(1, 1)))) + randn(1 , len) * 10^(-snrdb / 10);
plot(t, y)
axis([-30 30 -5 5])
% 莱斯
figure
y = x * random('Rician', 2, 1/sqrt(2)) + randn(1 , len) * 10^(-snrdb / 10);
plot(t, y)
axis([-30 30 -5 5])