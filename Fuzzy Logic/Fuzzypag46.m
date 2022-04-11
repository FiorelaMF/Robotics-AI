close all; clear all; clc
load data_fm_pendulo
%x1o = 0.0175; % Condicion Inicial 1º
%x2o = -0.0698 % Condicion Inicial -4º/seg.
x1o = 1.5*0.0175*1; % Condicion Inicial 1º
x2o = -2.5*0.0698*1 % Condicion Inicial -4º/seg.


% Interpolando

x1_NI = interp1(x1,x1_N,x1o);
x1_ZI = interp1(x1,x1_Z,x1o);
x1_PI = interp1(x1,x1_P,x1o);
figure(1)
plot( x1,x1_N,'r',[x1o x1o],[0 x1_NI],'r:',[x1o -0.4],[x1_NI x1_NI],'r:', x1o, x1_NI,'ro',...
x1,x1_Z,'b',[x1o x1o],[0 x1_ZI],'b:',[x1o -0.4],[x1_ZI x1_ZI],'b:',x1o,x1_ZI,'bo',...
x1,x1_P,'g',[x1o x1o],[0 x1_PI],'g:',[x1o -0.4],[x1_PI x1_PI],'g:',x1o,x1_PI,'go')
grid
title('x1 = Posicion Angular')


x2_NI = interp1(x2,x2_N,x2o);
x2_ZI = interp1(x2,x2_Z,x2o);
x2_PI = interp1(x2,x2_P,x2o);
figure(2)
plot(x2,x2_N,'r',[x2o x2o],[0 x2_NI],'r:',[x2o -0.6],[x2_NI x2_NI],'r:',x2o,x2_NI,'ro',...
    x2,x2_Z,'b',[x2o x2o],[0 x2_ZI],'b:',[x2o -0.6],[x2_ZI x2_ZI],'b:',x2o,x2_ZI,'bo',...
    x2,x2_P,'g',[x2o x2o],[0 x2_PI],'g:',[x2o -0.6],[x2_PI x2_PI],'g:',x2o,x2_PI,'go')
grid
title('x2 = Velocidad Angular')

% Reglas Difusas
r1 = min(x1_PI,x2_PI);
r2 = min(x1_PI,x2_ZI);
r3 = min(x1_PI,x2_NI);
r4 = min(x1_ZI,x2_PI);
r5 = min(x1_ZI,x2_ZI);
r6 = min(x1_ZI,x2_NI);
r7 = min(x1_NI,x2_PI);
r8 = min(x1_NI,x2_ZI);
r9 = min(x1_NI,x2_NI);
% FAM
FAM = [ r1 r2 r3
r4 r5 r6
r7 r8 r9 ]

% Conjuntos Difusos de la Salida
mu_uGN = [ r9 ];
mu_uN = [ r6 r8 ];
mu_uZ = [ r3 r5 r7 ];
mu_uP = [ r2 r4 ];
mu_uGP = [ r1 ];

% Valores de Corte
mu_uGN = max(mu_uGN)*ones(size(u_GN));
mu_uN = max(mu_uN)*ones(size(u_N));
mu_uZ = max(mu_uZ)*ones(size(u_Z));
mu_uP = max(mu_uP)*ones(size(u_P));
mu_uGP = max(mu_uGP)*ones(size(u_GP));
figure(3)
plot(u,u_GN,'r',u,mu_uGN,'r:',u,u_N,'b',u,mu_uN,'b:',...
u,u_Z,'g',u,mu_uZ,'g:',u,u_P,'m',u,mu_uP,'m:',...
u,u_GP,'k',u,mu_uGP,'k:')
axis([-24 24 0 1])
grid
title('u = Voltaje de entrada')

% Cortando los conjuntos
mu_uGN = min(mu_uGN,u_GN);
mu_uN = min(mu_uN,u_N);
mu_uZ = min(mu_uZ,u_Z);
mu_uP = min(mu_uP,u_P);
mu_uGP = min(mu_uGP,u_GP);
figure(4)
plot(u,mu_uGN,'r',u,mu_uN,'b',u,mu_uZ,'g',u,mu_uP,'m',u,mu_uGP,'k')
axis([-24 24 0 1])
grid
title('u = Voltaje de entrada')

% Uniendo los conjuntos
muZ = max([mu_uGN;mu_uN;mu_uZ;mu_uP;mu_uGP]);
figure(5)
plot(u,muZ,'b')
axis([-24 24 0 1])
grid
title('u = Voltaje de entrada')

% Defuzzificando
Z = defuzz(u,muZ,'centroid')
figure(6)
plot(u,muZ,'b',[Z Z],[0 1],'r')
axis([-24 24 0 1])
grid
title('u = Voltaje de entrada')