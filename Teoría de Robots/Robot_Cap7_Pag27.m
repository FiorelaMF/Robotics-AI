% Robot Plotter con PDT
clear all; close all; clc
% Condiciones Iniciales
ff = pi/180; % Factor de Conv. Sex a Rad
amax(1) = 10*ff; % rad/s^2
vmax(1) = 25*ff; % rad/s
amax(2) = 10*ff; % rad/s^2
vmax(2) = 18*ff; % rad/s
amax(3) = 1.00; % mts/s^2
vmax(3) = 0.25; % mts/s
amax = amax';
vmax = vmax';
% Constantes de la Trayectoria
p0 = [ 80*ff -5*ff 0.5 ]';
pf = [ 5*ff 20*ff 1.5 ]';

t0 = 0;
dt = 0.001; % Pequeño para simular continuidad

pff = [ 0 0 0 ]';

x = [ p0' pff' ]';
k = 1;


[R1,V1,A1] = trayrobot2(amax,vmax,p0,pf,dt);
QD = [R1];
QDP = [V1];
QDPP = [A1];
T = 0:(max(size(QD))-1);
T = T'*dt;
qd = QD(:,1:3)';
qdp = QDP(:,1:3)';
qdpp = QDPP(:,1:3)';



m1 = 20; m2 = 10; l1 =4; l2 = 2; % masas y longitudes
g = 9.81; % Gravedad (m/s^2)
% Parámetros del Controlador
Kp = 1000*eye(3); Kv = 100*eye(3);
x = [ x(1:3); x(4:6) ];
for t=0:dt:(max(T))
X1(k,1) = x(1); X2(k,1) = x(2); X3(k,1) = x(3);
X4(k,1) = x(4); X5(k,1) = x(5); X6(k,1) = x(6);
q1 = x(1); q2 = x(2); q3 = x(3);
q1p = x(4); q2p = x(5); q3p = x(6);
% Errores de Seguimiento
e = qd(:,k) - x(1:3); ep = qdp(:,k) - x(4:6);
E(k,1:3) = e'; EP(k,1:3) = ep';



aa = l2 + q3; % Variable Intermedia para reducir las dimesiones
% Cálculo de las Matrices del Manipulador
% Matriz de Inercias
M = [ (m2*sin(q2)^2*aa^2)/4 0 0
0 (m2*aa^2)/4 0
0 0 m2/4 ];
% Inversa de M(q)
MI = inv(M);
% Matriz de Fuerzas Centrípetas y de Coriolis
C = [ m2*q2p*sin(2*q2)*aa^2/8+m2*q3p*sin(q2)^2*2*aa/8 m2*q1p*sin(2*q2)*aa^2/8 m2*q1p*sin(q2)^2*aa/4 
-m2*q1p*sin(2*q2)*aa^2/8 m2*q3p*aa/4 m2*q2p*aa/4
-m2*q1p*sin(q2)^2*aa/4 -m2*q2p*aa/4 0 ];
N = C*[ q1p q2p q3p ]';
% Vector de Gravedad
G = [ 0
g*m2*sin(q2)*aa/2
-g*m2*cos(q2)/2 ];


% Torque Computado (Señal de Control)
S = qdpp(:,k) + Kv*ep + Kp*e;
tau = M*S+N+G;
TAU1(k,1)=tau(1,1);
TAU2(k,1)=tau(2,1);
TAU3(k,1)=tau(3,1);

pot1=q1p(1)*tau(1,1);
pot2=q2p(1)*tau(2,1);
pot3=q3p(1)*tau(3,1);

POT1(k,1)= pot1;
POT2(k,1)= pot2;
POT3(k,1)= pot3;


% Ecuación de Estado
xp = [ x(4:6)
MI*(-N-G+tau) ];
% Integración
x = x + xp*dt;
k = k + 1;
end


%Graficando
figure(1)
plot(T,E(:,1),'r',T,E(:,2),'b',T,E(:,3),'m')
title('Error Articular PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on

figure(2)
plot(T,X1,'r-',T,X2,'b-',T,X3,'m-',T,QD(:,1),'r:',T,QD(:,2),'b:',T,QD(:,3),'m:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)'); ylabel('Amplitud de Angulo')
grid on; zoom on


figure(3)
plot(T,X4,'r-',T,X5,'b-',T,X6,'m-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'m:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Velocidad Angular')
grid on; zoom on


figure(4)
plot(T,TAU1,'r-',T,TAU2,'g-',T,TAU3,'b-')
title('Torque del Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Torque')
grid on; zoom on

figure(5)
plot(T,POT1,'r-',T,POT2,'g-',T,POT3,'b-')
title('Potencia del Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Torque')
grid on; zoom on
