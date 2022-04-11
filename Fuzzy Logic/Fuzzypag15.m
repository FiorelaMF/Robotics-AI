
clear all
close all
load fuzzy_data_carro
% Condiciones
den = 158; % metros
vcn = 23; % metros por segundo
sen = 3; % 1=verde; 2=ambar; 3=rojo

% Interpolando
de_CI = interp1(de,de_C,den);
de_MI = interp1(de,de_M,den);
de_GI = interp1(de,de_G,den);
vc_LI = interp1(vc,vc_L,vcn);
vc_II = interp1(vc,vc_I,vcn);
vc_RI = interp1(vc,vc_R,vcn);
se_VI = interp1(se,se_V,sen);
se_AI = interp1(se,se_A,sen);
se_RI = interp1(se,se_R,sen);


% Reglas Difusas
dv1 = min(de_CI,vc_LI); % Distancia versus Velocidad.
dv2 = min(de_CI,vc_II);
dv3 = min(de_CI,vc_RI);
dv4 = min(de_MI,vc_LI);
dv5 = min(de_MI,vc_II);
dv6 = min(de_MI,vc_RI);
dv7 = min(de_GI,vc_LI);
dv8 = min(de_GI,vc_II);
dv9 = min(de_GI,vc_RI);
DV = [ dv1 dv2 dv3 dv4 dv5 dv6 dv7 dv8 dv9 ]';
ds1 = min(de_CI,se_VI); % Distancia versus Semáforo.
ds2 = min(de_CI,se_AI);
ds3 = min(de_CI,se_RI);
ds4 = min(de_MI,se_VI);
ds5 = min(de_MI,se_AI);
ds6 = min(de_MI,se_RI);
ds7 = min(de_GI,se_VI);

ds8 = min(de_GI,se_AI);
ds9 = min(de_GI,se_RI);
DS = [ ds1 ds2 ds3 ds4 ds5 ds6 ds7 ds8 ds9 ]';
vs1 = min(se_VI,vc_LI); % Velocidad versus Semáforo.
vs2 = min(se_VI,vc_II);
vs3 = min(se_VI,vc_RI);
vs4 = min(se_AI,vc_LI);
vs5 = min(se_AI,vc_II);
vs6 = min(se_AI,vc_RI);
vs7 = min(se_RI,vc_LI);
vs8 = min(se_RI,vc_II);
vs9 = min(se_RI,vc_RI);
VS = [ vs1 vs2 vs3 vs4 vs5 vs6 vs7 vs8 vs9 ]';
FAM = [ DV DS VS ];

% Operación Fuzzy
F= [ dv1 dv2 dv3 dv6 ds3 vs7 vs8 vs9 ];
N = [ dv5 dv9 ds2 ds6 vs4 vs5 vs6 ];
A= [ dv4 dv7 dv8 ds1 ds4 ds5 ds7 ds8 ds9 vs1 vs2 vs3 ];


muF = max(F);
muN = max(N);
muA = max(A);

muF = muF*ones(size(ec_F));
muN = muN*ones(size(ec_N));
muA = muA*ones(size(ec_A));
figure(1)
plot(ec,ec_F,'g-',ec,ec_N,'b-',ec,ec_A,'r-',ec,muF,'g:',ec,muN,'b:',ec,muA,'r:')
title('Función de Membresía EC y valores de corte')
pause(5)

muF = min(muF,ec_F);
muN = min(muN,ec_N);
muA = min(muA,ec_A);
figure(1)
plot(ec,muF,'g',ec,muN,'b',ec,muA,'r')
title('Función de Membresía EC con Conjuntos Cortados')
axis([0 100 0 1])
pause(5)

muZ = max([muF; muN; muA]);
figure(1)
plot(ec,muZ,'b')
title('Función de Membresía EC Unión de Conjuntos')
axis([0 100 0 1])
pause(5)

% Defuzzificando
ecn = defuzz(ec,muZ,'centroid');
hold on
plot([ecn ecn],[0 1],'r')