
clear
M = 2;
N=500000;
x = randi([0 M-1], 1, N);% 随机序列
s= pskmod(x,M);% 调制

m=randn(1,N);%获得瑞利信道函数
t=randn(1,N); 
h=(m+1j*t)/sqrt(2);%能量为1
y=s.*h;%经过瑞利信道

SNR = -20:0.5:10; % 信噪比范围
for n = 1:length(SNR)
r = awgn(y,SNR(n),'measured'); % 加高斯噪声
r1=real(r./h);%取实部
r2 = pskdemod(r1,M); % 解调
[nErrors(n), BER(n)]= biterr(x,r2);%计算仿真误比特率
end

BERtheory =0.5*(1-sqrt((10.^(SNR/10))./(1+10.^(SNR/10))));%计算理论误比特率

semilogy(SNR,BER,'b*',SNR,BERtheory,'r.')
legend('Empirical BER','theory BER');%曲线名称
xlabel('SNR (dB)'); ylabel('%BER');%横纵坐标
title('Binary PSK over Rayleigh Fading Channel');

