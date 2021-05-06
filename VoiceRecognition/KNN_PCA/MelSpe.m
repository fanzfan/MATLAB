% 仿MEL谱图特征提取
% 参考ppt，将每个输入数据分解成9个特征点并返回
% num：信息条数
function [outputArg] = MelSpe(inputArg, num)
n = 1024;
outputArg = zeros(n + 1, num);
for i = 1 : num
    for j = 1 : n
        outputArg(j, i) = sum(abs(inputArg(j , i).^2));
    end
    outputArg(n + 1, i) = sum(abs(inputArg(:, i)).^2);
end
end
