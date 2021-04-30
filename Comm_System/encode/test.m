nVar = 10; 
chan = comm.AWGNChannel('NoiseMethod','Variance','Variance',nVar);
bpskMod = comm.BPSKModulator;
bpskDemod = comm.BPSKDemodulator('DecisionMethod', ...
    'Approximate log-likelihood ratio','Variance',nVar);
K = 132;
E = 256;
msg = randi([0 1],K,1,'int8');
enc = nrPolarEncode(msg,E);
mod = bpskMod(enc);
mod1 = bpskMod(msg);
rSig = chan(mod);
rSig1 = chan(mod1);
rxLLR = bpskDemod(rSig); 
rxLLR1 = heaviside(bpskDemod(rSig1)); 
L = 8;
rxBits = nrPolarDecode(rxLLR,K,E,L);
numBitErrs = biterr(rxBits,msg);
numBitErrs1 = biterr(rxLLR1,msg);
disp(['Number of bit errors: ' num2str(numBitErrs)])
disp(['Number of bit errors: ' num2str(numBitErrs1)])