% 根据所给输入进行PSK调制，以格雷码映射
% 函数定义开始，输出result数组
% sourceInf: 源数据
% M 调制指数
% iniPhase 星座图初相
% result 调制后的信号
function result = PSKModulate (sourceInf, M, iniPhase)
result = zeros(1, length(sourceInf));

if M == 4
    
    for index = 1:length(sourceInf)
        
        switch sourceInf(index)
            case 0
                result(index) = exp(1j * 2 * pi * 0 / M);
            case 1
                result(index) = exp(1j * 2 * pi * 1 / M);
            case 2
                result(index) = exp(1j * 2 * pi * 3 / M);
            case 3
                result(index) = exp(1j * 2 * pi * 2 / M);
        end
        
    end
    
end

if M == 8
    
    for index = 1:length(sourceInf)
        
        switch sourceInf(index)
            case 0
                result(index) = exp(1j * 2 * pi * 0 / M);
            case 1
                result(index) = exp(1j * 2 * pi * 1 / M);
            case 2
                result(index) = exp(1j * 2 * pi * 3 / M);
            case 3
                result(index) = exp(1j * 2 * pi * 2 / M);
            case 4
                result(index) = exp(1j * 2 * pi * 7 / M);
            case 5
                result(index) = exp(1j * 2 * pi * 6 / M);
            case 6
                result(index) = exp(1j * 2 * pi * 4 / M);
            case 7
                result(index) = exp(1j * 2 * pi * 5 / M);
        end
        
    end
    
end

result = result * exp(1j * iniPhase);
end

%END
