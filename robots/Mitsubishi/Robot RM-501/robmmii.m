% Robot Mitsubishi Move Master II
clear all
clc
close all

syms q1 q2 q3 q4 q5 pi

% Longitudes del Robot
d1 = 0.252; % Metros
d2 = 0.220;
d3 = 0.160;
d4 = 0.065;

% Denavit-Hartenberg
%       al    a    th    d
DH = [ pi/2   0    q1   d1
         0   d2    q2    0       
         0   d3    q3    0
       pi/2   0    q4    0      
         0    0    q5   d4 ];
 
%             a       d      al      th
% A1 = matra(DH(1,2),DH(1,4),DH(1,1),DH(1,3))
% A2 = matra(DH(2,2),DH(2,4),DH(2,1),DH(2,3))
% A3 = matra(DH(3,2),DH(3,4),DH(3,1),DH(3,3))
% A4 = matra(DH(4,2),DH(4,4),DH(4,1),DH(4,3))
% A5 = matra(DH(5,2),DH(5,4),DH(5,1),DH(5,3))
% 
% T1 = simple(A1)
% T2 = simple(T1*A2)
% T3 = simple(T2*A3)
% T4 = simple(T3*A4)
% T5 = simple(T4*A5)

clear pi
tx = pi/180; % Factor de Transformación de Sex a Rad
q1 = -43*tx; q2 = -7*tx; q3 = -40*tx; q4 = 47*tx; q5 = 108*tx;
%DEFINIENDO LOS ESLABONES HACIENDO USO DE LOS PARAMETROS DE DENAVIT-HARTENBERG
%    link([  al   a	th	d])
L1 = Link([ pi/2   0    q1   d1 0 ], 'standard')
L2 = Link([   0   d2    q2    0 0 ], 'standard')
L3 = Link([   0   d3    q3    0 0 ], 'standard')
L4 = Link([ pi/2   0    q4    0 0 ], 'standard')
L5 = Link([   0    0    q5   d4 0 ], 'standard')

%ACOPLANDO LOS LINKS EN UNA ESTRUCTURA ROBOT
robotmmii = SerialLink([L1 L2 L3 L4 L5]);
drivebot(robotmmii);
pause
% robot_pdt cartresiano de almacén
clear all; close all

% Condiciones Iniciales
ff = pi/180;  % Factor de Conversiónde Sex a Rad
amax = 15*ff; % rad/s^2
vmax = 30*ff; % rad/s
t0 = 0;
dt = 0.005; % Muy pequeño para simular continuidad
x  = [ -43 -7 -40 47 108 0 0 0 0 0 ]'*ff; 
k  = 1;

% Constantes de la Trayectoria
p0 = x(1:5,1);
p1 = [ -43 25 -40 47 108 ]'*ff;
p2 = [ 119 25 -40 47 108 ]'*ff;
pf = [ 119  0 -90 90  85.8 ]'*ff;

[R1,V1,A1] = traymmii(amax,vmax,p0,p1,dt);
[R2,V2,A2] = traymmii(amax,vmax,p1,p2,dt);
[R3,V3,A3] = traymmii(amax,vmax,p2,pf,dt);

QD   = [R1; R2; R3];
QDP  = [V1; V2; V3];
QDPP = [A1; A2; A3];
T = 0:(max(size(QD))-1);
T = T'*dt;

qd   = QD';
qdp  = QDP';
qdpp = QDPP';

% Constantes del Sistema
m1 = 1.2232; m2 = 0.9174; m3 = 0.5097; m4 = 0.1019+0.0510;  	% masa  
                                    % m4 = m4 + carga de 0.50 kg. de peso
g  = 9.81;               % Aceleración de la gravedad (m/s^2)

% Parámetros del Controlador 
Kp = 100*eye(5); Kv = 20*eye(5);      

for t=0:dt:(max(T))
    X1(k,1) = x(1);
    X2(k,1) = x(2);
    X3(k,1) = x(3);
    X4(k,1) = x(4);
    X5(k,1) = x(5);
    X6(k,1) = x(6);
    X7(k,1) = x(7);
    X8(k,1) = x(8);
    X9(k,1) = x(9);
    X10(k,1) = x(10);
    q1 = x(1);
    q2 = x(2);
    q3 = x(3);
    q4 = x(4);
    q5 = x(5);
    q1p = x(6);
    q2p = x(7);
    q3p = x(8);
    q4p = x(9);
    q5p = x(10);

    % Errores de Seguimiento
    e  = qd(:,k) - x(1:5);
    ep = qdp(:,k) - x(6:10);
    E(k,1:5)  = e';
    EP(k,1:5) = ep';
       
    % Cálculo de las Matrices del Manipulador
    % Matriz de Inercias
    M = [ 0.0121*m2*cos(q2)^2+m3*(0.0242*cos(2*q2)+0.0274+0.0176*cos(2*q2+q3)+0.0032*cos(2*q3+2*q2)+0.0176*cos(q3))+m4*(0.0352*cos(2*q2+q3)+0.0128*cos(2*q3+2*q2)+0.0072*sin(q3+q4)-169/320000*cos(2*q4+2*q3+2*q2)+0.0375+0.0052*sin(q4)+0.0072*sin(q4+q3+2*q2)+0.0352*cos(q3)+0.0242*cos(2*q2)+0.0052*sin(q4+2*q3+2*q2))                                                                                                         0                                                                                               0                                           0  0
                                                                                                                                                                                                                                                                                                                        0  0.0121*m2+1/2*m3*(0.1096+0.0704*cos(q3))+0.5*m4*(0.1501+0.0208*sin(q4)+0.0286*sin(q3+q4)+0.1408*cos(q3))  0.5*m3*(0.0352*cos(q3)+0.0128)+0.5*m4*(0.0208*sin(q4)+0.0143*sin(q3+q4)+0.0704*cos(q3)+0.0533)  13/160000*m4*(64*sin(q4)+88*sin(q3+q4)+13)  0
                                                                                                                                                                                                                                                                                                                        0            0.5*m3*(0.0352*cos(q3)+0.0128)+1/2*m4*(0.0208*sin(q4)+0.0143*sin(q3+q4)+0.0704*cos(q3)+0.0533)                                                           0.0064*m3+0.0267*m4+0.0104*m4*sin(q4)                13/160000*m4*(64*sin(q4)+13)  0
                                                                                                                                                                                                                                                                                                                        0                                                                13/160000*m4*(64*sin(q4)+88*sin(q3+q4)+13)                                                                    13/160000*m4*(64*sin(q4)+13)                                   0.0011*m4  0
                                                                                                                                                                                                                                                                                                                        0                                                                                                         0                                                                                               0                                           0  0 ];
    % Inversa de M(q) 
    MI = inv(M);
    % Matriz de Fuerzas Centrípetas y de Coriolis
    C = [ (-121/10000*m2*cos(q2)*sin(q2)+1/2*m3*(-4/625*sin(2*q3+2*q2)-121/2500*sin(2*q2)-22/625*sin(q3+2*q2))+1/2*m4*(-16/625*sin(2*q3+2*q2)+13/1250*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)-121/2500*sin(2*q2)+143/10000*cos(2*q2+q4+q3)-44/625*sin(q3+2*q2)))*q2p+(1/2*m3*(-11/625*sin(q3)-4/625*sin(2*q3+2*q2)-11/625*sin(q3+2*q2))+1/2*m4*(-16/625*sin(2*q3+2*q2)+13/1250*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)+143/20000*cos(q3+q4)+143/20000*cos(2*q2+q4+q3)-22/625*sin(q3)-22/625*sin(q3+2*q2)))*q3p+1/2*m4*(13/2500*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)+143/20000*cos(q3+q4)+143/20000*cos(2*q2+q4+q3)+13/2500*cos(q4))*q4p   -1/320000*(3872*m2*cos(q2)*sin(q2)+1024*m3*sin(2*q3+2*q2)+7744*m3*sin(2*q2)+5632*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)+7744*m4*sin(2*q2)-2288*m4*cos(2*q2+q4+q3)+11264*m4*sin(q3+2*q2))*q1p   1/320000*(-2816*m3*sin(q3)-1024*m3*sin(2*q3+2*q2)-2816*m3*sin(q3+2*q2)-4096*m4*sin(2*q3+2*q2)+1664*m4*cos(2*q3+2*q2+q4)+169*m4*sin(2*q4+2*q3+2*q2)+1144*m4*cos(q3+q4)+1144*m4*cos(2*q2+q4+q3)-5632*m4*sin(q3)-5632*m4*sin(q3+2*q2))*q1p   13/320000*m4*(64*cos(2*q3+2*q2+q4)+13*sin(2*q4+2*q3+2*q2)+88*cos(q3+q4)+88*cos(2*q2+q4+q3)+64*cos(q4))*q1p   0
                                                                                                                                                                                                                                                                                                                                                                                                                     1/320000*(3872*m2*cos(q2)*sin(q2)+1024*m3*sin(2*q3+2*q2)+7744*m3*sin(2*q2)+5632*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)+7744*m4*sin(2*q2)-2288*m4*cos(2*q2+q4+q3)+11264*m4*sin(q3+2*q2))*q1p                                                                                                                               (-11/625*m3*sin(q3)+1/4*m4*(-88/625*sin(q3)+143/5000*cos(q3+q4)))*q3p+1/4*m4*(143/5000*cos(q3+q4)+13/625*cos(q4))*q4p                                       -11/625*q2p*m3*sin(q3)-22/625*q2p*m4*sin(q3)+143/20000*q2p*m4*cos(q3+q4)-11/625*q3p*m3*sin(q3)-22/625*q3p*m4*sin(q3)+143/20000*q3p*m4*cos(q3+q4)+13/2500*m4*q4p*cos(q4)+143/20000*m4*q4p*cos(q3+q4)                                                          13/20000*m4*(11*cos(q3+q4)+8*cos(q4))*(q3p+q2p+q4p)   0
                                                                                                                                                                                                                                                                                                                                                                                                                               1/320000*(2816*m3*sin(q3)+1024*m3*sin(2*q3+2*q2)+2816*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)-1144*m4*cos(q3+q4)-1144*m4*cos(2*q2+q4+q3)+5632*m4*sin(q3)+5632*m4*sin(q3+2*q2))*q1p                                                                                                                                                      11/625*q2p*m3*sin(q3)+22/625*q2p*m4*sin(q3)-143/20000*q2p*m4*cos(q3+q4)+13/2500*m4*q4p*cos(q4)                                                                                                                                                                                                                    13/2500*m4*q4p*cos(q4)                                                                             13/2500*m4*cos(q4)*(q3p+q2p+q4p)   0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          -13/320000*m4*(64*cos(2*q3+2*q2+q4)+13*sin(2*q4+2*q3+2*q2)+88*cos(q3+q4)+88*cos(2*q2+q4+q3)+64*cos(q4))*q1p                                                                                                                                                                                        -13/20000*m4*(11*q2p*cos(q3+q4)+8*q2p*cos(q4)+8*q3p*cos(q4))                                                                                                                                                                                                             -13/2500*m4*cos(q4)*(q2p+q3p)                                                                                                            0   0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    0                                                                                                                                                                                                                                                   0                                                                                                                                                                                                                                         0                                                                                                            0   0 ];
    N = C*[ q1p q2p q3p q4p q5p ]';
    % Vector de Gravedad
    G = [                                                                                                                0
           1/400*conj(g*(44*m2*cos(q2)+32*m3*cos(q2+q3)+88*m3*cos(q2)+13*m4*sin(q2+q3+q4)+64*m4*cos(q2+q3)+88*m4*cos(q2)))
                                                     1/400*conj(g*(32*m3*cos(q2+q3)+13*m4*sin(q2+q3+q4)+64*m4*cos(q2+q3)))
                                                                                           13/400*conj(g*m4*sin(q2+q3+q4))
                                                                                                                         0 ];
    % Torque Computado (Señal de Control)
    S = qdpp(:,k) + Kv*ep + Kp*e;   
    tau  = M*S+N+G; 

    % Ecuación de Estado
    xp = [    x(6:10)
           MI*(-N-G+tau) ];
    
    % Integración
    x = x + xp*dt;
           
    k = k + 1;
end

figure(3)
plot(T,E(:,1),'b',T,E(:,2),'r',T,E(:,3),'k',T,E(:,4),'g',T,E(:,5),'m')
title('Error Articular PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on

figure(4)
plot(T,X1,'r-',T,X2,'b-',T,X3,'k-',T,X4,'g-',T,X5,'m-',T,QD(:,1),'r:',T,QD(:,2),'b:',T,QD(:,3),'k:',T,QD(:,4),'g:',T,QD(:,5),'m:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Angulo')
grid on; zoom on

figure(5)
plot(T,X6,'r-',T,X7,'b-',T,X8,'k-',T,X9,'g-',T,X10,'m-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'k:',T,QDP(:,4),'g:',T,QDP(:,5),'m:')
title('Brazo Robot-PD de Torque  Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Velocidad Angular')
grid on; zoom on