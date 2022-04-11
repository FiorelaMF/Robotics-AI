clear all; close all; clc
% Funciones de Membresía
x1 = -0.4:0.001:0.4; % Posición Angular (rad.)
x1_N = trapmf(x1,[-0.4 -0.4 -0.3 0 ]*1);
x1_Z = trimf(x1,[-0.3 0 0.3 ]*1);
x1_P = trapmf(x1,[0 0.3 0.4 0.4 ]*1);
figure(1)
plot(x1,x1_N,'r',x1,x1_Z,'b',x1,x1_P,'g')
grid
title('x1 = Posicion Angular')
x2 = -0.6:0.001:0.6; % Velocidad Angular (rad/seg.)
x2_N = trapmf(x2,[-0.2 -0.2 -0.15 0 ]*3);
x2_Z = trimf(x2,[-0.15 0 0.15 ]*3);
x2_P = trapmf(x2,[0 0.15 0.2 0.2 ]*3);
figure(2)
plot(x2,x2_N,'r',x2,x2_Z,'b',x2,x2_P,'g')
grid
title('x2 = Velocidad Angular')
u = -24:0.01:24; % Entrada de Control (Voltios)
u_GN = trapmf(u,[-24 -24 -16 -4 ]);
u_N = trimf(u,[-16 -4 -0.1 ]);
u_Z = trimf(u,[-4 0 4 ]);
u_P = trimf(u,[0.1 4 16 ]);
u_GP = trapmf(u,[4 16 24 24 ]);
figure(3)
plot(u,u_GN,'r',u,u_N,'b',u,u_Z,'g',u,u_P,'m',u,u_GP,'k')
grid
title('u = Voltaje de entrada')
save data_fm_pendulo