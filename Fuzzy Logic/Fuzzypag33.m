clear all
close all
load fuzconavion
% Condiciones Iniciales
an = 1000; %pies.
vn = -20; % pies/seg.
% Interpolamos los valores
a_CCI = interp1(a,a_CC,an);
a_PI = interp1(a,a_P,an);
a_MI = interp1(a,a_M,an);
a_GI = interp1(a,a_G,an);
v_BGI = interp1(v,v_BG,vn);
v_BPI = interp1(v,v_BP,vn);
v_CI = interp1(v,v_C,vn);
v_SPI = interp1(v,v_SP,vn);
v_SGI = interp1(v,v_SG,vn);

% Reglas Difusas
r1 = min(a_GI,v_BGI);
r2 = min(a_GI,v_BPI);
r3 = min(a_GI,v_CI);
r4 = min(a_GI,v_SPI);
r5 = min(a_GI,v_SGI);
r6 = min(a_MI,v_BGI);
r7 = min(a_MI,v_BPI);
r8 = min(a_MI,v_CI);
r9 = min(a_MI,v_SPI);
r10 = min(a_MI,v_SGI);
r11 = min(a_PI,v_BGI);
r12 = min(a_PI,v_BPI);
r13 = min(a_PI,v_CI);
r14 = min(a_PI,v_SPI);
r15 = min(a_PI,v_SGI);
r16 = min(a_CCI,v_BGI);
r17 = min(a_CCI,v_BPI);
r18 = min(a_CCI,v_CI);
r19 = min(a_CCI,v_SPI);
r20 = min(a_CCI,v_SGI);
FAM = [ r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 ];

AG = [ r3 r4 r5 r9 r10 r15 ];
AP = [ r2 r8 r14 r19 r20 ];
CE = [ r1 r7 r13 r18 ];
RP = [ r6 r12 ];
RG = [ r11 r16 r17 ];
muAG = max(AG);
muAP = max(AP);
muCE = max(CE);
muRP = max(RP);
muRG = max(RG);
muAG = muAG*ones(size(f_AG));
muAP = muAP*ones(size(f_AP));
muCE = muCE*ones(size(f_CE));
muRP = muRP*ones(size(f_RP));
muRG = muRG*ones(size(f_RG));
figure(1)
plot(f,f_AG,'k',f,f_AP,'r',f,f_CE,'m',f,f_RP,'g',f,f_RG,'b',f,muAG,'k:',f,muAP,'r:',f,muCE,'m:',f,muRP,'g:',f,muRG,'b:')
title('Función de Membresía de Fuerza con valores de corte')
pause(5)

muAG = min(muAG,f_AG);
muAP = min(muAP,f_AP);
muCE = min(muCE,f_CE);
muRP = min(muRP,f_RP);
muRG = min(muRG,f_RG);
figure(1)
plot(f,muAG,'k',f,muAP,'r',f,muCE,'m',f,muRP,'g',f,muRG,'b')
title('Función de Membresía de Fuerza con Conjuntos Cortados')
axis([-30 30 0 1])
pause(5)

muF = max([muAG; muAP; muCE; muRP; muRG]);
figure(1)
plot(f,muF,'b')
title('Función de Membresía de Fuerza Unión de Conjuntos')
axis([-30 30 0 1])
pause(5)

% Defuzzificando
fn = defuzz(f,muF,'centroid');
hold on
plot([fn fn],[0 1],'r')


