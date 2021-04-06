%% load data
load ex5m1.mat;
%% Problem 1
data = speech1_10k(1:250);
dataHamming = hamming(length(data))' .* data;