clear all; clc; close all

% Matrices del sistema
A = [-2 0 -0.02
      0 0  1
      1 0 -10   ];
  
B = [0.2
     0
     0];
 
C = [0 1 0];

D = 0;






% Definicion de tiempos
ti = 0 ; dt = 0.001; tf =3;


% condiciones iniciales
x = [0 0 0]';
u = 1


k = 1
for t = ti:dt:tf
    TI(k,1) = t;
    X1(k,1) = x(1,1);
    X2(k,1) = x(2,1);
    X3(k,1) = x(3,1);
    
%     sistema
    xp = A*x + B*u;
    y  = C*x + D*u;
    
    Y(k,1) = y;
    
    x = x + xp*dt;
    
    k = k+1;
    
end


figure(1)
plot(TI,Y,"k")
grid on


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % r
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


% Preparando datos para el entrenamiento

u =    12*randn(1,2000);
i =    5*randn(1,2000);
th =   pi*randn(1,2000);
thp = pi/2*randn(1,2000);

xd = [i ; th ; thp];
entradas = [u ; i; th; thp];

figure(2)
subplot(211)
plot(entradas')
ylabel("Datos de entrada")
legend("u","i","th","thp")

xdp = A*xd + B*u;
xd = xd + xdp*dt;


subplot(212)
plot(xd')
ylabel("Salidas objetivo")
legend("i","th","thp")

objetivos = xd;


save DatosMotorDC entradas objetivos










