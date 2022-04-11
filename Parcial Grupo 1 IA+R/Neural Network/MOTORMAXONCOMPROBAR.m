% Neural Network Output
% MOTORMAXONCOMPROBAR
% figure 19

clear; close all; clc;

LA = 0.251*10^(-3);
RA = 5.11;
KT= 19.2*10^(-3);
KB= 1/(497*(pi)/30);
J= 4.26*10^(-7);
TN=12.3*10^(-3);
WN= 7240*(pi)/30;
B=0.01*TN/WN;

AP=[0 1 0
    0 -B/J KT/J
    0 -KB/LA -RA/LA];
BP=[0; 0; 1/LA];
CP=[1 0 0];
DP=0;


ti=0;dt=0.00001;tf=1.5;

xen=[0.0 0.0 0.0]';


u=1;
k=1;  
TORC=0;
kk=0;
kkk=1;
ii=1;
Ureducido=0;

for tiempo=ti:dt:tf
%     u=sin(2*pi*1*tiempo);
%     u=1*tiempo;
    
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
    
    
    x1en(k,1)=xen(1,1);
    x2en(k,1)=xen(2,1);
    x3en(k,1)=xen(3,1);
    
    xenp=AP*xen+BP*u+[0;-1/J;0]*TORC; 
    yen=CP*xen+DP*u;
    xen=xen+xenp*dt; 
    YP1N(k,1)=yen(1,1);
    k=k+1;
end

tam1=size(Ureducido);
X = [Ureducido/max(Ureducido),Xreducido/max(Xreducido),Xreducido2/max(Xreducido2),Xreducido3/max(Xreducido3)];

Dr = [Xreducido/max(Xreducido)];


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



load Pesos W1 W2


for k=1:150
    x  = X(k,:)';
    v1 = W1*x;
    y1 = Sigmoid(v1);

    v2 = W2*y1;
    y = Sigmoid(v2);
    YY(k,:)=y;
end
figure(2)
plot(ttt,(YY*max(Xreducido)),'r',ttt,Dr*max(Xreducido),'bo')
legend('RN','OUTPUT')




