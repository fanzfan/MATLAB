%start

w3=17.86;
w4=22.99;
Q=0:0.001:1;
gamma=0.2;
theta=0.2^(1/12);
eta=1.22e11;
beta=1.109e5;
c1=(theta-Q).^8;
c2=(theta-0.42.*Q).^8;


Y1=(gamma^2).*(0.42.*Q.*(1-c2))./(0.42.*Q-theta+1);
Y2=(theta^4*gamma^2.*c2).*(Q.*(1-c1))./(Q-theta+1);
X1star=eta.*(c2.*gamma^2.*(beta/2)+beta.*c1.*c2.*theta^4.*gamma^2-1)./(c1.*c2.*beta.*theta^4.*gamma^2+(beta/2).*c2.*gamma^2);
Z=w3.*Y1.*X1star+w4.*Y2.*X1star;
plot(Q,Z);
[M,I]=max(Z);
fprintf('当Q取%.3f时，Z最大，Z的最大值为：%f吨',I/1000,M/1000000);

%end