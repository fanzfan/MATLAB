f = 8000;
for i = 1 : 63
    [y, fs] = audioread(['C:\Users\Vela\OneDrive\桌面\语音信号处理\PyTorch\MyDataset_Original\打开后备箱\' num2str(i) '.wav']);
    x = fs/f;
    y1 = y(1:x:length(y));
    audiowrite(['C:\Users\Vela\OneDrive\桌面\语音信号处理\PyTorch\MyDataset\打开后备箱\' num2str(i) '.wav'], y1, f);
end