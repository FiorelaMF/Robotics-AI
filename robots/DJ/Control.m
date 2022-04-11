% Instrucciones Iniciales:
% ------------- ---------
close all; clear all; clc

% Algoritmo para el Control Robot Plotter con PDT:
% --------- ---- -- ------- ----- ------- --- ---
%% Condiciones Iniciales
a1max = pi/2;   % rad/s^2
v1max = 0.0278; % 1 minuto en la horizontal (5/3=1.667rad; 1.667rad/60seg=0.02778...)
a2max = 1;      % m/s^2
v2max = 0.0834; % 1 minuto en la vertical (0.0834*60=5.00..)

%% Constantes de la Trayectoria:
t0 = 0; dt = 0.01;
% Posciones q1 en radianes y q2 en metros:
%     q1 q2
x = [ 0 5 0 0 ]';
p0 = x(1:3,1);
p1 = [ 1.667 5]';
p2 = [ 1.667 0]';
p3 = [0 0]';
[R1 ,V1 ,A1 ] = trayectoriaC([a1max 0 ],[v1max 0 ],p0 ,p1 ,dt);
[R2 ,V2 ,A2 ] = trayectoriaC([ 0 a2max ],[ 0 v2max ],p1 ,p2 ,dt);
[R3 ,V3 ,A3 ] = trayectoriaC([a1max 0 ],[v1max 0 ],p2 ,p3 ,dt);
[R4 ,V4 ,A4 ] = trayectoriaC([ 0 a2max ],[ 0 v2max ],p3 ,p0 ,dt);
QD = [R1;R2;R3;R4];
QDP = [V1;V2;V3;V4];
QDPP = [A1;A2;A3;A4];
T = 0:(max(size(QD))-1);
T = T'*dt;
qd = QD(:,1:2)';
qdp = QDP(:,1:2)';
qdpp = QDPP(:,1:2)';

%% Constantes del Sistema:
% El material que se va a utilizar es una aleaci�n de Aluminio de peso
% exacto 2.7g/cm3; con un volumen en la primera masa de 5703.46cm3, por
% ende su peso es de 1.54kg; el volumen de la segunda masa de 2903cm3, por
% ende su peso es de 0.784kg:
m1 = 1.54; m2 = 0.784; g = 9.81;

%% Par�metros del Controlador
Kp = 250*eye(2); Kv = 30*eye(2); k = 1;

for t=0:dt:(max(T))
    % Almacenamiento de Variables:
    X1(k,1) = x(1);
    X2(k,1) = x(2);
    X3(k,1) = x(3);
    X4(k,1) = x(4);
    q1 = x(1);
    q2 = x(2);
    q1p = x(3);
    q2p = x(4);
    
    % Errores de Seguimiento:
    e  = qd(:,k) - x(1:2);
    ep = qdp(:,k) - x(3:4);
    E(k,1:2)  = e';
    EP(k,1:2) = ep';
    
    % C�lculo de las Matrices del Manipulador:
    % Matriz de Inercias:
    M = [ (2809*m2)/1600 0
                  0      m2 ];
    MI = inv(M); % Inversa de M(q)
    
    % Matriz de Fuerzas Centr�petas y de Coriolis:
    C =[ 0 0 ; 0 0 ];
    N = C*[ q1p q2p ]';
    
    % Vector de Gravedad:
    G = [ 0 ; g*m2 ];
    
    % Torque Computado (Se�al de Control):
    S   = qdpp(:,k) + Kv*ep + Kp*e;
    tau = M*S+N+G;
    
    % Ecuaci�n de Estado:
    xp = [ x(3:4) 
           MI*(-N-G+tau) ];
    
    % Integraci�n:
    x = x + xp*dt;
    k = k + 1;
end

% Error M�ximo obtenido:
E_max = max(max(E))*180/pi;

% Graficando las Variables:
figure(1)
plot(T,X1,'r-',T,X2,'b-', T,QD(:,1),'r:',T,QD(:,2),'b:')
% title('Robot-PD de Torque Computado')
title('Computed Torque Robot-PD')
xlabel('Time [s]')
ylabel('Amplitude [m]')
grid on; zoom on

figure(2)
plot(T,X3,'r-',T,X4,'b-',T, QDP(:,1),'r:',T,QDP(:,2),'b:')
% title('Robot-PD de Torque Computado')
title('Computed Torque Robot-PD')
xlabel('Time [s]')
ylabel('Speed ​​Amplitude')
grid on; zoom on

figure(3)
plot(T,E(:,1),'r',T,E(:,2),'b')
title('Error PD')
xlabel('Time [s]')
ylabel('Amplitude of Error')
grid on; zoom on