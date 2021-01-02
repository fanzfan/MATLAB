% 根据所给输入进行PSK解调，以格雷码映射
% 函数定义开始，输出result数组
% receiveSignal: 接收到的信号
% M 调制指数
% iniPhase 星座图初相
% result 解调后的信号
function result = PSKDemodulate (receiveSignal, M, iniPhase, method)
result = zeros(1, length(receiveSignal));

% 先处理其接收信号，将其 0 对应的点移到 (1 , 0)上
receiveSignal = receiveSignal / exp(1j * iniPhase);

if M == 4
    
    for index = 1:length(receiveSignal)
        % 最近距离判决法
        if strcmp(method, 'closest')
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
            
            % 最大投影点判决法
        elseif strcmp(method, 'maxProPoint')
            % 格雷码排列顺序 0 1 3 2
            realOfSig = real(receiveSignal(index));
            imagOfSig = imag(receiveSignal(index));
            
            if imagOfSig > 0
                
                if abs(imagOfSig) > abs(realOfSig)
                    result(index) = 1;
                elseif realOfSig > 0
                    result(index) = 0;
                elseif realOfSig < 0
                    result(index) = 3;
                end
                
            elseif imagOfSig < 0
                
                if abs(imagOfSig) > abs(realOfSig)
                    result(index) = 2;
                elseif realOfSig > 0
                    result(index) = 0;
                elseif realOfSig < 0
                    result(index) = 3;
                end
                
            end
            
        end
        
    end
    
end

if M == 8
    
    for index = 1:length(receiveSignal)
        % angleOfSig 待解调信号的辐角，作为判决准则
        % 格雷码排列顺序 0 1 3 2 6 7 5 4
        angleOfSig = angle(receiveSignal(index));
        
        if (angleOfSig >= -pi / M && angleOfSig < pi / M)
            result(index) = 0;
        elseif (angleOfSig >= pi / M && angleOfSig < 3 * pi / M)
            result(index) = 1;
        elseif (angleOfSig >= 3 * pi / M && angleOfSig < 5 * pi / M)
            result(index) = 3;
        elseif (angleOfSig >= 5 * pi / M && angleOfSig < 7 * pi / M)
            result(index) = 2;
        elseif (angleOfSig >= 7 * pi / M || angleOfSig < -7 * pi / M)
            result(index) = 6;
        elseif (angleOfSig >= -7 * pi / M && angleOfSig < -5 * pi / M)
            result(index) = 7;
        elseif (angleOfSig >= -5 * pi / M && angleOfSig < -3 * pi / M)
            result(index) = 5;
        elseif (angleOfSig >= -3 * pi / M && angleOfSig < -pi / M)
            result(index) = 4;
        end
        
    end
    
end

end
%END
