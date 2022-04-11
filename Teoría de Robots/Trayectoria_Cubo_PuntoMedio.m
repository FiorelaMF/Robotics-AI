clear all
close all
%Posición cúbica con punto medio
tiempo = 3;
Pinicial = 15*pi/180;
Pmedio = 40*pi/180;
Pfinal = 75*pi/180;
dt=0.001;
k=1;

a10=Pinicial;
a11=0;
a12= (12*Pmedio-3*Pfinal-9*Pinicial)/(4*tiempo^2);
a13 = (-8*Pmedio+ 3*Pfinal+5*Pinicial)/(4*tiempo^3);
a20= Pmedio;

a21= (3*Pfinal-3*Pinicial)/(4*tiempo);
a22= (-12*Pmedio+6*Pfinal+6*Pinicial)/(4*tiempo^2)
a23= (8*Pmedio-5*Pfinal-3*Pinicial)/(4*tiempo^3)

for t =0:dt:tiempo

T(k,1) = t; 
Pfuncion1 = a10 + a11*t + a12*t^2 + a13*t^3;
Pf1(k,1)=Pfuncion1;
Vfuncion1 = a11+2*a12*t+3*a13*t^2;
Vf1(k,1)=Vfuncion1;
Afuncion1 = 2*a12+6*a13*t;
Af1(k,1)=Afuncion1;
k=k+1;
end
Pf2=Pf1;
Vf2=Vf1;
Af2=Af1;
for t =dt:dt:tiempo

    
T(k,1) = t; 
Pfuncion2 = a20 + a21*t + a22*t^2 + a23*t^3;
Pf2(k,1)=Pfuncion2;
Vfuncion2 = a21+2*a22*t+3*a23*t^2;
Vf2(k,1)=Vfuncion2;
Afuncion2 = 2*a22+6*a23*t;
Af2(k,1)=Afuncion2;
k=k+1;
end


figure(1)
plot(Pf2)
figure(2)
plot(Vf2)
figure(3)
plot(Af2)
