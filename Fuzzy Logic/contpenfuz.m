function [Z] = contpenfuz(x1o,x2o)
% Esta función es el controlador difuso para el péndulo invertido
%
% [Z] = contpenfuz(x1o,x2o)
%
% Z = es el valor de salida
% x1o = es el valor de la posición angular del péndulo (rad.)
% xo2 = es el valor de la velocidad angular del péndulo (rad/seg.)
load data_fm_pendulo
% Interpolando
x1_NI = interp1(x1,x1_N,x1o);
x1_ZI = interp1(x1,x1_Z,x1o);
x1_PI = interp1(x1,x1_P,x1o);
x2_NI = interp1(x2,x2_N,x2o);
x2_ZI = interp1(x2,x2_Z,x2o);
x2_PI = interp1(x2,x2_P,x2o);
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
% Conjuntos Difusos de la Salida
mu_uGN = [ r9 ];
mu_uN = [ r6 r8 ];
mu_uZ = [ r3 r5 r7 ];
mu_uP = [ r2 r4 ];
mu_uGP = [ r1 ];

%mu_uGN = [ r9 ];
%mu_uN = [ r6 r8 r3 r7 ];
%mu_uZ = [  r5  ];
%mu_uP = [ r2 r4 ];
%mu_uGP = [ r1 ];


% Valores de Corte
mu_uGN = max(mu_uGN)*ones(size(u_GN));
mu_uN = max(mu_uN)*ones(size(u_N));
mu_uZ = max(mu_uZ)*ones(size(u_Z));
mu_uP = max(mu_uP)*ones(size(u_P));
mu_uGP = max(mu_uGP)*ones(size(u_GP));
% Cortando los conjuntos
mu_uGN = min(mu_uGN,u_GN);
mu_uN = min(mu_uN,u_N);
mu_uZ = min(mu_uZ,u_Z);
mu_uP = min(mu_uP,u_P);
mu_uGP = min(mu_uGP,u_GP);
% Uniendo los conjuntos
muZ = max([mu_uGN;mu_uN;mu_uZ;mu_uP;mu_uGP]);
% Defuzzificando
Z = defuzz(u,muZ,'centroid');