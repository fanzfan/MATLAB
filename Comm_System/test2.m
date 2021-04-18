%当发射天线为1根，接收天线为4根时
%分别采用选择合并、等增益合并、最大比合并方式
clear all;                                            
close all;

%生成100000个-1/1的随机数列作为初始信号
r=randi(1,1,100000);
for i=1:100000
    if r(i)==0
        s(i)=-1;
    else
        s(i)=1;
    end
end

rs=s;

for snrdb=1:1:30
    
    %给信号乘上参数B=1/sqrt(2)的瑞利衰落系数
    %四根接受天线相当于该过程独立进行4次
    
    h1=raylrnd(1/sqrt(2),1,100000)*sqrt(snrdb);
    h2=raylrnd(1/sqrt(2),1,100000)*sqrt(snrdb);
    h3=raylrnd(1/sqrt(2),1,100000)*sqrt(snrdb);
    h4=raylrnd(1/sqrt(2),1,100000)*sqrt(snrdb);
    s1=h1.*s;
    s2=h2.*s;
    s3=h3.*s;
    s4=h4.*s;
    
    %给信号加上功率为snr（db）的高斯白噪声信号
    
    x1=awgn(s1,snrdb);
    x2=awgn(s2,snrdb);
    x3=awgn(s3,snrdb);
    x4=awgn(s4,snrdb);
    
    %选择合并
    %选择每一时刻信号和噪声功率之和最大的信号
    
    xx1=abs(x1);
    xx2=abs(x2);
    xx3=abs(x3);
    xx4=abs(x4);
    aa=max(max(xx1,xx2),max(xx3,xx4));
    y1=(aa==xx1).*x1+(aa==xx2).*x2+(aa==xx3).*x3+(aa==xx4).*x4;
    
    %等增益合并
    
    y2=x1+x2+x3+x4;
    
    %最大比合并
    
    y3=conj(h1).*x1+conj(h2).*x2+conj(h3).*x3+conj(h4).*x4;
    
    %这里没有发生角度的衰落，所以排不排除瑞利衰落系数无所谓
    %解调，加上噪声后如果与原信号同号，则未出错，反之则出错
    
    error1(snrdb)=length(find(y1.*rs<0));
    error2(snrdb)=length(find(y2.*rs<0));
    error3(snrdb)=length(find(y3.*rs<0));

    %计算误码率
    
    ber1(snrdb)=error1(snrdb)/100000;
    ber2(snrdb)=error2(snrdb)/100000;
    ber3(snrdb)=error3(snrdb)/100000;
    
end

snrdb=1:1:30;
semilogy(snrdb,ber1);
hold on
semilogy(snrdb,ber2);
hold on
semilogy(snrdb,ber3);
title('BER for 1tx vs 4rx');
xlabel('SNR');
ylabel('BER');