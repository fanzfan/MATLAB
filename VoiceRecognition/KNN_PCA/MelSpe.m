% 仿MEL谱图特征提取
% 参考ppt，将每个输入数据分解成9个特征点并返回
% num：信息条数
function [outputArg] = MelSpe(inputArg, num)
    outputArg = zeros(9, num);
    n = 1024/8;

    for i = 1:num
        outputArg(:, i) = [sum(abs(inputArg(1:n, i).^2)) sum(abs(inputArg(n:2 * n, i).^2)) sum(abs(inputArg(2 * n:3 * n, i).^2)) sum(abs(inputArg(3 * n:4 * n, i).^2)) sum(abs(inputArg(4 * n:5 * n, i).^2)) sum(abs(inputArg(5 * n:6 * n, i).^2)) sum(abs(inputArg(6 * n:7 * n, i).^2)) sum(abs(inputArg(7 * n:8 * n, i).^2)) sum(abs(inputArg(:, i)).^2)]';
    end

end
