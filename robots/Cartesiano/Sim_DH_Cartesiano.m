clear all; close all; clc
% Armamos los links y los acoplamos
% th d a al s
L1 = SerialLink([ pi 0 0 pi/2 1 ]);
L2 = SerialLink([ 3*pi/2 0 0 pi/2 1 ]);
L3 = SerialLink([ pi/2 0 0 pi/2 1 ]);
L4 = SerialLink([ 0 0 0 0 1 ]);
cartesiano = SerialLink([L1 L2 L3 L4])
% Definimos el espacio cartesiano
W = [ 0 11 0 21 0 11 ];
figure(1)
cartesiano.plot([10 0 0 0 ],'workspace', W); pause
cartesiano.plot([10 8 0 0 ],'workspace', W); pause
cartesiano.plot([10 8 6 0 ],'workspace', W); pause
cartesiano.plot([10 8 6 5 ],'workspace', W)