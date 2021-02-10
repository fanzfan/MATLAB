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
tspan = 1:0.01:35;

%% The derivative of function is not continuous at t=0
tspan2 = tspan(2:length(tspan));

%% Relative humidty

%%%%% Modify the hu to change humidity
hu = 75;
v = @(t) hu / 50 * 0.1;
%% The influence of moisture
%  Described like 1+B*cos(t) here

Wv1 = @(t) 1 + 0.5 * v(t);
Wv2 = @(t) 1 + 1.5 * v(t);

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

%% 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%% Natural growth rate
r1 = 1;
r2 = 1.3;

%% The influence of moisture
%  Described like 1+B*cos(t) here

Wv1 = @(t) 1 + 1 * v(t);
Wv2 = @(t) 1 + 3 * v(t);

%% Max quantity that environment can sustain
N1max = @(t) 1500;
N2max = @(t) 1000;

%% Differential equations set
f = @(t, y1)[
        r1 * y1(1) * (1 - y1(1) / N1max(t) - sigma21 * y1(2) / N2max(t)) * Wv1(t)
        r2 * y1(2) * (1 - y1(2) / N2max(t) - sigma12 * y1(1) / N1max(t)) * Wv2(t)
        ];

%% Slove the above ODE set
[t, y1] = ode45(f, tspan, N0);


%% 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Natural growth rate
r1 = 1;
r2 = 1.3;

%% The influence of moisture
%  Described like 1+B*cos(t) here

Wv1 = @(t) 1 + 2 * v(t);
Wv2 = @(t) 1 + 6 * v(t);

%% Max quantity that environment can sustain
N1max = @(t) 1500;
N2max = @(t) 1000;

%% Differential equations set
f = @(t, y2)[
        r1 * y2(1) * (1 - y2(1) / N1max(t) - sigma21 * y2(2) / N2max(t)) * Wv1(t)
        r2 * y2(2) * (1 - y2(2) / N2max(t) - sigma12 * y2(1) / N1max(t)) * Wv2(t)
        ];

%% Slove the above ODE set
[t, y2] = ode45(f, tspan, N0);

%% Show the conclusion with images
figure(2)
% Figure one upper
subplot(2, 1, 1)
plot(t, y(:, 1), t, y(:, 2),t, y1(:, 1), t, y1(:, 2),t, y2(:, 1), t, y2(:, 2), 'LineWidth', 2);
title('Number of individuals in the population');
xlabel('days'); ylabel('population'); legend(' S_1=0.5', ' S_2=1.5',' S_1=1', ' S_2=3',' S_1=2', ' S_2=6', 'Location','southeastoutside')

% Figure one lower
subplot(2, 1, 2)
hold on
% Growth rate
plot(tspan2, diff(y(:, 1))/0.01, tspan2, diff(y(:, 2))/0.01,tspan2, diff(y1(:, 1))/0.01, tspan2, diff(y1(:, 2))/0.01,tspan2, diff(y2(:, 1))/0.01, tspan2, diff(y2(:, 2))/0.01, 'LineWidth', 2);
title('Population growth rate')
xlabel('days'); ylabel('growth rate'); legend(' S_1=0.5', ' S_2=1.5',' S_1=1', ' S_2=3',' S_1=2', ' S_2=6', 'Location','southeastoutside')

