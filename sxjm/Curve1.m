%start

x1=imread('C:\P1100862.jpg');
x=rgb2gray(x1);      %将图像转换为黑白形式
f=fft(x);
amplitude=abs(f);        %傅里叶变换的幅值
phase=angle(f);          %傅里叶变换的角度

figure(1),imshow(x),title('原图');
figure(2),imshow(ifft(amplitude),[]),title('仅由幅值谱还原的图像');
figure(3),imshow(ifft(phase),[]),title('仅由相位谱还原的图像');
figure(4),imshow(ifft(amplitude.*exp(1j*phase)),[]),title('幅值谱与相位谱共同还原的图像');

%end


