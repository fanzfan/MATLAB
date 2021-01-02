% START
n = 0:9; % 默认坐标

%{
% 第一个差分方程
p1 = [1 -1]; % x相关项系数
d1 = [1 0.75 0.125]; % y相关项系数

% 理论计算结果 单位抽样响应
y0 = 6 * (-1/2).^n - 5 * (-1/4).^n; %理论计算结果
subplot(4, 1, 1);
stem(n, y0); title('理论计算结果 单位抽样响应'); axis([-1 10 -3 2]); %绘图

% 单位抽样响应 deltaN
deltaN = zeros(1, 10); %创建单位抽样序列deltaN
deltaN(1) = 1; %创建单位抽样序列deltaN
y1 = filter(p1, d1, deltaN); % 求解单位抽样响应
subplot(4, 1, 2);
stem(n, y1); title('单位抽样响应'); axis([-1 10 -3 2]);

% 单位阶跃响应 uN
uN = ones(1, 10); %创建单位阶跃序列uN
y2 = filter(p1, d1, uN); % 求解单位阶跃响应
subplot(4, 1, 3);
stem(n, y2); title('单位阶跃响应'); axis([-1 10 -3 2]); %绘图

%利用卷积计算单位阶跃响应
y3 = conv(y1, uN); %将得到的 单位抽样响应 与 单位阶跃序列uN 卷积
subplot(4, 1, 4);
stem(n, y2); title('单位阶跃响应(卷积)'); axis([-1 10 -3 2]); %绘图
%}

% 第二个差分方程
p2 = 0.25 * ones(1, 5); % x相关项系数
p2(1) = 0;
d2 = 1; % y相关项系数

% 理论计算结果 单位抽样响应
y0 = 0.25 * [0 ones(1, 4) zeros(1, 5)]; %理论计算结果
subplot(4, 1, 1);
stem(n, y0); title('理论计算结果 单位抽样响应'); axis([-1 10 -0.2 0.4]); %绘图

% 单位抽样响应 deltaN
deltaN = zeros(1, 10); %创建单位抽样序列deltaN
deltaN(1) = 1; %创建单位抽样序列deltaN
y1 = filter(p2, d2, deltaN); % 求解单位抽样响应
subplot(4, 1, 2);
stem(n, y1); title('单位抽样响应'); axis([-1 10 -0.2 0.4]); %绘图

% 单位阶跃响应 uN
uN = ones(1, 10); %创建单位阶跃序列uN
y2 = filter(p2, d2, uN); % 求解单位阶跃响应
subplot(4, 1, 3);
stem(n, y2); title('单位阶跃响应'); axis([-1 10 -0.2 1.5]); %绘图

%利用卷积计算单位阶跃响应      %将得到的 单位抽样响应 与 单位阶跃序列uN 卷积
y3 = conv(y1, uN);
subplot(4, 1, 4);
stem(n, y2); title('单位阶跃响应(卷积)'); axis([-1 10 -0.2 1.5]); %绘图
