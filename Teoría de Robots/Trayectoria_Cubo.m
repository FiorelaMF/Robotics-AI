clear all
close all
clc

%Posición cúbica
tiempo = 2;
Pinicial = 15*pi/180;
Pfinal = 75*pi/180;
dt=0.001
k=1;

a0=Pinicial;
a1=0;
a2= 3*(Pfinal-Pinicial)/(tiempo^2);
a3 = -2*(Pfinal-Pinicial)/(tiempo^3);

for t =0:dt:tiempo

T(k,1) = t; 
Pfuncion = a0 + a1*t + a2*t^2 + a3*t^3;
Pf(k,1)=Pfuncion;
Vfuncion = a1+2*a2*t+3*a3*t^2;
Vf(k,1)=Vfuncion;
Afuncion = 2*a2+6*a3*t;
Af(k,1)=Afuncion;
k=k+1;
end
figure(1)
plot(Pf)
figure(2)
plot(Vf)
figure(3)
plot(Af)
