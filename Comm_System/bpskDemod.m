function [outputData] = bpskDemod(inputSig)
%BPSKDEMOD bpsk½âµ÷º¯Êý
len = length(inputSig);
temp = zeros(1, len);
for i = 1:len
    if(real(inputSig(i)) > 0)
        temp(i) = 1;
    else
        temp(i) = 0;
    end
end
outputData = temp;
end

