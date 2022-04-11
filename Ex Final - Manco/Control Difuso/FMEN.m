clear all; close all; clc

% FUNCIONES DE MEMBRESÍA (MOTOR 222049)
x1=-13:0.1:13;

x1_EAN= trapmf(x1,[-13 -13 -4.33 0]);
x1_N = trimf(x1,[-4.33 0 4.33]);
x1_EAP =trapmf(x1,[0 4.33 13 13]);

figure(1)
subplot(311); plot(x1,x1_EAN,'b',x1,x1_N,'g',x1,x1_EAP,'r'); 
grid on; title('x1 = Error Angular'); axis([-13 13 0 1]);
legend('Alto Negativo','Neutral','Alto Positivo'); 


% FM Velocidad Angular
x2 = -600:0.1:600;
x2_VAN = trapmf(x2,[-600 -600 -300 0]);
x2_N = trimf(x2,[-300 0 300]);
x2_VAP = trapmf(x2,[0 300 600 600]);

subplot(312); plot(x2,x2_VAN,'b',x2,x2_N,'g',x2,x2_VAP,'r'); 
grid on; title('x2 = Velocidad Angular'); axis([-600 600 0 1]);
legend('Alto Negativo','Neutral','Alto Positivo');

% FM Ley de control
u = -12:0.1:12;

u_BN = trimf(u,[-5 -3 0]*1);
u_P= trimf(u,[-3 0 3]*1);
u_BP= trimf(u,[0 3 5]*1);

subplot(313);
plot(u,u_BN,'b',u,u_P,'g',u,u_BP,'k');
grid on; title('u = Voltaje de Salida'); axis([-12 12 0 1]);
legend('Bajo Negativo','Para','Bajo Positivo'); 

save FM_Motor
