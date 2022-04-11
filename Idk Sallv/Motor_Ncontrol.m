clear all; close all; clc

%constantes
J = 0.01;
b = 0.1;
K = 0.01;
R = 1;
L = 0.5;

% Matrices del sistema

A = [ -R/L -K/L 0
        K/J -b/J 0
        0 1 0];
B = [1/L 
     0 
     0];
C = [0 0 1
    K 0 0];
D = [0
     0];
 
% Estabilidad
polos = eig(A);

% Controlabilidad 
CC = [B A*B A*A*B];

% Observabilidad
OO = [C ; C*A ; C*A*A];


% Tiempos 
ti =0;
dt = 0.001;
tf = 5;

% condiciones iniciales

x = [0 0 0]';
u = 1;
k=1; %contador

% Simulacion

for t = ti:dt:tf
%     almacenamiento
    X1(k,1) = x(1,1); %intensidad
    X2(k,1) = x(2,1); %velocidad angular
    X3(k,1) = x(3,1); %posicion angular
    T(k,1) = t;       %Tiempo
    
    %sistema
    xp = A*x + B*u; %Ecuacion del sistema
    y  = C*x + D*u; %Ecuacion de Salida
    
    k = k + 1;
    x = x + xp*dt; % "integracion" de x    porque x' = dx/ dt     x' = xp y tengo dt
end

figure(1)
subplot(211)
plot(T,X3,"b"); grid on
ylabel("Posicion Angular");

subplot(223)
plot(T,X2,"b"); grid on
ylabel("Velocidad Angular");

subplot(224)
plot(T,X3,"b"); grid on
ylabel("Intensidad");

