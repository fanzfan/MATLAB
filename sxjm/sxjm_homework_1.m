%start

data = xlsread('C:\QQ Files\2059864734\FileRecv\附件1：区域高程数据.xlsx');
dsq = 2500; %面积元大小
Sum = 0;  %初始化Sum变量

for i = 1:873
    for j = 1:1164
        Sum = Sum+sqrt(1+(data(i+1,j)-data(i,j))^2+(data(i,j+1)-data(i,j))^2)*dsq;
    end
end
fprintf('面积=%f平方公里',Sum/1000000);

%end

