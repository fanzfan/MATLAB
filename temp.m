f = 8000;
for i = 1 : 75
    [y, fs] = audioread(['C:\Users\Vela\OneDrive\桌面\语音信号处理\PyTorch\MyDataset\关后备箱\' num2str(i) '.wav']);
    y = y(1 : fs / f : length(y));
    m = sum(y.^2) / length(y);
    x = y(abs(y) > m);
    %x = x - mean(x);
    plot(x);
    sound(x, f)
end