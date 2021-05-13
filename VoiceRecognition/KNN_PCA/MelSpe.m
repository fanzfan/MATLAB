% 仿MEL谱图特征提取
% 参考ppt，将每个输入数据分解成9个特征点并返回
% num：信息条数
function [outputArg] = MelSpe(inputArg)
  f = 0 : length(inputArg);
  melHz = 2595*log10(1 + f);
  outputArg = inputArg(melHz);
end
