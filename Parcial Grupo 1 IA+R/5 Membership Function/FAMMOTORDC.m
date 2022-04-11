% 5 Membership Function Fuzzy 
% FAMMOTORDC 
% figure 11  
clear all; close all; clc
load FM_MOTOR

x1o=-100;
x2o=-300;
x1o=x1o*pi/180;
x2o=x2o*pi/180;


x1_EANI=interp1(x1,x1_EAN,x1o);
x1_NI1=interp1(x1,x1_N1,x1o);
x1_NI=interp1(x1,x1_N,x1o);
x1_NI2=interp1(x1,x1_N2,x1o);
x1_EAPI=interp1(x1,x1_EAP,x1o);

x2_VANI=interp1(x2,x2_VAN,x2o);
x2_NI1=interp1(x2,x2_N1,x2o);
x2_NI=interp1(x2,x2_N,x2o);
x2_NI2=interp1(x2,x2_N2,x2o);
x2_VAPI=interp1(x2,x2_VAP,x2o);

[x1_EANI x1_NI1 x1_NI x1_NI2 x1_EAPI];
[x2_VANI x2_NI1 x2_NI x2_NI2 x2_VAPI];

r1=min(x1_EANI,x2_VANI);
r2=min(x1_NI1,x2_VANI);
r3=min(x1_NI,x2_VANI);
r4=min(x1_NI2,x2_VANI);
r5=min(x1_EAPI,x2_VANI);
r6=min(x1_EANI,x2_NI1);
r7=min(x1_NI1,x2_NI1);
r8=min(x1_NI,x2_NI1);
r9=min(x1_NI2,x2_NI1);
r10=min(x1_EAPI,x2_NI1);
r11=min(x1_EANI,x2_NI);
r12=min(x1_NI1,x2_NI);
r13=min(x1_NI,x2_NI);
r14=min(x1_NI2,x2_NI);
r15=min(x1_EAPI,x2_NI);
r16=min(x1_EANI,x2_NI2);
r17=min(x1_NI1,x2_NI2);
r18=min(x1_NI,x2_NI2);
r19=min(x1_NI2,x2_NI2);
r20=min(x1_EAPI,x2_NI2);
r21=min(x1_EANI,x2_VAPI);
r22=min(x1_NI1,x2_VAPI);
r23=min(x1_NI,x2_VAPI);
r24=min(x1_NI2,x2_VAPI);
r25=min(x1_EAPI,x2_VAPI);

FAM=[r1 r2  r3  r4  r5;
    r6  r7  r8  r9  r10;
    r11 r12 r13 r14 r15;
    r16 r17 r18 r19 r20;
    r21 r22 r23 r24 r25]

mu_AN=[0];
mu_BN=[r1  r2  r3  r4  r5  r6  r7  r8  r9  r11 r12 r16];
mu_P =[r13];
mu_BP=[r10 r14 r15 r17 r18 r19 r20 r21 r22 r23 r24 r25];
mu_AP=[0];

mu_AN=max(mu_AN);
mu_BN=max(mu_BN);
mu_P=max(mu_P);
mu_BP=max(mu_BP);
mu_AP=max(mu_AP);

mu_AN=mu_AN*ones(size(mu_AN));
mu_BN=mu_BN*ones(size(mu_BN));
mu_P=mu_P*ones(size(mu_P));
mu_BP=mu_BP*ones(size(mu_BP));
mu_AP=mu_AP*ones(size(mu_AP));
figure(1)
subplot(221)
plot(u,u_AN,'r',u,u_BN,'g',u,u_P,'k',u,u_BP,'m',u,u_AP,'b'...
    ,u,mu_AN,'r--',u,mu_BN,'g--',u,mu_P,'k--',u,mu_BP,'m--',u,mu_AP,'b--')
title('Voltage Membership Function')
grid on; axis([-9 9 0 1]);

mu_AN=min(mu_AN,u_AN);
mu_BN=min(mu_BN,u_BN);
mu_P=min(mu_P,u_P);
mu_BP=min(mu_BP,u_BP);
mu_AP=min(mu_AP,u_AP);
subplot(222)
plot(u,mu_AN,'r:',u,mu_BN,'g',u,mu_P,'k',u,mu_BP,'m',u,mu_AP,'b')
title('Fuzzy output sets with alpha cut values')
grid on; axis([-9 9 0 1]);

muZ=max([mu_AN;mu_BN;mu_P;mu_BP;mu_AP])
subplot(223)
plot(u,muZ,'b')
grid on; axis([-9 9 0 1]);
title('Union Operation')

Z=defuzz(u,muZ,'centroid')
subplot(224)
plot(u,muZ,'b',[Z Z],[0 1],'r')
grid on; axis([-9 9 0 1]);
title('Motor Voltage')














