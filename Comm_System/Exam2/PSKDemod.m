%% 根据所给输入进行PSK解调，以格雷码映射
% 函数定义开始，输出result数组
% receiveSignal: 接收到的信号
% M 调制指数
% iniPhase 星座图初相
% result 解调后的信号
function result = PSKDemod (receiveSignal, M, iniPhase)
    result = zeros(1, length(receiveSignal));
    % 先处理其接收信号，将其 0 对应的点移到 (1 , 0)上
    receiveSignal = receiveSignal / exp(1j * iniPhase);
    %% QPSK 解调
    for index = 1:length(receiveSignal)
        % 最近距离判决法
        % angleOfSig 待解调信号的辐角，作为判决准则
        % 格雷码排列顺序 0 1 3 2
        angleOfSig = angle(receiveSignal(index));

        if (angleOfSig >= -pi / M && angleOfSig < pi / M)
            result(index) = 0;
        elseif (angleOfSig >= pi / M && angleOfSig < 3 * pi / M)
            result(index) = 1;
        elseif (angleOfSig >= 3 * pi / M || angleOfSig < -3 * pi / M)
            result(index) = 3;
        elseif (angleOfSig >= -3 * pi / M && angleOfSig < -pi / M)
            result(index) = 2;
        end
    end
end

%END
