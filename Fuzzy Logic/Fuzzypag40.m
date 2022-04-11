% surfcon avion
close all
clear all
clc
sen = 3;
k = 1;
for a = 0:10:1000
A(k,1) = a;
for v = -30:30
f = fcavion(a,v);
V(v+31,1) = v; F(k,v+31) = f;
end
k = k+1;
end
save sc4 A V F
surf(V,A,F);shading interp



xlabel('Velocidad');ylabel('Altura');zlabel('Fuerza de Control')
title('Superficie de Control')