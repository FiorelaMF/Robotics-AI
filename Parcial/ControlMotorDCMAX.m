clear all
close all 
clc 

LA = 0.154*10^(-3);
RA= 3.18;
KT=15.1*10^(-3);
KB= 1/(634*(pi)/30);
J=4.22*10^-7;
TN=12.4*10^-3; 
WN=5870*pi/30; 
B=0.01*TN/WN;
% LA = 0.0735*10^(-3);
% RA= 1.62;
% KT=10.4*10^(-3);
% KB= 1/(919*(pi)/30);
% J=3.97*10^-7;
% TN=10.8*10^-3; 
% WN=6640*pi/30; 
% B=0.01*TN/WN;

AP = [0 1 0
    0 -B/J KT/J
    0 -KB/LA -RA/LA];

BP = [0; 0; 1/LA];

CP = [1 0 0];

DP = [0];

%Condiciones Iniciales
x1=0;       %posicion en rad
x2=0;     %velocidad en rad/seg
x3=0;
x=[x1 x2 x3]';
u=0;
r=12;        %set point de posicion
ti=0; dt=0.00001; tf=0.3;
k=1;
%simulacion
for t=ti:dt:tf
    X1(k,1)=x(1,1); %POSICION
    X2(k,1)=x(2,1); %VELOCIDAD
    X3(k,1)=x(3,1); %CORRIENTE
    U(k,1) = u;
    T(k,1) = t;
%sistema
    xp=AP*x+BP*u;
%ley de control    
err=r-x(1,1); %error
Error(k,1)=err;
u=motorfuzz(err,x(2,1));
%integración
x=x+xp*dt;
k=k+1;
%Comando de parada
%if((x(1,1)>r-0.00001)&(x(1,1)+r<r+0.00001))| (t>tf)
%break
%end
%plot(T,U)
end
figure(1)
subplot(3,2,1); plot(T,X3)
title('Control Difuso de Motor DC')
grid; ylabel('Corriente X3')
subplot(3,2,2); plot(T,X2)
grid; ylabel('Velocidad X2')
subplot(3,2,3); plot(T,X1)
grid; ylabel('Posicion X1')
subplot(3,2,4); plot(T,U)
grid; ylabel('Voltaje')
subplot(3,2,5); plot(T,Error)
grid; ylabel('Error')
