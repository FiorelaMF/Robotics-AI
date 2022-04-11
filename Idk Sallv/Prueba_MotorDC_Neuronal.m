clear all; clc; close all
load DatosMotorDC
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
    
%     Sistema Neuronal
    YNN(:,k) = purelin(W2*logsig(W1*[u;x] + b1) + b2);
    
    
    x = x + xp*dt;
    
    k = k+1;
    
end


figure(1)
plot(TI,Y,"k+",TI,YNN(2,:),"r")
grid on
legend("real","neural")










