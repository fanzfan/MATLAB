%% LDPC Encode and Decode QPSK-Modulated Signal in Simulink
% Transmit an LDPC-encoded, QPSK-modulated bit stream through an AWGN
% channel. Demodulate and decode the received signal. Compute the error
% statistics.

% Copyright 2019 The MathWorks, Inc.

%%
% The |snr| variable is initialized using the |InitFcn| callback in *Model
% Properties>Callbacks*. The |SNR dB| parameter in the *AWGN Channel* block
% and the |Variance| parameter in the *QPSK Demodulator Baseband* block
% initialize settings using the |snr| variable.
%%
model = 'cm_ldpc_decode_qpsk_signal.slx';
open_system(model);
%%
% The simulation is configured to process one input frame of data. The
% *Error Rate Calculation* block compares the transmitted binary data
% stream with the information data bits output by the *LDPC Decoder* block.
sim(model)
sSNR = num2str(snr);
sErrRate = num2str(ErrorVec(1));
disp(['For SNR = ',sSNR,' dB, the error rate is ',sErrRate,'.'])

%%
%
close_system(model);
