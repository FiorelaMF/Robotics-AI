close all; clear all; clc
% Matrices del Sistema
A = [0 1; 0 0];
B = [0 1/800]';
% Constantes de la Denormalización
a = 300;
b = 48;
% Tiempos de simulación
ti = 0;
dt = 0.01;
tf = 35;
% Condiciones iniciales
den = 158; % metros
vcn = 23; % metros por segundo
sen = 3; % 1=verde; 2=ambar; 3=rojo
f = 1; % Fuerza inicial 1 Nt.
x = [den; vcn];
k = 1;

for t = ti:dt:tf
% Almacenamiento de las variables
D(k,1) = x(1,1);
V(k,1) = x(2,1);
F(k,1) = f;
S(k,1) = sen;
T(k,1) = t;
% Sistema
xp = A*x +B*f;
AA(k,1) = xp(2,1);
% Controlador
u = fuzconcarro(x(1,1),x(2,1),sen);
U(k,1) = u;
% Denormalización
f = a*(u-b);
% Integración por Euler
x(1,1) = x(1,1) - xp(1,1)*dt;
x(2,1) = x(2,1) + xp(2,1)*dt;
% Consideración de velocidad
if x(2,1) > 100,x(2,1) = 100;end
% Comando de Parada
if (x(1,1)>-2)&(x(1,1)<0)&(sen==3), break;end
k = k + 1;
end


% Ploteos
figure(1)
subplot(2,2,1)
plot(T,D);title('Distancia')
subplot(2,2,2)
plot(T,V);title('Velocidad')
subplot(2,2,3)
plot(T,AA);title('Aceleración')
subplot(2,2,4)
plot(T,U,'r',T,F,'b');title('Control y Fuerza')



