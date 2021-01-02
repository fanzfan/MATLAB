
t = -10:0.001:10;
yt = (sinc(t));
yt2 = sinc(t).*cos(t)./(1-t.^2);
subplot(2,1,1);
plot(t,yt);
axis([-5 5 -0.5 1.2]);title('矩形基带信号频谱')

subplot(2,1,2);
plot(t,yt2);
axis([-5 5 -0.5 1.2]);title('升余弦基带信号频谱')
