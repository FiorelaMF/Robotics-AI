clear all; close all; clc

%constantes
LA=0.0735*10^(-5);
RA=1.62;
KT=10.4*10^(-3);
KB=1/(919*(pi)/30);
J=3.97*10^(-7);
TN=10.8*10^(-3);
WN=6640*pi/30;
B=0.01*TN/WN;
%MODELO
AP=[0 1 0
    0 -B/J KT/J
    0 -KB/LA -RA/LA];
BP=[0; 0; 1/LA];
CP=[1 0 0];
DP=[0];

ti=0;dt=0.00001;%tf=0.3;
tf = 3;

%CONDICIONES INICIALES
xen=[0.0 0.0 0.0]';
u=1;
k=1;
TORC=0;
kk=0;
kkk=1;
ii=1;
Ureducido=0;

% Simulación
for tiempo=ti:dt:tf
    u=sin(2*pi*1*tiempo);
    %u=1*tiempo;
    
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
    
    % Sistema Estable No Homogeneo
    x1en(k,1)=xen(1,1);
    x2en(k,1)=xen(2,1);
    x3en(k,1)=xen(3,1);
    
    xenp=AP*xen + BP*u + [0; -1/J; 0]*TORC;
    yen=CP*xen+DP*u;
    xen=xen+xenp*dt;
    YP1N(k,1)=yen(1,1);
    k=k+1;
end


tam1=size(Ureducido);
X=[Ureducido/max(Ureducido),Xreducido/max(Xreducido),Xreducido2/max(Xreducido2),Xreducido3/max(Xreducido3)];

Dr=[Xreducido/max(Xreducido)];

figure(1)
subplot(221);plot(ttt,(Xreducido/max(Xreducido))) 
title('Sistema estable no homogeneo')
grid on; ylabel('Posicion X1')
subplot(222);plot(ttt,(Xreducido2/max(Xreducido2))) 
grid on; ylabel('Velocidad X2')
subplot(223);plot(ttt,(Xreducido3/max(Xreducido3))) 
grid on; ylabel('Corriente X3')
subplot(224);plot(ttt,(Ureducido/max(Ureducido))) 
grid on; ylabel('Entrada')

b1=0.35;
b2=0.6;

%W1=1*rand(16,4)-1;
%W2=1*rand(1,16)-1;

load Pesos

N=tam1(1,1);

for k=1:N
    x=X(k,:)';
    v1=W1*x+b1;
    y1=Sigmoid(v1);
    
    v=W2*y1+b2;
    y=v;
    YY(k,:)=y;
end
figure(2)
plot(ttt,(YY(:,1)*max(Xreducido))) 
hold
plot(ttt,(Dr(:,1)*max(Xreducido))) 
