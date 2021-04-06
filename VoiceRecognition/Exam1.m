%% Introduction
% use cepstrum to analyze the given voice signal
%% load data
load ex5m1.mat;

%% Problem 1 solve the real cepstrum
% sampling rate
FS = 10000;
data = speech1_10k(1:250);
dataHamming = data .* hamming(length(data))';
fftData = fft(dataHamming, 1024);
logData = log(abs(fft_data));
% calculate the real cepstrum
cepstrum = ifft(log_data, 1024);
cepstrum(1) = 0;
subplot(4, 1, 1);
plot(cepstrum(1:1024)); title('cepstrum')
subplot(4, 1, 2);
plot(cepstrum(1:256)); title('the top 256 points of cepstrum ')

%% Problem 2
display(66 / 1024 * 250)

%% Problem 3 calculate low-quefrency real cepstrum
% filter
I(1) = 1;
I(2:50) = 2;
I(51:1024) = 0;
lowCepstraum = cepstrum .* I;
fftLowCepstral = fft(lowCepstraum, 1024);
% real cepstrum amptitude
ampCepstral = abs(fftLowCepstral);
% the log amptitude
subplot(4, 1, 3); title('log amplitude of low-quefrency cepstrum')
semilogy(ampCepstral(1:512));
% phase
subplot(4, 1, 4);
angCepstral = angle(fftLowCepstral); title('phase of low-quefrency cepstrum')
plot(angCepstral(1:512));

%% Problem 4 generate a impluse string
% the minimum-phase impulse responce
R_FLR_cepstral = exp(fftLowCepstral);
% acquire the convolutional voice restoring signal
R_chan = ifft(R_FLR_cepstral, 1024);
% create a pulse string
pulse_series = zeros(1, 256);
x = 1:25;
pulse_series(10 * x) = 1;
mergeSpeech = conv(pulse_series, R_chan(1:256));
%sound(speech_cepsys);
