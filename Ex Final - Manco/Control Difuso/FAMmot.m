clear all; close all; clc

load FM_Motor
%Condiciones iniciales
x1o = -6; %Error en degree
x2o = 0; %Grados por segundo

%Fuzzificacion
x1_EANI=interp1(x1,x1_EAN,x1o);
%error alto negativo interpolado
x1_NI=interp1(x1,x1_N,x1o);
%error neutro interpolado
x1_EAPI=interp1(x1,x1_EAP,x1o);
%error alto positivo interpolado
x2_VANI=interp1(x2,x2_VAN,x2o);
%velocidad alto negativo interpolado
x2_NI=interp1(x2,x2_N,x2o);
%velocidad neutro interpolado
x2_VAPI=interp1(x2,x2_VAP,x2o);

%Reglas difusas (debemos construir las FAM)
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
FAM=[r1 r2 r3
    r4 r5 r6
    r7 r8 r9];

%Conjuntos Difusos de salida
mu_BN = [r1 r2 r3 r4];
mu_P = [r5];
mu_BP = [r6 r7 r8 r9];

% Union
%mu_AN = max(mu_AN);
mu_BN = max(mu_BN);
mu_P = max(mu_P);
mu_BP = max(mu_BP);
%mu_AP = max(mu_AP);

% alfa-cut values
%mu_AN = mu_AN*ones(size(u_AN));
mu_BN = mu_BN*ones(size(u_BN));
mu_P = mu_P*ones(size(u_P));
mu_BP = mu_BP*ones(size(u_BP));
%mu_AP = mu_AP*ones(size(u_AP));

figure(1)
subplot(221);
plot(u,u_BN,'g',u,u_P,'k',u,u_BP,'m',u ,mu_BN,'g--',u,mu_P,'k--',u,mu_BP,'m--')
title({'Salidas Difusas de 3 funciones';'de membresía con Alfa-valores'})
grid on; axis([-12 12 0 1]);

% Interseccion
%mu_AN=min(mu_AN,u_AN);
mu_BN=min(mu_BN,u_BN);
mu_BP=min(mu_BP,u_BP);
mu_P=min(mu_P,u_P);
%mu_AP=min(mu_AP,u_AP);

subplot(222);
plot(u,mu_BN,'g',u,mu_P,'k',u,mu_BP,'m')
title({'Salida de corte con';'3 funciones de membresía'})
grid on; axis([-12 12 0 1]);

% Union
muZ=max([mu_BN;mu_P;mu_BP]);

subplot(223);
plot(u,muZ,'b'); grid on; axis([-12 12 0 1])
title('u = Voltaje del motor')

%Defuzzyficación
Z = defuzz(u,muZ,'centroid')
subplot(224);
plot(u,muZ,'b',[Z Z],[0 1], 'r');
grid on; axis([-12 12 0 1])
title({'u = Salida del motor con 3 funciones';'de membresía con centroide'})
mu_P=min(mu_P, u_P);



