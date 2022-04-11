% Simulaci�n del P�ndulo Invertido con el Controlador Difuso
% NOTA: Solamente para posici�n del p�ndulo
clear all; close all; clc
% Constantes del Sistema
% x1p = x2 Primera funci�n del sistema
% x2p = (g/l)*sin(x1)-(1/(m*l*l))*u Segunda funci�n del sistema
g = 9.81; % Gravedad (mts/seg^2)
l = 0.30; % Longitud (mts.)
m = 0.8; % Masa (Kg.)
% Definici�n de tiempos
ti = 0;
dt = 0.001;
tf = 5;

% Condiciones iniciales
x1o = 0.0175*5; % Condicion Inicial 1�
x2o = -0.0698; % Condicion Inicial -4�/seg.
u = 0; % Entrada al sistema (Fuerza)
k = 1; % Contador
% Simulaci�n
for t = ti:dt:tf
X1(k,1) = x1o;
X2(k,1) = x2o;
UU(k,1) = u;
TT(k,1) = t;
% Sistema
x1op = x2o;
x2op = (g/l)*sin(x1o)-(1/(m*l*l))*u;
% Controlador (Ley de Control)
Setpoint=x1o-0.1;
u = contpenfuz(Setpoint,x2o);

%Integral
x1o = x1o + x1op*dt; x2o = x2o + x2op*dt;
k = k + 1;
end
% Graficando
figure(1)
subplot(311)
plot(TT,X1)
grid; ylabel('Posici�n')
subplot(312)
plot(TT,X2)

grid; ylabel('Velocidad')
subplot(313)
plot(TT,UU)
grid; ylabel('Fuerza')

