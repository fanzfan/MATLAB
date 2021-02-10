%% ODE of MCM 2021 Problem A
%% Start

%% Fungus 1 and 2

%% Natural growth rate
r1 = 1;
r2 = 1.3;

%% Initial quantity of fungi
N10 = 2;
N20 = 2;
N0 = [N10; N20];

%% Impact of interact between two species
sigma12 = 0.4;
sigma21 = 0.6;

%% Interval of time
tspan = 1:1:730;

%% The derivative of function is not continuous at t=0
tspan2 = tspan(2:length(tspan));

%% Relative humidty

%%%%% Modify the hu to change humidity
hu = humidityFun(3, tspan);
% plot it
plot(tspan, hu, 'k', 'LineWidth', 2);
hold on
xline(365,'--k');
xline(730,'--k');
yline(60,'--k');
axis([1 730 0 100]);xlabel('days'); ylabel('RH %');
v = @(t) hu(fix(t)) / 50 * (heaviside(hu(fix(t))-60)-0.05*heaviside(-hu(fix(t))+60));

%% The influence of moisture
%  Described like 1+B*cos(t) here

Wv1 = @(t) (1 + 1 * v(t)) .* (heaviside(hu(fix(t))-60)-0.1*heaviside(-hu(fix(t))+60));
Wv2 = @(t) (1 + 3 * v(t)) .* (heaviside(hu(fix(t))-60)-0.1*heaviside(-hu(fix(t))+60));

%% Max quantity that environment can sustain
N1max = @(t) 1500;
N2max = @(t) 1000;

%% Differential equations set
f = @(t, y)[
        r1 * y(1) * (1 - y(1) / N1max(t) - sigma21 * y(2) / N2max(t)) * Wv1(t)
        r2 * y(2) * (1 - y(2) / N2max(t) - sigma12 * y(1) / N1max(t)) * Wv2(t)
        ];

%% Slove the above ODE set
[t, y] = ode45(f, tspan, N0);

%% Show the conclusion with images
figure(2)
% Figure one upper
subplot(2, 1, 1);
P = plot(t, y(:, 1), t, y(:, 2), 'LineWidth', 2);
xline(365,'--k');
xline(730,'--k');
P(1).Color = '#A2142F';
P(2).Color = '#EDB120';
title('Number of individuals in the population');
xlabel('days'); ylabel('population'); legend(' population 1', ' population 2')

% Figure one lower
subplot(2, 1, 2)
hold on
% Growth rate
growthRate1 = diff(y(:, 1));
growthRate2 = diff(y(:, 2));
xline(365,'--k');
xline(730,'--k');
P = plot(tspan2, growthRate1, tspan2, growthRate2, 'LineWidth', 2);
P(1).Color = '#A2142F';
P(2).Color = '#EDB120';
title('Population growth rate')
xlabel('days'); ylabel('growth rate'); legend(' population 1', ' population 2')

% Figure 3
figure(3)
% Natural decaying consitent
nDecCon = 30;
% Speed of log-decaying
speedOfDecay = (growthRate1 + growthRate2) + nDecCon;
plot(tspan2, speedOfDecay, 'LineWidth', 2);
title('Decaying speed')
xlabel('days'); ylabel('speed')

%% End
