% 误码率，误比特率计算函数
% numOfErrs，输出的错误数量
% errRate，错误率
% oriData，原始数据
% demodData，解调后的数据
function [numOfErrs, errRate] = ErrRate(oriData, demodData)
    numOfErrs = 0;

    % 获取数据个数
    lenOfSignal = size(oriData, 1) * size(oriData, 2);
    % 计算 BER 或 SER，逐一比对
    for index = 1 : lenOfSignal
        % 如果错误，则错误次数加一
        if oriData(index) ~= demodData(index)
            numOfErrs = numOfErrs + 1;
        end
    end

    % 错误概率计算
    errRate = numOfErrs / lenOfSignal;
end
