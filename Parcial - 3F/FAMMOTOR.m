% 3 Membership Function Fuzzy
% FAMMOTOR
% figure 10 

clear all; close all; clc
load FM_MOTOR
%Initial Conditions
x1o=-3;
x2o=-700;
x1o=x1o*pi/180;
x2o=x2o*pi/180;

%Fuzzyfication
x1_EANI=interp1(x1,x1_EAN,x1o);
x1_NI=interp1(x1,x1_N,x1o);
x1_EAPI=interp1(x1,x1_EAP,x1o);

x2_VANI=interp1(x2,x2_VAN,x2o);
x2_NI=interp1(x2,x2_N,x2o);
x2_VAPI=interp1(x2,x2_VAP,x2o);

[x1_EANI x1_NI x1_EAPI];
[x2_VANI x2_NI x2_VAPI];

%Fuzzy Rules
r1=min(x1_EANI,x2_VANI);
r2=min(x1_NI,x2_VANI);
r3=min(x1_EAPI,x2_VANI);

r4=min(x1_EANI,x2_NI);
r5=min(x1_NI,x2_NI);
r6=min(x1_EAPI,x2_NI);

r7=min(x1_EANI,x2_VAPI);
r8=min(x1_NI,x2_VAPI);
r9=min(x1_EAPI,x2_VAPI);

%FAM
FAM=[r1 r2 r3;
    r4 r5 r6;
    r7 r8 r9]

% mu_AN=[r1];
% mu_BN=[r2 r4];
% mu_P=[r3 r5 r7];
% mu_BP=[r6 r8];
% mu_AP=[r9];

mu_AN=[0];
mu_BN=[r1 r2 r3 r4];
mu_P=[r5];
mu_BP=[r6 r7 r8 r9];
mu_AP=[0];

%Union
mu_AN=max(mu_AN);
mu_BN=max(mu_BN);
mu_P=max(mu_P);
mu_BP=max(mu_BP);
mu_AP=max(mu_AP);

%ALFA CUT
mu_AN=mu_AN*ones(size(mu_AN));
mu_BN=mu_BN*ones(size(mu_BN));
mu_P=mu_P*ones(size(mu_P));
mu_BP=mu_BP*ones(size(mu_BP));
mu_AP=mu_AP*ones(size(mu_AP));
figure(1)
subplot(221)
plot(u,u_AN,'r',u,u_BN,'g',u,u_P,'k',u,u_BP,'m',u,u_AP,'b'...
    ,u,mu_AN,'r--',u,mu_BN,'g--',u,mu_P,'k--',u,mu_BP,'m--',u,mu_AP,'b--')
title('Voltage Membership Functions')
grid on; axis([-9 9 0 1]);
%Aplicamos la interseccion
mu_AN=min(mu_AN,u_AN);
mu_BN=min(mu_BN,u_BN);
mu_P=min(mu_P,u_P);
mu_BP=min(mu_BP,u_BP);
mu_AP=min(mu_AP,u_AP);
subplot(222)
plot(u,mu_AN,'r:',u,mu_BN,'g',u,mu_P,'k',u,mu_BP,'m',u,mu_AP,'b')
title('Output fuzzy sets with alpha cut values')
grid on; axis([-9 9 0 1]);

%aplicamos union
muZ=max([mu_AN;mu_BN;mu_P;mu_BP;mu_AP])
subplot(223)
plot(u,muZ,'b')
grid on; axis([-9 9 0 1]);
title('Union Operation')
%Desfuzzyficacion
Z=defuzz(u,muZ,'centroid')
subplot(224)
plot(u,muZ,'b',[Z Z],[0 1],'r')
grid on; axis([-9 9 0 1]);
title('Motor Voltage')
%mu_P=min(mu_p,u_p);

