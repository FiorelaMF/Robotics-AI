close all; clear all; clc
% Condiciones iniciales
an = 1000;
vn = -20;
for k = 1:400
% Almacenamiento de las variables
A(k,1) = an; V(k,1) = vn;
% Controlador
fn = fcavion(an,vn);
% Denormalizando
fn = 2*(fn-5.512);
F(k,1) = fn;
% Sistema
an = an + vn;
vn = vn + fn;
% Comando de Parada
if ((an>0)&&(an<3)), break;end
end
% Ploteos
figure(1)
subplot(311)
plot(A);title('Altura');grid on
subplot(312)
plot(V);title('Velocidad');grid on
subplot(313)
plot(F);title('Fuerza');grid on