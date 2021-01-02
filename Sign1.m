%start

Um=1;
T=2;
w=2*pi/T;
num_points=200;
t=linspace(0,T,num_points);
x=Um*abs(sin(2*w*t)).*(t>0); %分解的波形
n=randn(38,1);
n=[0;n;0];
n = interp1([0:39],n,linspace(0,39,num_points),'spline');  %较为光滑的插值方式
x=x+0.4*n;

m=0:100;
subplot(3,1,1),plot(t,x),title('随机信号x(t)');


for k=1:101
    q=0:1:m(k);
    c0=0.5*trapz(t,x);
    phi0=q'*w*t;
    a=2/T*trapz(t,x.*cos(phi0),2);                 %计算an
    b=2/T*trapz(t,x.*sin(phi0),2);                 %计算bn
    c=sqrt(a.^2+b.^2);
    phi=-atan2(b,a);
    ft0=cos(q'*w*t+phi);
    ft=-c0+b'*sin(q'*w*t)+a'*cos(q'*w*t);
    subplot(3,1,2),plot(t,ft),title(['实数形式匹配：最大谐波次数=',num2str(m(k))]);
    subplot(3,1,3),plot(t,-c0+c'*ft0),title(['余弦形式匹配：最大谐波次数=',num2str(m(k))]);
    pause(0.1);
end

%end
