w = -0:0.01:20;
Hw = 0.5.*(sin(pi/2.*(w))./(pi/2.*(w)));
semilogy(w, 20*log(abs(Hw)));