clear all 
close all
% Distancia a la Esquina
de = 0:0.1:200; % Universo de Discursi�n.
de_C = trapmf(de,[ 0 0 25 100 ]); % T�rmino Chica.
de_M = trimf(de,[ 0 100 175 ]); % T�rmino Media.
de_G = trapmf(de,[100 175 200 200 ]); % T�rmino Grande.

figure(1)
plot(de,de_C,'r-',de,de_M,'b-',de,de_G,'m-')
title('Funci�n de Membres�a de Distancia a la Esquina')
legend('Chico','Medio','Grande')


% Velocidad del Carro
vc = 0:0.1:100; % Universo de Discursi�n.
% De la Velocidad del Carro
vc_L = trapmf(vc,[ 0 0 12.5 35 ]); % T�rmino Lento.
vc_I = trimf(vc,[ 12.5 50 87.5 ]); % T�rmino Intermedio.
vc_R = trapmf(vc,[65 87.5 100 100 ]); % T�rmino R�pido.
figure(2)
plot(vc,vc_L,'r-',vc,vc_I,'b-',vc,vc_R,'m-')
title('Funci�n de Membres�a de la Velocidad del Carro')
legend('Lento','Intermedio','R�pido')


% Sem�foro
se = 0:0.1:4; % Universo de Discursi�n.
% El sem�foro solamente al ambar cuando va de verde a rojo.
% Del Sem�foro
se_V = trapmf(se,[ 0 0 1 2 ]); % T�rmino Verde.
se_A = trimf(se,[ 1 2 3 ]); % T�rmino Ambar.
se_R = trapmf(se,[ 2 3 4 4 ]); % T�rmino Rojo.
figure(3)
plot(se,se_V,'g-',se,se_A,'y-',se,se_R,'r-')
title('Funci�n de Membres�a del Sem�foro')
legend('Verde','Ambar','Rojo')


% Presi�n en el Freno
ec = 0:1:100; % Universo de Discursi�n.
% Del Estado del Carro
ec_F = trapmf(ec,[ 0 0 10 20 ]); % Frena.
ec_N = trimf(ec,[ 15 35 50 ]); % Normal.
ec_A = trapmf(ec,[ 40 75 100 100 ]); % Acelera.
figure(4)
plot(ec,ec_F,'g-',ec,ec_N,'y-',ec,ec_A,'r-')
title('Funci�n de Membres�a del Estado del Carro')
legend('Frena','Normal','Acelera')

save fuzzy_data_carro
