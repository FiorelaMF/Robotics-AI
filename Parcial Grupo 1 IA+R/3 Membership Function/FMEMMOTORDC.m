%3 Membership Functions 
% FMEMMOTORDC
% figure 8

clear all; close all; clc

x1=-5:0.1:5;
x1_EAN=trapmf(x1,[-100 -100 -10 0].*(1/20));
x1_N=trimf(x1,[-10 0 10].*(1/20));
x1_EAP=trapmf(x1,[0 10 100 100].*(1/20));

figure(1)
subplot(311)
plot(x1,x1_EAN,'r',x1,x1_N,'g',x1,x1_EAP,'y');grid on
title('xi = Angular Error')
legend('High Negative','Neutral','High positive');grid on;
axis([-5 5 0 1])

x2=-700:0.1:700;
x2_VAN=trapmf(x2,[-700 -700 -300 0]);
x2_N=trimf(x2,[-300 0 300]);
x2_VAP=trapmf(x2,[0 300 700 700]);

subplot(312)
plot(x2,x2_VAN,'r',x2,x2_N,'g',x2,x2_VAP,'y');grid on
title('x2 = Angular Speed')
legend('High negative','Neutral','High positive');grid on;
axis([-700 700 0 1])

u=-9:0.1:9;
u_AN=trapmf(u,[-9 -9 -5 -4]*1);
u_BN=trimf(u,[-5 -3 0]*1);
u_P=trimf(u,[-3 0 3]*1);
u_BP=trimf(u,[0 3 5]*1);
u_AP=trapmf(u,[4 5 9 9]*1);

subplot(313)
plot(u,u_AN,'r',u,u_BN,'b',u,u_P,'g',u,u_BP,'k',u,u_AP,'y');grid on
title('u = Output Voltage')
legend('High negative','Low negative','Stop','Low positive','High positive');grid on;
axis([-9 9 0 1])

save FM_MOTOR

