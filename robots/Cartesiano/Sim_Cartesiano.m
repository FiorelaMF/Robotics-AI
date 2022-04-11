% Robot Cartesiano de un almacén
clear all
clc
close all
% Condiciones Iniciales
amax = 0.15; % mts/s^2
vmax = 0.20; % mts/s
t0 = 0;
dt = 0.01; % Muy pequeño para simular continuidad
x = [ 0 0 0 0    0 0 0 0 ]'; % Obstáculo
k = 1;

% Constantes de la Trayectoria
pi = x(1:3,1);
pt = [ 3.5 10 7 ]'; % Obstáculo
pf = [ 5 0 0 ]';
[Ti,R1,V1,A1] = trayectoria(amax,vmax,pi,pt);
[Tf,R2,V2,A2] = trayectoria(amax,vmax,pt,pf);


T = [Ti; Tf+max(Ti)];
QD = [R1; R2];
QDP = [V1; V2];
QDPP = [A1; A2];

qd = QD';
qdp = QDP';
qdpp = QDPP';

% Constantes del Sistema
m1 = 4000; m2 = 1000; m3 = 500; % masa (long x 100kg/mt)
% m3 = m3 + carga de 300 kg.
g = 9.8; % Aceleración de la gravedad (m/s^2)
% Parámetros del Controlador
Kp = 100*eye(3); Kv = 20*eye(3); 

for t=0:0.01:(max(T)-0.01)
T(k,1) = t;
X1(k,1) = x(1);
X2(k,1) = x(2);
X3(k,1) = x(3);
X4(k,1) = x(4);
X5(k,1) = x(5);
X6(k,1) = x(6);
% Errores de Seguimiento
e = qd(:,k) - [x(1) x(2) x(3)]';
ep = qdp(:,k) - [x(4) x(5) x(6)]';
E(k,1:3) = e';
EP(k,1:3) = ep';
% Cálculo de las Matrices del Manipulador
% Matriz de Inercias
M11 = m2+m3;
M22 = m3;
M33 = m3;
M = [M11 0 0; 0 M22 0; 0 0 M33];
% Inversa de M(q)
MI = inv(M);
% Matriz de Fuerzas Centrípetas y de Coriolis
N1 = 0; N2 = 0; N3 = 0;
N = [N1; N2; N3];
% Vector de Gravedad
G1= 0;
G2= 0;
G3= -m3*g;
G= [G1; G2; G3];
% Torque Computado (Señal de Control)
S = qdpp(:,k) + Kv*ep + Kp*e;
tau = M*S+N+G;
% Ecuación de Estado
xp = [ x(4)
      x(5)
      x(6)
      MI*(-N-G+tau) ];
% Integración
x = x + xp*dt;
k = k + 1;
end

figure(3)
plot(T,E(:,1),'b',T,E(:,2),'r',T,E(:,3),'k')
title('Error Longitudinal PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on

figure(4)
plot(T,X1,'r-',T,X2,'b-',T,X3,'k-',T,QD(:,1),'r:',T,QD(:,2),'b:',T,QD(:,3),'k:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Desplazamiento')
grid on; zoom on

figure(5)
plot(T,X4,'r-',T,X5,'b-',T,X6,'k-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'k:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Velocidad')
grid on; zoom on

figure(6)
plot3(X1,X2,X3,'r-',QD(:,1),QD(:,2),QD(:,3),'g-'); hold on
plot3(X1(1,1),X2(1,1),X3(1,1),'ro',X1(k-1,1),X2(k-1,1),X3(k-1,1),'r+')
title('Trayectoria del Robot Cartesiano de Almacén')
xlabel('X');ylabel('Y');zlabel('Z')
rotate3d on; grid on

