% bpskModulate 模拟bpsk调制
function [outputSignal] = bpskMod(inputData)
    % 返回调制后信号，0对应-1，1对应1
    outputSignal = 2*inputData-1;

end
