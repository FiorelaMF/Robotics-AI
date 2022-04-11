clear all
close all

% Altura
a = -200:10:1500; % Universo de Discursi�n.
a_CC = trimf(a,[ 0 0 500 ]); % T�rmino Cerca de Cero.
a_P = trimf(a,[ -200 300 800 ]); % T�rmino Peque�o.
a_M = trimf(a,[ 300 800 1300 ]); % T�rmino Medio.
a_G = trimf(a,[ 500 1000 1500 ]); % T�rmino Grande.
figure(1)
subplot(3,1,1)
plot(a,a_CC,'k',a,a_P,'r',a,a_M,'m',a,a_G,'g')
title('Funci�n de Membres�a de Altura')
legend('CC','P','M','G')
axis([0 1000 0 1])

% Velocidad Vertical
v = -30:30; % Universo de Discursi�n.
v_BG = trapmf(v,[-30 -30 -20 -10]); % T�rmino Bajada Grande.
v_BP = trimf(v,[-20 -10 0]); % T�rmino Bajada Peque�a.
v_C = trimf(v,[-10 0 10]); % T�rmino Cero.
v_SP = trimf(v,[0 10 20]); % T�rmino Subida Peque�a.
v_SG = trapmf(v,[10 20 30 30]); % T�rmino Subida Grande.

subplot(3,1,2)
plot(v,v_BG,'k',v,v_BP,'r',v,v_C,'m',v,v_SP,'g',v,v_SG,'b')
title('Funci�n de Membres�a de Velocidad Vertical')
legend('BG','BP','C','SP','SG')


% Fuerza
f = -30:30; % Universo de Discursi�n.
f_AG = trapmf(f,[-30 -30 -20 -10]); % T�rmino Abajo Grande.
f_AP = trimf(f,[-20 -10 0]); % T�rmino Abajo Peque�a.
f_CE = trimf(f,[-10 0 10]); % T�rmino Cero.
f_RP = trimf(f,[0 10 20]); % T�rmino Arriba Peque�a.
f_RG = trapmf(f,[10 20 30 30]); % T�rmino Arriba Grande.
subplot(3,1,3)
plot(f,f_AG,'k',f,f_AP,'r',f,f_CE,'m',f,f_RP,'g',f,f_RG,'b')
title('Funci�n de Membres�a de Fuerza')
legend('AG','AP','CE','RP','RG')
save fuzconavion


