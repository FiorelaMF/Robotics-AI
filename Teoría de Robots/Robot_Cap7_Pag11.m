    % Robot Plotter con PDT
clear all; close all; clc
% Condiciones Iniciales
ff = pi/180; % Factor de Conv. Sex a Rad
amax = 15*ff; % rad/s^2
vmax = 30*ff; % rad/s
% Constantes de la Trayectoria
p0 = [ 50*ff 83*ff ]';
pf = [  51*ff 84*ff ]';
pfp =[ 0 0 ]'
t0 = 0;
dt = 0.001; % Pequeño simula continuidad
x = [ 0.999*p0' pfp' ]';
k = 1;
[R1,V1,A1] = trayplotter(amax,vmax,p0,pf,dt);
QD = [R1];
QDP = [V1];
QDPP = [A1];
T = 0:(max(size(QD))-1);
T = T'*dt;
qd = QD(:,1:2)';
qdp = QDP(:,1:2)';
qdpp = QDPP(:,1:2)';

% Constantes del Sistema
m1 = 10; m2 = 10; a1 =1; a2 = 1; % masa
g = 9.81; % Gravedad (m/s^2)
% Parámetros del Controlador
Kp = 100*eye(2); Kv = 50*eye(2);
x = [ x(1:2); x(3:4) ];
for t=0:dt:(max(T))
X1(k,1) = x(1); X2(k,1) = x(2); X3(k,1) = x(3); X4(k,1) = x(4);
q1 = x(1); q2 = x(2);
q1p = x(3); q2p = x(4);
% Errores de Seguimiento
e = qd(:,k) - x(1:2); ep = qdp(:,k) - x(3:4);
E(k,1:2) = e'; EP(k,1:2) = ep';

% Cálculo de las Matrices del Manipulador
% Matriz de Inercias
M = [ m1*a1^2+m2*a1^2+m2*a2^2+2*m2*a2*cos(q2)*a1, m2*a2*(a1*cos(q2)+a2)
m2*a2*(a1*cos(q2)+a2), m2*a2^2 ];
% Inversa de M(q)
MI = inv(M);
% Matriz de Fuerzas Centrípetas y de Coriolis
C = [ -m2*a2*sin(q2)*a1*q2p, -m2*a2*sin(q2)*a1*(q1p+q2p)
m2*a2*sin(q2)*a1*q1p, 0 ];
N = C*[ q1p q2p ]';
% Vector de Gravedad
G = [ m1*g*a1*cos(q1)+m2*g*a2*cos(q1+q2)+g*m2*a1*cos(q1)
m2*g*a2*cos(q1+q2) ];

% Torque Computado (Señal de Control)
S = qdpp(:,k) + Kv*ep + Kp*e;
tau = M*S+N+G;

% Ecuación de Estado
xp = [ x(3:4)
MI*(-N-G+tau) ];
% Integración
x = x + xp*dt;
k = k + 1;
end

%Graficando
figure(1)
plot(T,E(:,1),'r',T,E(:,2),'b')
title('Error Articular PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on


figure(2)
plot(T,X1,'r-',T,X2,'r-',T,QD(:,1),'b-',T,QD(:,2),'b-')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)'); ylabel('Amplitud de Angulo')
grid on; zoom on


figure(3)
plot(T,X3,'r-',T,X4,'r-',T,QDP(:,1),'b-',T,QDP(:,2),'b-')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Velocidad Angular')
grid on; zoom on

