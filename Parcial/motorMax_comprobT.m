clear all
close all
clc

%Código con las características del motor(Datos del motor)
LA = 0.0735*10^(-3);
RA = 1.62;
KT = 10.4*10^(-3);
KB = 1/(919*(pi)/30);
J = 3.97*10^(-3)*10^(-4);
TN = 10.8*10^(-3);
WN = 6640*(pi)/30;
B = 0.01*TN/WN; %Torque

AP = [0 1 0
      0 -B/J KT/J
      0 -KB/LA -RA/LA];
  
BP = [0; 0; 1/LA];

CP = [1 0 0];

DP = [0];

%Definiciones de Tiempos
ti=0; dt=0.00001; tf=3;

%Condiciones Iniciales
xen = [0.0 0.0 0.0]';

u=1; %señal escalón
k=1; %contador diferentes de Cero Diferentes de cero y la unidad.
TORC=0;
kk=0;
kkk=1;
ii=1;
Ureducido=0;

%Simulación
for tiempo = ti:dt:tf
%Almacenamiento de datos

%u=1*tiempo; %señal rampa
u=sin(2*pi*1*tiempo);
uu(k,1) = u;
tt(k,1) = tiempo;

kk=kk+1;

if (kk==1000) %Pasar o capturar datos de entrada de mil en mil, para disminuir carga computacional
    Ureducido(ii,1) = u;
    Xreducido(ii,1)=xen(1,1);
    Xreducido2(ii,1)=xen(2,1);
    Xreducido3(ii,1)=xen(3,1);
    kk=0;
    ii=ii+1;
    ttt(kkk,1)=ii;
    kkk=kkk+1;
end


% Sistema Estable No Homogeneo
%Guardar la data utilizando la Integración de Euler
x1en(k,1) = xen(1,1);
x2en(k,1) = xen(2,1);
x3en(k,1) = xen(3,1);

xenp = AP*xen + BP*u + [0; -1/J; 0]*TORC; %SISTEMA
yen = CP*xen + DP*u;
xen = xen + xenp*dt; %Integración de Euler
YP1N(k,1) = yen(1,1); %Se guarda la salida
k = k + 1;
end

%Gráficos
% figure(1);
% 
% subplot(2,2,1); plot(tt,x1en)
% title('Sistema Estable No Homogéneo')
% grid; ylabel('Posicion X1')
% subplot(2,2,2); plot(tt,x2en)
% grid; ylabel('Velocidad X2')
% subplot(2,2,3); plot(tt,x3en)
% grid; ylabel('Corriente X3')
% subplot(2,2,4); plot(tt,uu)
% grid; ylabel('Entrada')
    

Tam1 = size(Ureducido); %Ver el tamaño de datos de la señal de entrada al sistema

X = [Ureducido/max(Ureducido), Xreducido/max(Xreducido), Xreducido2/max(Xreducido2), Xreducido3/max(Xreducido3)]; %Entradas del sistema: [Voltaje, posicion, velocidad, corriente]]
%X = [Ureducido];

Dr = [Xreducido/max(Xreducido)]; %Salida: es la posicion; es así porque se basa en la Integracion de Euler

figure(1)
subplot(2,2,1); plot(ttt,(Xreducido/max(Xreducido)))
title('Sistema Estable No Homogeneo')
grid; ylabel('Posicion X1')
subplot(2,2,2); plot(ttt,(Xreducido2/max(Xreducido2)))
grid; ylabel('Velocidad X2')
subplot(2,2,3); plot(ttt,(Xreducido3/max(Xreducido3)))
grid; ylabel('Corriente X3')
subplot(2,2,4); plot(ttt,(Ureducido/max(Ureducido)))
grid; ylabel('Entrada')


b1=0.35;
b2=0.6;

load pesos
N = Tam1(1,1);  %inference
for k = 1:N
    x = X(k, :)';
    v1 = W1*x + b1;
    y1 = Sigmoid(v1);
    
    v = W2*y1 +b2;
    %y = Sigmoid(v);
    y=v;
    YY(k, :)=y;
end
%load es1

%es1(1,1)%+es1(2,1)
figure(2)
plot(ttt,(YY(:,1)*max(Xreducido)))
hold
plot(ttt,Dr(:,1)*max(Xreducido))

    


  