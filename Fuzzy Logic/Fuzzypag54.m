% surfconpen
close all; clear all; clc

k = 1; k1 = 1;
for x1 = -0.4:0.01:0.4
P(k,1) = x1;
for x2 = -0.2:0.01:0.2
u = contpenfuz(x1,x2);
V(x2*100+201,1) = x2;
F(k,x2*100+201) = u;
%k1 = k1 + 1;
end
k = k+1;
end
save scpf P V F


surf(V,P,F)
shading interp
xlabel('Velocidad')
ylabel('Posición')
zlabel('Fuerza')
title('Superficie de Control')