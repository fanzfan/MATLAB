function [x]=awgn(waveform,No);
%x=awgn(waveform,No);
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm 
NoiseStdDev=sqrt(No/2);
x=waveform + NoiseStdDev*randn(1,length(waveform));

