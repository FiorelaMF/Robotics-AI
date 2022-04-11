close all; clear all; clc

% constantes motor 222049
LA = 0.154*10^(-3);
RA = 3.18;
KT = 15.1*10^(-3);
KB = 1/(634*(pi)/30);
J = 4.22*10^(-7);
TN =12.4*10^(-3);
WN = 5870*(pi)/30;
B = 0.01*TN/WN;


AP = [0 1 0
      0 -B/J KT/J
      0 -KB/LA -RA/LA];
BP = [0; 0; 1/LA];
CP = [1 0 0];
DP = [0];

% Initial Conditions.
x1 = 0; %position
x2 = 0; %speed
x3 = 0; %current
x = [x1 x2 x3]';
u = 0;
r = 5;    % set point
ti=0;   dt = 0.00001;   tf=0.3;

% Simulation:
k = 1;
for t = ti:dt:tf
    X1(k,1) = x(1,1); %POSITION
    X2(k,1) = x(2,1); %SPEED
    X3(k,1) = x(3,1); %CURRENT
    U(k,1) = u; %VOLTAGE
    T(k,1)=t;
    % System
    xp = AP*x + BP*u; % + Wi*r;
    % Control
    err=r-x(1,1);%error
    Error(k,1)=err;
    u=motorfuzz(err,x(2,1)); %motorfuzz
    % Integration
    x = x + xp*dt;
    k = k + 1;
end

figure(1)
subplot(321); plot(T,X3,'b')
title('Control Difuso del Motor DC')
grid on; ylabel('X3 Current')

subplot(322); plot(T,X2,'b')
grid on; ylabel('X2 Velocidad')

subplot(323); plot(T,X1,'b')
grid on; ylabel('X1 Posicion')

subplot(324); plot(T,U,'b')
grid on; ylabel('Voltaje')

subplot(325); plot(T,Error,'b')
grid on; ylabel('Error')

k = 1; k1 = 1;
for x1 = -5:1:5;
    P(k,1) = x1;
    for x2 = -700:1:700;
        u = motorfuzz(x1,x2);
        V(k1,1) = x2;
        F(k,k1) = u;
        k1 = k1 + 1;
    end
    k = k+1;
end

% Gráfica de Superficie
save scpf P V F

figure(2);
surf(V,P,F)
shading interp
xlabel('Velocidad')
ylabel('Posicion')
zlabel('Salida de Control')
title('Control Surface')

