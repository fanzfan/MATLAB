%start

clear;clc;

mu=0.062709;
r=20;
beta=1;
gamma=0.1;
alpha=1/14;
N=7000000000;
t=365;

S=N-1;
E=0;
I=1;
R=0;

for i=1:t-1
    S(i+1)=S(i)+mu*N-mu*S(i)-beta*I(i)/N*S(i);
    E(i+1)=E(i)+beta*I(i)/N*S(i)-(mu+alpha)*E(i);
    I(i+1)=I(i)+alpha*E(i)-(gamma+mu)*I(i);
    R(i+1)=R(i)+gamma*I(i)-mu*R(i);
end

plot(S), hold on;
plot(E), hold on;
plot(I), hold on;
plot(R), hold on;
legend('易感者','潜伏者','传染者','康复者');