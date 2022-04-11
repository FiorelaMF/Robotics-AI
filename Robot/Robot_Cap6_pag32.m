clear all; close all
% Condiciones Iniciales
t0 = 0;
dt = 0.001; % Muy pequeño para simular continuidad
tf = 5;
x = [ 0.1 0 0 0 randn(1,60)]'; % Se agregan los valores de los pesos de la red.
k = 1;
% Constantes de la Trayectoria
period = 2*pi; amp1 = 1; amp2 = 1;
fact = 2*pi/period;
% Constantes del Sistema
m1 = 1; m2 = 1; % masa (x10 kg)
a1= 22.25/2; % longitud del brazo (m)
a2= 22.25/2; %longitud del brazo (m)
g = 9.81; % Aceleración de la gravedad (m/s^2)
% Parámetros del Controlador
Kv = 1000*eye(2); F = 2000*eye(10);
GG = 2000*eye(4); lam = 10*eye(2);
zb = 100; kz = 1; ks = 1;
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
xi = [ x(1) x(2) x(3) x(4) ]';
e = qd - [x(1) x(2)]';
ep = qdp - [x(3) x(4)]';
r = ep + lam*e;
E(k,1:2) = e';
EP(k,1:2) = ep';
% Cálculo de los Pesos de la Red Neuronal
% Peso W
for row = 1:2
for col = 1:10
W(col,row) = x(4+col+((row-1)*10),1);
end
end
% Peso V
for row = 1:10
for col = 1:4
V(col,row) = x(24+col+((row-1)*4),1);
end
end
% Cálculo de la Señal Robusta
sw = size(W);
sv = size(V);
Z = [ W zeros(sw(1,1),sv(1,2)); zeros(sv(1,1),sw(1,2)) V ];
ZF = sum(sum(Z.*Z));
% Sistema Difuso (Fuzzy Logic)
vt(1,1) = fuzrob(r(1),ZF);
vt(2,1) = fuzrob(r(2),ZF);
% Red Neuronal
nn = W'*logistic(V'*xi);

% Torque Computado (Señal de Control)
tau = nn+Kv*r-vt; % No es necesario el modelo matemático
% Actualización de Parámetros de los Pesos de la Red Neuronal
% W Punto
Wp = F*logistic(V'*xi)*r'-F*diag(logistic(V'*xi))* ...
(eye(size(max(V'*xi)))-diag(logistic(V'*xi)))*V'*xi*r' ...
-ks*F*norm(r)*W;
% V Punto
Vp = GG*xi*((diag(logistic(V'*xi))*(eye(max(size(V'*xi))) ...
-diag(logistic(V'*xi))))'*W*r)'-ks*GG*norm(r)*V;
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
% Ecuación de Estado y orden de pesos para la integración
xp(1,1) = x(3);
xp(2,1) = x(4);
xp(3:4,1) = MI*(-N-G+tau);
for i = 1:2
xp((5+(i-1)*10):(14+(i-1)*10),1) = Wp(1:10,i);
end
for i = 1:10
xp((21+i*4):(24+i*4),1) = Vp(1:4,i);
end
% Integración
x = x + xp*dt;
k = k + 1;
end


figure(1)
plot(T,E(:,1),'b',T,E(:,2),'r')
title('Error Angular Control Neural y Difuso')
xlabel('Tiempo (seg.)'); ylabel('Amplitud del Error')
grid on; zoom on
figure(2)
plot(T,X1,'r-',T,X2,'b-',T,QD(:,1),'r:',T,QD(:,2),'b:')
legend('Theta 1','Theta 2','Theta Deseado 1' ...
,'Theta Deseado 2')
title('Brazo Robot-Control Neural y Difuso')
xlabel('Tiempo (seg.)'); ylabel('Amplitud de Error')
grid on; zoom on
% Trajectoria en espacio cartesiano
x_cart = a1*cos(X2).*sin(X1);
y_cart = a1*cos(X2).*cos(X1);
z_cart = a1*sin(X2);
xd_cart = a1*cos(QD(:,2)).*sin(QD(:,1));
yd_cart = a1*cos(QD(:,2)).*cos(QD(:,1));
zd_cart = a1*sin(QD(:,2));
figure(3)
plot3(x_cart,y_cart,z_cart,'r-',xd_cart,yd_cart,zd_cart,'g-');
title(' Trayectoria del Extremo con un Controlador Neural y Difuso')
rotate3d on; grid on
figure(4)
subplot(311)
plot(T,x_cart,'r-',T,xd_cart,'g-')
ylabel('X');
zoom on; grid on
title('Movimiento en ejes cartesianos')
subplot(312)
plot(T,y_cart,'r-',T,yd_cart,'g-')
ylabel('Y');
zoom on; grid on
subplot(313)
plot(T,z_cart,'r-',T,zd_cart,'g-')
ylabel('Z');
zoom on; grid on

