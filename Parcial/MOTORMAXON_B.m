clear all
close all 
clc 

LA = 0.0735*10^(-3);
RA= 1.62;
KT=10.4*10^(-3);
KB= 1/(919*(pi)/30);
J=3.97*10^-7;
TN=10.8*10^-3; 
WN=6640*pi/30; 
B=0.01*TN/WN;

AP = [0 1 0
    0 -B/J KT/J
    0 -KB/LA -RA/LA];

BP = [0; 0; 1/LA];

CP = [1 0 0];

DP = [0];

% Definiciones de Tiempos
ti=0; dt=0.00001; tf=3;

% Condiciones Iniciales
xen= [ 0.0 0.0 0.0]';

u=1;    %señal escalon
k=1;    %Contador Diferente de Cero diferentes de cero y de la unidad.
TORC =0;
kk=0;
kkk=1;
ii=1;
Ureducido=0;

% Simulación
for tiempo = ti:dt:tf
    u=1*tiempo;
    %u=sin(2*pi*1*tiempo);
    uu(k,1)=u;
    tt(k,1)=tiempo;
    kk=kk+1;
    
    if(kk==1000)
        Ureducido(ii,1)=u;
        Xreducido(ii,1)=xen(1,1);
        Xreducido2(ii,1)=xen(2,1);
        Xreducido3(ii,1)=xen(3,1);
        kk=0;
        ii=ii+1;
        ttt(kkk,1)=ii;
        kkk=kkk+1;
    end
    
    %Sistema Estable No Homogeneo
    x1en(k,1)=xen(1,1);
    x2en(k,1)=xen(2,1);
    x3en(k,1)=xen(3,1);
    
    xenp=AP*xen+BP*u+[0; -1/J; 0]*TORC; %Sistema
    yen =CP*xen+ DP*u;
    xen= xen+ xenp*dt; %Integración
    YP1N(k,1)=yen(1,1);
    k=k+1;
end
%figure(1)

%subplot(2,2,1); plot(tt,x1en)
%title('Sistema Estable No Homogeneo')
%grid; ylabel('Posicion X1')
%subplot(2,2,2); plot(tt,x2en)
%grid; ylabel('Velocidad X2')
%subplot(2,2,3); plot(tt,x3en)
%grid; ylabel('Corriente X3')
%subplot(2,2,4); plot(tt,uu)
%grid; ylabel('Entrada')


Tam1= size(Ureducido);
X= [Ureducido/max(Ureducido),Xreducido/max(Xreducido), Xreducido2/max(Xreducido2), Xreducido3/max(Xreducido3)];

D= [Xreducido/max(Xreducido)];

figure(1)
subplot(2,2,1); plot(ttt,Xreducido/max(Xreducido))
title('Sistema Estable No Homogeneo')
grid; ylabel('Posicion X1')
subplot(2,2,2); plot(ttt,Xreducido2/max(Xreducido2))
grid; ylabel('Velocidad X2')
subplot(2,2,3); plot(ttt,Xreducido3/max(Xreducido3))
grid; ylabel('Corriente X3')
subplot(2,2,4); plot(ttt,Ureducido/max(Ureducido))
grid; ylabel('Entrada')

W1 = 2*rand(16,4)-1;
W2 = 2*rand(1,16)-1;

b1 = 0.35;
b2 = 0.6;

for epoch = 1:1000
    %train
    [W1 W2] = MiEntrenamiento_2Capas(W1,W2,X,D);
end

N= Tam1(1,1);  %interference
for k =1:N
    x = X(k,:)';
    v1 = W1*x + b1;
    y1 = Sigmoid(v1);
    v = W2*y1 +b2;
    y=v;
    YY(k,:)=y;
end

figure(2)
plot(ttt,YY(:,1)*max(Xreducido))
hold
plot(ttt,D(:,1)*max(Xreducido))

save pesos
  