%% KNN_FUN KNN算法匹配
%   此处显示详细说明
function [outputArg1] = KNN_fun(inputArg1, mu)
%% 加载训练集
P = load(['voice_PCA_' num2str(mu) '.csv']);
[L,~] = size(P);
if(L > 1)
    Distance = sum(abs(P - inputArg1).^2);
else
    Distance = abs(P - inputArg1).^2;
end
sorted_Distance = sort(Distance);
Min2_Distance = sorted_Distance(1:2);

index = [find(abs(Distance - Min2_Distance(1)) < 0.00001) find(abs(Distance - Min2_Distance(2)) < 0.00001)];

if(index(1)>=1 && index(1) <= 16)
    outputArg1 = 1;
else if(index(1)>=17 && index(1) <= 31)
        outputArg1 = 2;
    else if(index(1)>=32 && index(1) <= 46)
            outputArg1 = 3;
        else if(index(1)>=47 && index(1) <= 70)
                outputArg1 = 4;
            else if(index(1)>=71 && index(1) <= 82)
                    outputArg1 = 5;
                else if(index(1)>=83 && index(1) <= 110)
                        outputArg1 = 6;
                    else if(index(1)>=111 && index(1) <= 128)
                            outputArg1 = 7;
                        else
                            outputArg1 = 0;
                        end
                    end
                end
            end
        end
    end
end
end

