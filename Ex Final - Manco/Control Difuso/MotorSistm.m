% MOTORMAXON

clear all; close all; clc
load FM_MOTOR

% constantes motor 222049
LA = 0.154*10^(-3);
RA = 3.18;
KT = 15.1*10^(-3);
KB = 1/(634*(pi)/30);
J = 4.22*10^(-7);
TN = 12.4*10^(-3);
WN = 5870*(pi)/30;
B = 0.01*TN/WN;

%MODEL
AP = [0 1 0
      0 -B/J KT/J
      0 -KB/LA -RA/LA];
BP = [0; 0; 1/LA];
CP = [1 0 0];
DP = [0];

%Time Definitions
ti=0;   dt=0.00001;    tf=3;

%Initial Conditions
xen=[0.0 0.0 0.0]';
u=1;
k=1;    
TORC=0;
kk=0;
kkk=1;
ii=1;
Ureducido=0;

% Simulacion
for tiempo=ti:dt:tf
    u=sin(2*pi*1*tiempo);  %senoidal
    %u=1*tiempo;            %rampa
    
    uu(k,1)=u;
    tt(k,1)=tiempo;
    kk=kk+1;
    
    if(kk==300)    % captura la señal cada kk valores
        Ureducido(ii,1)=u;
        Xreducido(ii,1)=xen(1,1);
        Xreducido2(ii,1)=xen(2,1);
        Xreducido3(ii,1)=xen(3,1);
        kk=0;
        ii=ii+1;
        ttt(kkk,1)=ii;
        kkk=kkk+1;
    end
    
    % Stable Non-Homogeneous System 
    x1en(k,1) = xen(1,1);
    x2en(k,1) = xen(2,1);
    x3en(k,1) = xen(3,1);
    
    xenp = AP*xen + BP*u + [0; -1/J; 0]*TORC; %System
    yen = CP*xen + DP*u;
    xen = xen + xenp*dt; %Integration
    YP1N(k,1)=yen(1,1);
    k = k+1;
end

tam1=size(Ureducido);

% entradas
X = [Ureducido/max(Ureducido),Xreducido/max(Xreducido),Xreducido2/max(Xreducido2),Xreducido3/max(Xreducido3)];

% salida
D = [Xreducido/max(Xreducido)];

figure(1)
subplot(221);plot(ttt,(Xreducido/max(Xreducido))) 
title('Sistema Estable no homogéneo')
grid on; ylabel('Posicion X1')
subplot(222);plot(ttt,(Xreducido2/max(Xreducido2))) 
grid on; ylabel('Velocidad X2')
subplot(223);plot(ttt,(Xreducido3/max(Xreducido3))) 
grid on; ylabel('Corriente X3')
subplot(224);plot(ttt,(Ureducido/max(Ureducido))) 
grid on; ylabel('Entrada')



