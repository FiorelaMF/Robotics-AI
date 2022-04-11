% 5 Membership Function Motor System 
% MOTOR 
% figure 13 & 15 
close all; clear all; clc

%222051
LA = 0.251*10^(-3);
RA = 5.11;
KT= 19.2*10^(-3);
KB= 1/(497*(pi)/30);
J= 4.26*10^(-7);
TN=12.3*10^(-3);
WN= 7240*(pi)/30;
B=0.01*TN/WN;

AP = [0 1 0
    0 -B/J KT/J
    0 -KB/LA -RA/LA];
BP = [0; 0; 1/LA];
CP = [1 0 0];
DP = [0];

x1=0;
x2=0;
x3=0.00;
x=[x1 x2 x3]';
u=0;
r=5;
ti=0;%dt=0.00001;
dt = 0.00001;
tf=0.15;

k = 1;
for t = ti:dt:tf
    X1(k,1) = x(1,1);
    X2(k,1) = x(2,1);
    X3(k,1) = x(3,1); 
    U(k,1) = u; 
    T(k,1)=t;
    
    xp = AP*x + BP*u; 
    
    err=r-x(1,1);%error
    Error(k,1)=err;
    u=motorfuzz(err,x(2,1));
    
    x = x + xp*dt;
    k = k + 1;
end

figure(1)
subplot(321)
plot(T,X3,'b')
title('Motor DC Diffuse Control')
grid on; ylabel('X3 Current')

subplot(322)
plot(T,X2,'b')
grid on; ylabel('X2 Speed')

subplot(323)
plot(T,X1,'b')
grid on; ylabel('X1 Position')
subplot(324)
plot(T,U,'b')
grid on; ylabel('Voltage')
subplot(325)
plot(T,Error,'b')
grid on; ylabel('Error')


k = 1; k1 = 1;
for x1 = -5:1:5;
    P(k,1) = x1;
    for x2 = -700:1:700;
        u = motorfuzz(x1,x2);
        V(k1,1) = x2;
        F(k,k1) = u;
        k1 = k1 + 1;
    end
    k = k+1;
end
save scpf P V F

figure(2)
surf(V,P,F)
shading interp
xlabel('Speed')
ylabel('Positión')
zlabel('Control Output')
title('Control Surface')










