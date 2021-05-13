close all
clear all
% 基本参数
k = 1024;
n = 2560;
rate = k/n;
IterNum = 50;
% H = Gen_Hmatrix(rate);
% G = Gen_Gmatrix(rate);
% save('G_0.5.mat','G');
% save('H_0.5.mat','H');

load 'H.mat'
load 'G.mat'
ferrlim = 100;
EbN0dB = [2.0];

for nEN = 1:length(EbN0dB)
    en = 10^(EbN0dB(nEN) / 10);
    sigma = 1 / sqrt(2 * rate * en);
    errs(nEN) = 0;
    nferr(nEN) = 0;
    nframe = 0;

    while nframe < ferrlim
        nframe = nframe + 1;
        msg = randi([0 1] , 1, k);
        code = mod(msg*G, 2);
        I = double(1 - 2 * code);
        rec = I + sigma * randn(1, length(I));
        rec = rec;
        est_code = LDPC_Decoder(rec, sigma, H, IterNum);
        err = length(find(est_code ~= msg));
        errs(nEN) = errs(nEN) + err;

        if err
            nferr(nEN) = nferr(nEN) + 1;
        end

    end

    err(nEN) = err(nEN) / nframe / n;
    nferr(nEN) = nferr(nEN) / nframe;
end
