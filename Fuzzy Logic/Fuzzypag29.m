clear all
close all

% Altura
a = -200:10:1500; % Universo de Discursión.
a_CC = trimf(a,[ 0 0 500 ]); % Término Cerca de Cero.
a_P = trimf(a,[ -200 300 800 ]); % Término Pequeño.
a_M = trimf(a,[ 300 800 1300 ]); % Término Medio.
a_G = trimf(a,[ 500 1000 1500 ]); % Término Grande.
figure(1)
subplot(3,1,1)
plot(a,a_CC,'k',a,a_P,'r',a,a_M,'m',a,a_G,'g')
title('Función de Membresía de Altura')
legend('CC','P','M','G')
axis([0 1000 0 1])

% Velocidad Vertical
v = -30:30; % Universo de Discursión.
v_BG = trapmf(v,[-30 -30 -20 -10]); % Término Bajada Grande.
v_BP = trimf(v,[-20 -10 0]); % Término Bajada Pequeña.
v_C = trimf(v,[-10 0 10]); % Término Cero.
v_SP = trimf(v,[0 10 20]); % Término Subida Pequeña.
v_SG = trapmf(v,[10 20 30 30]); % Término Subida Grande.

subplot(3,1,2)
plot(v,v_BG,'k',v,v_BP,'r',v,v_C,'m',v,v_SP,'g',v,v_SG,'b')
title('Función de Membresía de Velocidad Vertical')
legend('BG','BP','C','SP','SG')


% Fuerza
f = -30:30; % Universo de Discursión.
f_AG = trapmf(f,[-30 -30 -20 -10]); % Término Abajo Grande.
f_AP = trimf(f,[-20 -10 0]); % Término Abajo Pequeña.
f_CE = trimf(f,[-10 0 10]); % Término Cero.
f_RP = trimf(f,[0 10 20]); % Término Arriba Pequeña.
f_RG = trapmf(f,[10 20 30 30]); % Término Arriba Grande.
subplot(3,1,3)
plot(f,f_AG,'k',f,f_AP,'r',f,f_CE,'m',f,f_RP,'g',f,f_RG,'b')
title('Función de Membresía de Fuerza')
legend('AG','AP','CE','RP','RG')
save fuzconavion


