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
logData = log(abs(fftData));
% calculate the real cepstrum
cepstrum = ifft(logData, 1024);
cepstrum(1) = 0;
figure(1)
subplot(2, 1, 1);
plot(cepstrum(1:1024),'LineWidth', 1); title('cepstrum')
subplot(2, 1, 2);
plot(cepstrum(1:256),'color','#EDB120','LineWidth', 1); title('the top 256 points of cepstrum ')

%% Problem 2
display(66 / 1024 * 250)

%% Problem 3 calculate low-quefrency real cepstrum
% filter
I = [1 2*ones(1,49) zeros(1,974)];
lowCepstraum = cepstrum .* I;
fftLowCepstral = fft(lowCepstraum, 1024);
% real cepstrum amptitude
ampCepstral = abs(fftLowCepstral);
% the log amptitude
figure(2)
subplot(2, 1, 1);
semilogy(ampCepstral(1:512),'color','#A2142F','LineWidth', 1); title('log amplitude of low-quefrency cepstrum');ylabel('amplitude (dB)')
% phase
subplot(2, 1, 2);
angCepstral = angle(fftLowCepstral);
plot(angCepstral(1:512),'color','#77AC30','LineWidth', 1); title('phase of low-quefrency cepstrum');ylabel('phase')

%% Problem 4 generate a impluse string
% the minimum-phase impulse responce
R_FLR_cepstral = exp(fftLowCepstral);
% acquire the convolutional voice restoring signal
R_chan = ifft(R_FLR_cepstral, 1024);
% create a pulse string
pulse_series = zeros(1, 256);
x = 1:25;
pulse_series(1) = 1;
mergeSpeech = conv(pulse_series, R_chan(1:256));
%sound(speech_cepsys);
