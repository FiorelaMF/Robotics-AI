%surfcon
close all
clear all
clc
sen = 3;
k = 1;
for dc = 200:-1:0
D(k,1) = dc;
for vc = 0:100
%ec = bolita(dc,vc);
ec = fuzconcarro(dc,vc,sen);
V(vc+1,1) = vc;
E(k,vc+1) = ec;
end
k = k+1;
end

save sc3 D V E
surf(V,D,E)
shading interp
xlabel('Velocidad')
ylabel('Distancia')
zlabel('Salida de Control')
title('Superficie de Control')
