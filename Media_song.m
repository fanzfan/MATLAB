%start

[x,fs]=audioread('C:\Wolfgang Amadeus Mozart - D小调幻想曲.mp3');
x=x(:,1);
n=length(x);
dt=1/fs;
time=(0:n-1)*dt;
times=2;                 %相对于原信号压缩（伸展）的倍数

sine = sin(5000*time);
sound(sine,fs);
figure(1);
subplot(3,1,1),plot(time,x),grid on,title('信号时域波形');

X=fft(x,fs);
n=length(X);
df=fs/n;
f=(0:1:n-1)*df;
absX=abs(X);
figure(2);
subplot(3,1,1),plot(f,absX),grid on,title('信号幅度谱');

x2=x;
fs2=fs*times;
n2=length(x2);
dt2=1/fs2;
time2=(0:n2-1)*dt2;
figure(1);
subplot(3,1,2),plot(time2,x2),grid on,title('压缩后信号时域波形');


X2=fft(x2,fs2);
n2=length(X2);
df=fs2/n2;
f=(0:1:n2-1)*df;
absX2=abs(X2);angX=angle(X2);
figure(2);
subplot(3,1,2),plot(f,absX2),grid on,title('压缩后信号幅度谱');

x2=x;
fs2=fs/times;
n2=length(x2);
dt2=1/fs2;
time2=(0:n2-1)*dt2;
figure(1);
subplot(3,1,3),plot(time2,x2),grid on,title('伸展后信号时域波形');

X2=fft(x2,fs2);
n2=length(X2);
df=fs2/n2;
f=(0:1:n2-1)*df;
absX2=abs(X2);angX=angle(X2);
figure(2);
subplot(3,1,3),plot(f,absX2),grid on,title('伸展后信号幅度谱');

figure(3);
plot(time,sine);axis([0 20 -1.5 1.5])
%end
