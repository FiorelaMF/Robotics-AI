% Robot Plotter con PDT
clear all; close all; clc
% Condiciones Iniciales
ff = pi/180; % Factor de Conv. Sex a Rad
amax(1) = 10*ff; % rad/s^2
vmax(1) = 2*ff; % rad/s
amax(2) = 10*ff; % rad/s^2
vmax(2) = 1*ff; % rad/s
amax(3) = 1.00; % mts/s^2
vmax(3) = 0.25; % mts/s
amax(4) = 10*ff; % rad/s^2
vmax(4) = 25*ff; % rad/s

amax = amax';
vmax = vmax';
kkk=1;


for titff = 1:1:100
k=1;
for titf=1:1:2
Px=kkk*0.01;

l2 =2; l3 =3;Py=1.2;
tita2(k,1)=acos((Px^2+Py^2-l2^2-l3^2)/(2*l2*l3));

aaa=l3*sin(tita2(k,1))*Px+(l2+l3*cos(tita2(k,1)))*Py;
bbb=-l3*sin(tita2(k,1))*Py+(l2+l3*cos(tita2(k,1)))*Px;
tita1(k,1)= -atan(aaa/bbb);

k=k+1;
kkk=kkk+1;
end    
    
kkk=kkk-1;
% Constantes de la Trayectoria
p0 = [ tita1(1,1) tita2(1,1) 1.5]';
pf = [ tita1(2,1) tita2(2,1) 1.5]';

t0 = 0;
dt = 0.0001; % Pequeño para simular continuidad
x = [ p0' pf' ]';
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



m1 = 20; m2 = 10; l1 =4; l2 = 2; l3 =3; l4=-5; % masas y longitudes
m3 =20; m4=15;
g = 9.81; % Gravedad (m/s^2)
% Parámetros del Controlador
Kp = 10000*eye(3); Kv = 10*eye(3); Ki=0.1*eye(3);
x = [ x(1:3); x(4:6); [0 0 0]'];
for t=0:dt:(max(T))
X1(k,1) = x(1); X2(k,1) = x(2); X3(k,1) = x(3);
X4(k,1) = x(4); X5(k,1) = x(5); X6(k,1) = x(6);
X7(k,1) = x(7); X8(k,1) = x(8); X9(k,1) = x(9);
q1 = x(1); q2 = x(2); q3 = x(3);
q1p = x(4); q2p = x(5); q3p = x(6);

% Errores de Seguimiento
e = qd(:,k) - x(1:3); ep = qdp(:,k) - x(4:6);
E(k,1:3) = e'; EP(k,1:3) = ep';



% Variable Intermedia para reducir las dimesiones
% Cálculo de las Matrices del Manipulador
% Matriz de Inercias

M= [(m2*(2*l2^2 + 4*cos(q2)*l2*l3 + 2*l3^2))/2 + (m3*(2*l2^2 + 4*cos(q2)*l2*l3 + 2*l3^2))/2 + (m4*(2*l2^2 + 4*cos(q2)*l2*l3 + 2*l3^2))/2 + l2^2*m1, l3*(l3 + l2*cos(q2))*(m2 + m3 + m4),           0
                                                                                                            l3*(l3 + l2*cos(q2))*(m2 + m3 + m4),                 l3^2*(m2 + m3 + m4),           0
                                                                                                                                              0,                                   0, m3/4 + m4/4 ];
                                                                                                                                            
 

                                                                                                                                          
% Inversa de M(q)
MI = inv(M);
% Matriz de Fuerzas Centrípetas y de Coriolis

                             
C = [-l2*l3*q2p*sin(q2)*(m2 + m3 + m4), -l2*l3*sin(q2)*(q1p + q2p)*(m2 + m3 + m4), 0
  l2*l3*q1p*sin(q2)*(m2 + m3 + m4),                                         0, 0
                                 0,                                         0, 0 ];
    
                             
                             
                             
                             
                             

N = C*[ q1p q2p q3p]';
% Vector de Gravedad
 
G= [           0
               0
 (g*(m3 + m4))/2];
               


% Torque Computado (Señal de Control)
S = qdpp(:,k) + Kv*ep + Kp*e+ Ki*x(7:9);
tau = M*S+N+G;

% Ecuación de Estado
xp = [ x(4:6)
MI*(-N-G+tau) 
e];
% Integración
x = x + xp*dt;
k = k + 1;
end


%Graficando
%figure(1)
%plot(T,E(:,1),'r',T,E(:,2),'b',T,E(:,3),'m')
%title('Error Articular PID de Torque Computado')
%xlabel('Tiempo (seg.)')
%ylabel('Amplitud del Error')
%grid on; zoom on

%figure(2)
%plot(T,X1,'r-',T,X2,'b-',T,X3,'m-',T,QD(:,1),'r:',T,QD(:,2),'b:',T,QD(:,3),'m:')
%title('Brazo Robot-PID de Torque Computado')
%xlabel('Tiempo (seg.)'); ylabel('Amplitud de Angulo')
%grid on; zoom on


%figure(3)
%plot(T,X4,'r-',T,X5,'b-',T,X6,'m-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'m:')
%title('Brazo Robot-PID de Torque Computado')
%xlabel('Tiempo (seg.)')
%ylabel('Amplitud de Velocidad Angular')
%grid on; zoom on


% Trajectoria (PID) en espacio cartesiano
x_cart =  -(l3*cos(X1 + X2) + l2*cos(X1));
y_cart =  l3*sin(X1 + X2) + l2*sin(X1);
z_cart = l1 - l4 + X3;    
xd_cart = -(l3*cos(QD(:,1) +QD(:,2)) + l2*cos(QD(:,1))); 
yd_cart = l3*sin(QD(:,1) + QD(:,2)) + l2*sin(QD(:,1));
zd_cart = l1 - l4 + QD(:,3);
figure(4)
plot3(x_cart,y_cart,z_cart,'r-',xd_cart,yd_cart,zd_cart,'g-');
title(' Trayectoria del Extremo con un Controlador PID')
rotate3d on; grid on
hold on
end