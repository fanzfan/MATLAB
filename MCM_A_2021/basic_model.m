
%% ODE of MCM 2021 Problem A

%% Natural growth rate
r1 = 0.1;
r2 = 0.2;
r3 = 0.15;

%% Initial Quantity
N10 = 1;
N20 = 1;
N30 = 2;

%% Max Quantity that environment can sustain
N1max = 100;
N2max = 100;
N3max = 120;

%% Impact of interact between two species
sigma12 = 0.6;
sigma13 = 0.7;
sigma21 = 0.8;
sigma23 = 0.9;
sigma31 = 0.5;
sigma32 = 0.8;

%% Interval of time
tspan = 1:1:400000;

%% Differential Equations 
f = @(t,y)[
    0.1*r1*y(1)*(1-y(1)/N1max-sigma21*y(2)/N2max-sigma31*y(2)/N3max)*(0.7*cos(0.01*t)+1.1)
    0.1*r2*y(2)*(1-y(2)/N2max-sigma12*y(1)/N1max-sigma32*y(3)/N3max)*(1*cos(0.01*t)+1.1)
    0.1*r3*y(3)*(1-y(3)/N3max-sigma13*y(1)/N1max-sigma23*y(2)/N2max)*(0.8*cos(0.01*t)+1.1)
];

%% Slove the above Equations
[t,y] = ode45(f, tspan, [N10; N20; N30]);

%% Show the Conclusion with images
subplot(1,2,1)
plot(t,y(:,1),t,y(:,2),t,y(:,3)); title('种群个体数量')
subplot(1,2,2)
plot(diff(y(:,1)))
hold on
plot(diff(y(:,3)))
plot(diff(y(:,2))); title('种群增长速率')

%% End