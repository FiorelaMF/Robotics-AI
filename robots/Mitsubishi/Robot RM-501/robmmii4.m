% robot_pdt Mitsubishi Move Master II (RM-501)
clear all; close all; clc

% Condiciones Iniciales
ff = pi/180;  % Factor de Conversi?nde Sex a Rad
amax = 15*ff; % rad/s^2
vmax = 30*ff; % rad/s
% Constantes de la Trayectoria
p0 = round(([ -90 47 -36 79 86 ]'*ff)*1000)/1000;
p1 = round(([ -90 58 -36 79 86 ]'*ff)*1000)/1000;
p2 = round(([  47 40 -61 32 -4 ]'*ff)*1000)/1000;
pf = round(([  47 32 -61 32 -4 ]'*ff)*1000)/1000;

t0 = 0;
dt = 0.0005; % Muy peque?o para simular continuidad
x  = [ p0' 0 0 0 0 0 ]'; % Obst?culo
k  = 1;

[R1,V1,A1] = traymmii(amax,vmax,p0,p1,dt);
[R2,V2,A2] = traymmii(amax,vmax,p1,p2,dt);
[R3,V3,A3] = traymmii(amax,vmax,p2,pf,dt);

QD   = [R1; R2; R3];
QDP  = [V1; V2; V3];
QDPP = [A1; A2; A3];
T = 0:(max(size(QD))-1);
T = T'*dt;

qd   = QD(:,1:4)';
qdp  = QDP(:,1:4)';
qdpp = QDPP(:,1:4)';

% Constantes del Sistema
m1 = 1.2232; m2 = 0.9174; m3 = 0.5097; m4 = 0.1019+0.0510;  	% masa  
                                    % m4 = m4 + carga de 0.50 kg. de peso
g  = 9.81;               % Aceleraci?n de la gravedad (m/s^2)

% Par?metros del Controlador 
Kp = 1000*eye(4); Kv = 50*eye(4);      

x = [ x(1:4); x(6:9) ];

for t=0:dt:(max(T))
    X1(k,1) = x(1);
    X2(k,1) = x(2);
    X3(k,1) = x(3);
    X4(k,1) = x(4);
    X5(k,1) = x(5);
    X6(k,1) = x(6);
    X7(k,1) = x(7);
    X8(k,1) = x(8);
    q1 = x(1);
    q2 = x(2);
    q3 = x(3);
    q4 = x(4);
    q1p = x(5);
    q2p = x(6);
    q3p = x(7);
    q4p = x(8);

    % Errores de Seguimiento
    e  = qd(:,k) - x(1:4);
    ep = qdp(:,k) - x(5:8);
    E(k,1:4)  = e';
    EP(k,1:4) = ep';
       
    % C?lculo de las Matrices del Manipulador
    % Matriz de Inercias
    M = [ 0.0121*m2*cos(q2)^2+m3*(0.0242*cos(2*q2)+0.0274+0.0176*cos(2*q2+q3)+0.0032*cos(2*q3+2*q2)+0.0176*cos(q3))+m4*(0.0352*cos(2*q2+q3)+0.0128*cos(2*q3+2*q2)+0.0072*sin(q3+q4)-169/320000*cos(2*q4+2*q3+2*q2)+0.0375+0.0052*sin(q4)+0.0072*sin(q4+q3+2*q2)+0.0352*cos(q3)+0.0242*cos(2*q2)+0.0052*sin(q4+2*q3+2*q2))                                                                                                                              0                                                                                               0                                           0  
                                                                                                                                                                                                                                                                                                                                             0  0.0121*m2+1/2*m3*(0.1096+0.0704*cos(q3))+0.5*m4*(0.1501+0.0208*sin(q4)+0.0286*sin(q3+q4)+0.1408*cos(q3))  0.5*m3*(0.0352*cos(q3)+0.0128)+0.5*m4*(0.0208*sin(q4)+0.0143*sin(q3+q4)+0.0704*cos(q3)+0.0533)  13/160000*m4*(64*sin(q4)+88*sin(q3+q4)+13)  
                                                                                                                                                                                                                                                                                                                                             0            0.5*m3*(0.0352*cos(q3)+0.0128)+1/2*m4*(0.0208*sin(q4)+0.0143*sin(q3+q4)+0.0704*cos(q3)+0.0533)                                                           0.0064*m3+0.0267*m4+0.0104*m4*sin(q4)                13/160000*m4*(64*sin(q4)+13)  
                                                                                                                                                                                                                                                                                                                                             0                                                                13/160000*m4*(64*sin(q4)+88*sin(q3+q4)+13)                                                                    13/160000*m4*(64*sin(q4)+13)                                   0.0011*m4  ];
  
    % Inversa de M(q) 
    MI = inv(M);
    % Matriz de Fuerzas Centr?petas y de Coriolis
    C = [ (-121/10000*m2*cos(q2)*sin(q2)+1/2*m3*(-4/625*sin(2*q3+2*q2)-121/2500*sin(2*q2)-22/625*sin(q3+2*q2))+1/2*m4*(-16/625*sin(2*q3+2*q2)+13/1250*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)-121/2500*sin(2*q2)+143/10000*cos(2*q2+q4+q3)-44/625*sin(q3+2*q2)))*q2p+(1/2*m3*(-11/625*sin(q3)-4/625*sin(2*q3+2*q2)-11/625*sin(q3+2*q2))+1/2*m4*(-16/625*sin(2*q3+2*q2)+13/1250*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)+143/20000*cos(q3+q4)+143/20000*cos(2*q2+q4+q3)-22/625*sin(q3)-22/625*sin(q3+2*q2)))*q3p+1/2*m4*(13/2500*cos(2*q3+2*q2+q4)+169/160000*sin(2*q4+2*q3+2*q2)+143/20000*cos(q3+q4)+143/20000*cos(2*q2+q4+q3)+13/2500*cos(q4))*q4p   -1/320000*(3872*m2*cos(q2)*sin(q2)+1024*m3*sin(2*q3+2*q2)+7744*m3*sin(2*q2)+5632*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)+7744*m4*sin(2*q2)-2288*m4*cos(2*q2+q4+q3)+11264*m4*sin(q3+2*q2))*q1p   1/320000*(-2816*m3*sin(q3)-1024*m3*sin(2*q3+2*q2)-2816*m3*sin(q3+2*q2)-4096*m4*sin(2*q3+2*q2)+1664*m4*cos(2*q3+2*q2+q4)+169*m4*sin(2*q4+2*q3+2*q2)+1144*m4*cos(q3+q4)+1144*m4*cos(2*q2+q4+q3)-5632*m4*sin(q3)-5632*m4*sin(q3+2*q2))*q1p   13/320000*m4*(64*cos(2*q3+2*q2+q4)+13*sin(2*q4+2*q3+2*q2)+88*cos(q3+q4)+88*cos(2*q2+q4+q3)+64*cos(q4))*q1p   
                                                                                                                                                                                                                                                                                                                                                                                                                     1/320000*(3872*m2*cos(q2)*sin(q2)+1024*m3*sin(2*q3+2*q2)+7744*m3*sin(2*q2)+5632*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)+7744*m4*sin(2*q2)-2288*m4*cos(2*q2+q4+q3)+11264*m4*sin(q3+2*q2))*q1p                                                                                                                               (-11/625*m3*sin(q3)+1/4*m4*(-88/625*sin(q3)+143/5000*cos(q3+q4)))*q3p+1/4*m4*(143/5000*cos(q3+q4)+13/625*cos(q4))*q4p                                       -11/625*q2p*m3*sin(q3)-22/625*q2p*m4*sin(q3)+143/20000*q2p*m4*cos(q3+q4)-11/625*q3p*m3*sin(q3)-22/625*q3p*m4*sin(q3)+143/20000*q3p*m4*cos(q3+q4)+13/2500*m4*q4p*cos(q4)+143/20000*m4*q4p*cos(q3+q4)                                                          13/20000*m4*(11*cos(q3+q4)+8*cos(q4))*(q3p+q2p+q4p)   
                                                                                                                                                                                                                                                                                                                                                                                                                               1/320000*(2816*m3*sin(q3)+1024*m3*sin(2*q3+2*q2)+2816*m3*sin(q3+2*q2)+4096*m4*sin(2*q3+2*q2)-1664*m4*cos(2*q3+2*q2+q4)-169*m4*sin(2*q4+2*q3+2*q2)-1144*m4*cos(q3+q4)-1144*m4*cos(2*q2+q4+q3)+5632*m4*sin(q3)+5632*m4*sin(q3+2*q2))*q1p                                                                                                                                                      11/625*q2p*m3*sin(q3)+22/625*q2p*m4*sin(q3)-143/20000*q2p*m4*cos(q3+q4)+13/2500*m4*q4p*cos(q4)                                                                                                                                                                                                                    13/2500*m4*q4p*cos(q4)                                                                             13/2500*m4*cos(q4)*(q3p+q2p+q4p)   
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          -13/320000*m4*(64*cos(2*q3+2*q2+q4)+13*sin(2*q4+2*q3+2*q2)+88*cos(q3+q4)+88*cos(2*q2+q4+q3)+64*cos(q4))*q1p                                                                                                                                                                                        -13/20000*m4*(11*q2p*cos(q3+q4)+8*q2p*cos(q4)+8*q3p*cos(q4))                                                                                                                                                                                                             -13/2500*m4*cos(q4)*(q2p+q3p)                                                                                                            0   ];
    N = C*[ q1p q2p q3p q4p ]';
    % Vector de Gravedad
    G = [                                                                                                                0
           1/400*conj(g*(44*m2*cos(q2)+32*m3*cos(q2+q3)+88*m3*cos(q2)+13*m4*sin(q2+q3+q4)+64*m4*cos(q2+q3)+88*m4*cos(q2)))
                                                     1/400*conj(g*(32*m3*cos(q2+q3)+13*m4*sin(q2+q3+q4)+64*m4*cos(q2+q3)))
                                                                                           13/400*conj(g*m4*sin(q2+q3+q4)) ];
    % Torque Computado (Se?al de Control)
    S = qdpp(:,k) + Kv*ep + Kp*e;   
    tau  = M*S+N+G; 

    % Ecuaci?n de Estado
    xp = [    x(5:8)
           MI*(-N-G+tau) ];
    
    % Integraci?n
    x = x + xp*dt;
           
    k = k + 1;
end

% Error m?ximo obtenido
E_max = max(max(E))*180/pi

%Graficando
figure(1)
plot(T,E(:,1),'r',T,E(:,2),'b',T,E(:,3),'k',T,E(:,4),'g')
title('Error Articular PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on

figure(2)
plot(T,X1,'r-',T,X2,'b-',T,X3,'k-',T,X4,'g-',T,QD(:,1),'r:',T,QD(:,2),'b:',T,QD(:,3),'k:',T,QD(:,4),'g:')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Angulo')
grid on; zoom on

figure(3)
plot(T,X5,'r-',T,X6,'b-',T,X7,'k-',T,X8,'g-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'k:',T,QDP(:,4),'g:')
title('Brazo Robot-PD de Torque  Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Velocidad Angular')
grid on; zoom on