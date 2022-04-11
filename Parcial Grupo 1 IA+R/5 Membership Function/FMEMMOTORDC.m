% 5 Membership Functions
% FMEMMOTORDC
% figure 9

clear all; close all; clc

%FMEM
x1=-5:0.1:5;
x1_EAN=trapmf(x1,[-100 -100 -20 -10].*(1/20));
x1_N1=trimf(x1,[-20 -10 0].*(1/20));
x1_N=trimf(x1,[-10 0 10].*(1/20));
x1_N2=trimf(x1,[0 10 20].*(1/20));
x1_EAP=trapmf(x1,[10 20 100 100].*(1/20));

figure(1)
subplot(311)
plot(x1,x1_EAN,'r',x1,x1_N1,'g',x1,x1_N,'b',x1,x1_N2,'k',x1,x1_EAP,'y');grid on
title('xi=ANGULAR ERROR')
legend('HIGH NEGATIVE','LOW NEGATIVE','NEUTRAL','LOW POSITIVE','HIGH POSITIVE');grid on;
axis([-2 2 0 1])

x2=-700:0.1:700;
x2_VAN=trapmf(x2,[-700 -700 -400 -200]);
x2_N1=trimf(x2,[-400 -200 0]);
x2_N=trimf(x2,[-200 0 200]);
x2_N2=trimf(x2,[0 200 400]);
x2_VAP=trapmf(x2,[200 400 700 700]);

subplot(312)
plot(x2,x2_VAN,'r',x2,x2_N1,'g',x2,x2_N,'b',x2,x2_N2,'k',x2,x2_VAP,'y');grid on
title('x2=ANGULAR SPEED')
legend('HIGH NEGATIVE','LOW NEGATIVE','NEUTRAL','LOW POSITIVE','HIGH POSITIVE');grid on;
axis([-700 700 0 1])

u=-9:0.1:9;
u_AN=trapmf(u,[-9 -9 -6 -3]*1);
u_BN=trimf(u,[-6 -3 0]*1);
u_P=trimf(u,[-3 0 3]*1);
u_BP=trimf(u,[0 3 6]*1);
u_AP=trapmf(u,[3 6 9 9]*1);

subplot(313)
plot(u,u_AN,'r',u,u_BN,'b',u,u_P,'g',u,u_BP,'k',u,u_AP,'y');grid on
title('u=OUTPUT VOLTAGE')
legend('HIGH NEGATIVE','LOW NEGATIVE','NEUTRAL','LOW POSITIVE','HIGH POSITIVE');grid on;
axis([-9 9 0 1])

save FM_MOTOR



