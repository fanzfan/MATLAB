% 误码率，误比特率计算函数
% numOfErrs，输出的错误数量
% errRate，错误率
% oriData，原始数据
% demodData，解调后的数据
function [numOfErrs, errRate] = ErrRate(oriData, demodData)
    % 获取数据个数
    lenOfSignal = size(oriData, 1) * size(oriData, 2);
    numOfErrs = length(find(oriData~=demodData));
    % 错误概率计算
    errRate = numOfErrs / lenOfSignal;
end
