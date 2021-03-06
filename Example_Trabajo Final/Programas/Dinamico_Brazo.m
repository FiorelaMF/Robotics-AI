% robot_pdt Mitsubishi Move Master II (RM-501)
clear all; close all; clc

% Condiciones Iniciales
ff = pi/180;  % Factor de Conversi?nde Sex a Rad
amax = 15*ff; % rad/s^2
vmax = 30*ff; % rad/s

% Constantes de la Trayectoria
p0 = round(([ 10 90 90 90  ]'*ff)*1000)/1000;
p1 = round(([ 170 60 100 100  ]'*ff)*1000)/1000;

t0 = 0;
dt = 0.0005; % Muy peque?o para simular continuidad
x  = [ p0' 0 0 0 0 ]'; % Obst?culo
k  = 1;

[R1,V1,A1] = traymmii(amax,vmax,p0,p1,dt);

QD   = [R1];
QDP  = [V1];
QDPP = [A1];
T = 0:(max(size(QD))-1);
T = T'*dt;

qd   = QD(:,1:4)';
qdp  = QDP(:,1:4)';
qdpp = QDPP(:,1:4)';

% Constantes del Sistema
m1 = 0.8562; m2 = 0.6422; m3 = 0.3568;   	% masa  
                                    % m4 = m4 + carga de 0.50 kg. de peso
g  = 9.81;               % Aceleraci?n de la gravedad (m/s^2)

% Par?metros del Controlador 
Kp = 1000*eye(4); Kv = 50*eye(4);      


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
    M = [ (81*m1)/800 + m2/16 + (57*m3)/800 + (81*m1*cos(2*q2))/800 + (m2*cos(2*q2))/32 + (m3*cos(2*q2))/32 + (m3*cos(2*q2 + 2*q3 + 2*q4))/50 + (m2*cos(2*q2 + 2*q3))/32 + (m3*cos(2*q2 + 2*q3))/50 + (m3*cos(2*q2 + q3 + q4))/20 + (m3*cos(q3 + q4))/20 + (m2*cos(q3))/16 + (m3*cos(q3))/20 + (m3*cos(q4))/25 + (m3*cos(2*q2 + 2*q3 + q4))/25 + (m2*cos(2*q2 + q3))/16 + (m3*cos(2*q2 + q3))/20,                                                                                                              0,                                                                                                0,                                         0
                                                                                                                                                                                                                                                                                                                                                                                      0, (81*m1)/400 + m2/8 + (57*m3)/400 + (m3*cos(q3 + q4))/10 + (m2*cos(q3))/8 + (m3*cos(q3))/10 + (2*m3*cos(q4))/25, m2/16 + (2*m3)/25 + (m3*cos(q3 + q4))/20 + (m2*cos(q3))/16 + (m3*cos(q3))/20 + (2*m3*cos(q4))/25, (m3*(5*cos(q3 + q4) + 4*cos(q4) + 4))/100
                                                                                                                                                                                                                                                                                                                                                                                      0,               m2/16 + (2*m3)/25 + (m3*cos(q3 + q4))/20 + (m2*cos(q3))/16 + (m3*cos(q3))/20 + (2*m3*cos(q4))/25,                                                            m2/16 + (2*m3)/25 + (2*m3*cos(q4))/25,                     (m3*(cos(q4) + 1))/25
                                                                                                                                                                                                                                                                                                                                                                                      0,                                                                      (m3*(5*cos(q3 + q4) + 4*cos(q4) + 4))/100,                                                                            (m3*(cos(q4) + 1))/25,                                     m3/25];
 

    % Inversa de M(q) 
    MI = inv(M);
    % Matriz de Fuerzas Centr?petas y de Coriolis
    C = [ - (q3p*((m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/20 + (m3*sin(q3 + q4))/20 + (m2*sin(q3))/16 + (m3*sin(q3))/20 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/16 + (m3*sin(2*q2 + q3))/20))/2 - (q2p*((81*m1*sin(2*q2))/400 + (m2*sin(2*q2))/16 + (m3*sin(2*q2))/16 + (m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/10 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/8 + (m3*sin(2*q2 + q3))/10))/2 - (m3*q4p*(4*sin(2*q2 + 2*q3 + 2*q4) + 5*sin(2*q2 + q3 + q4) + 5*sin(q3 + q4) + 4*sin(q4) + 4*sin(2*q2 + 2*q3 + q4)))/200, -(q1p*((81*m1*sin(2*q2))/400 + (m2*sin(2*q2))/16 + (m3*sin(2*q2))/16 + (m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/10 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/8 + (m3*sin(2*q2 + q3))/10))/2, -(q1p*((m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/20 + (m3*sin(q3 + q4))/20 + (m2*sin(q3))/16 + (m3*sin(q3))/20 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/16 + (m3*sin(2*q2 + q3))/20))/2, -(m3*q1p*(4*sin(2*q2 + 2*q3 + 2*q4) + 5*sin(2*q2 + q3 + q4) + 5*sin(q3 + q4) + 4*sin(q4) + 4*sin(2*q2 + 2*q3 + q4)))/200
                                                                                                                                                                                                                                                                                                                                                                                                            (q1p*((81*m1*sin(2*q2))/400 + (m2*sin(2*q2))/16 + (m3*sin(2*q2))/16 + (m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/10 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/8 + (m3*sin(2*q2 + q3))/10))/2,                                                                                                                                                          - (q3p*((m3*sin(q3 + q4))/10 + (m2*sin(q3))/8 + (m3*sin(q3))/10))/2 - (q4p*((m3*sin(q3 + q4))/10 + (2*m3*sin(q4))/25))/2,                                                                                  - (q2p*((m3*sin(q3 + q4))/10 + (m2*sin(q3))/8 + (m3*sin(q3))/10))/2 - (q3p*((m3*sin(q3 + q4))/10 + (m2*sin(q3))/8 + (m3*sin(q3))/10))/2 - (q4p*((m3*sin(q3 + q4))/10 + (2*m3*sin(q4))/25))/2,                                                                 -(m3*(5*sin(q3 + q4) + 4*sin(q4))*(q2p + q3p + q4p))/100
                                                                                                                                                                                                                                                                                                                                                                                                                (q1p*((m3*sin(2*q2 + 2*q3 + 2*q4))/25 + (m2*sin(2*q2 + 2*q3))/16 + (m3*sin(2*q2 + 2*q3))/25 + (m3*sin(2*q2 + q3 + q4))/20 + (m3*sin(q3 + q4))/20 + (m2*sin(q3))/16 + (m3*sin(q3))/20 + (2*m3*sin(2*q2 + 2*q3 + q4))/25 + (m2*sin(2*q2 + q3))/16 + (m3*sin(2*q2 + q3))/20))/2,                                                                                                                                                                                           (q2p*((m3*sin(q3 + q4))/10 + (m2*sin(q3))/8 + (m3*sin(q3))/10))/2 - (m3*q4p*sin(q4))/25,                                                                                                                                                                                                                                                          -(m3*q4p*sin(q4))/25,                                                                                       -(m3*sin(q4)*(q2p + q3p + q4p))/25
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     (m3*q1p*(4*sin(2*q2 + 2*q3 + 2*q4) + 5*sin(2*q2 + q3 + q4) + 5*sin(q3 + q4) + 4*sin(q4) + 4*sin(2*q2 + 2*q3 + q4)))/200,                                                                                                                                                                                                          (q2p*((m3*sin(q3 + q4))/10 + (2*m3*sin(q4))/25))/2 + (m3*q3p*sin(q4))/25,                                                                                                                                                                                                                                                   (m3*sin(q4)*(q2p + q3p))/25,                                                                                                                        0];
 
    N = C*[ q1p q2p q3p q4p ]';
    % Vector de Gravedad
    G = [ 
                                                                                                                                                                                                                 0
 (9*cos(conj(q2))*conj(g)*conj(m1))/20 + conj(g)*conj(m3)*(cos(conj(q2))/4 + cos(conj(q2) + conj(q3) + conj(q4))/5 + cos(conj(q2) + conj(q3))/5) + conj(g)*conj(m2)*(cos(conj(q2))/4 + cos(conj(q2) + conj(q3))/4)
                                                                             (cos(conj(q2) + conj(q3))*conj(g)*conj(m2))/4 + conj(g)*conj(m3)*(cos(conj(q2) + conj(q3) + conj(q4))/5 + cos(conj(q2) + conj(q3))/5)
                                                                                                                                                          (cos(conj(q2) + conj(q3) + conj(q4))*conj(g)*conj(m3))/5];
                                                                     
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
title('Brazo BBRMS -PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Angulo')
grid on; zoom on

figure(3)
plot(T,X5,'r-',T,X6,'b-',T,X7,'k-',T,X8,'g-',T,QDP(:,1),'r:',T,QDP(:,2),'b:',T,QDP(:,3),'k:',T,QDP(:,4),'g:')
title('Brazo BBRMS -PD de Torque  Computado')
xlabel('Tiempo (seg.)')
ylabel('Velocidad Angular')
grid on; zoom on