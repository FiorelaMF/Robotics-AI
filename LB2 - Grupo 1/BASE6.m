% 5 diseño de controlador PD teoria

clear all; close all
% Condiciones Iniciales
t0 = 0;
dt = 0.001; % Muy pequeño para simular continuidad
tf = 5;
x = [ 0.1 0 0 0 ]';
k = 1;
% Constantes de la Trayectoria
period = 2*pi; amp1 = 1; amp2 = 1;
fact = 2*pi/period;
% Constantes del Sistema
m1 = 1; m2 = 1; % masa (x10 kg)
a1= 22.25/2; % longitud del brazo (m)
a2= 22.25/2; %longitud del brazo (m)
g = 9.8; % Aceleración de la gravedad (m/s^2)
% Parámetros del Controlador
kp = 100; kv = 20;

for t=t0:dt:tf
    T(k,1) = t;
    X1(k,1) = x(1);
    X2(k,1) = x(2);
    X3(k,1) = x(3);
    X4(k,1) = x(4);
    %Trayectoria
    sinf = sin(fact*t);
    cosf = cos(fact*t);
    qd = [amp1*sinf amp2*cosf]';
    qdp = fact*[amp1*cosf -amp2*sinf]';
    qdpp = -fact^2*qd;
    QD(k,1:2) = qd';
    QDP(k,1:2) = qdp';
    % Errores de Seguimiento
    e = qd - [x(1) x(2)]';
    ep = qdp - [x(3) x(4)]';
    E(k,1:2) = e';
    EP(k,1:2) = ep';
    % Cálculo de las Matrices del Manipulador
    % Matriz de Inercias
    M11 = m1*a1^2*(cos(x(2)))^2;
    M12 = 0;
    M22 = m1*a1^2;
    M = [M11 M12;M12 M22];
    % Inversa de M(q)
    MI = inv(M);
    % Matriz de Fuerzas Centrípetas y de Coriolis
    N1 = -m1*a1^2*sin(2*x(2))*x(3)*x(4);
    N2 = -1/2*m1*a1^2*sin(2*x(2))*x(3)^2;
    N = [N1;N2];
    % Vector de Gravedad
    G1= 0;
    G2= m1*g*a1*cos(x(2));
    G= [G1;G2];
    % Torque Computado (Señal de Control)
    s1 = qdpp(1)+kv*ep(1)+kp*e(1);
    s2 = qdpp(2)+kv*ep(2)+kp*e(2);
    s = [ s1
        s2 ];
    tau = M*s+N+G;
    % Ecuación de Estado
    xp = [ x(3)
        x(4)
        MI*(-N-G+tau) ];
    % Integración
    x = x + xp*dt;
    k = k + 1;
end


figure(1)
plot(T,E(:,1),'b',T,E(:,2),'r')
title('Error Angular PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud del Error')
grid on; zoom on

figure(2)
plot(T,X1,'r-',T,X2,'b-',T,QD(:,1),'r:',T,QD(:,2),'b:')
legend('Theta 1','Theta 2','Theta Deseado 1','Theta Deseado 2')
title('Brazo Robot-PD de Torque Computado')
xlabel('Tiempo (seg.)')
ylabel('Amplitud de Error')
grid on; zoom on

% Trajectoria (PD) en espacio cartesiano
x_cart = a1*cos(X2).*sin(X1);
y_cart = a1*cos(X2).*cos(X1);
z_cart = a1*sin(X2);
xd_cart = a1*cos(QD(:,2)).*sin(QD(:,1));
yd_cart = a1*cos(QD(:,2)).*cos(QD(:,1));
zd_cart = a1*sin(QD(:,2));

% ********** 6 graficas de referencia, trayectorias **********
figure(3)
plot3(x_cart,y_cart,z_cart,'r-',xd_cart,yd_cart,zd_cart,'g-');
title(' Trayectoria del Extremo con un Controlador PD')
rotate3d on; grid on

figure(4)
title('Movimiento en ejes cartesianos')
subplot(311)
plot(T,x_cart,'r-',T,xd_cart,'g-')
ylabel('X')
zoom on; grid on

subplot(312)
plot(T,y_cart,'r-',T,yd_cart,'g-')
ylabel('Y')
zoom on; grid on

subplot(313)
plot(T,z_cart,'r-',T,zd_cart,'g-')
ylabel('Z')
zoom on; grid on