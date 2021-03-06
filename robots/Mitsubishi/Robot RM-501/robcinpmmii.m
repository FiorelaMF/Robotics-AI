% Robot Mitsubishi Move Master II
% Prueba de la Cinemática de DH
clear all
clc
close all

syms q1 q2 q3 q4 q5 pi

% Longitudes del Robot
d1 = 0.252; % Metros
d2 = 0.220;
d3 = 0.160;
d4 = 0.065;

% Denavit-Hartenberg
%       al    a    th    d
DH = [ pi/2   0    q1   d1
         0   d2    q2    0       
         0   d3    q3    0
       pi/2   0    q4    0      
         0    0    q5   d4 ];
 
%             a       d      al      th
A1 = matra(DH(1,2),DH(1,4),DH(1,1),DH(1,3))
A2 = matra(DH(2,2),DH(2,4),DH(2,1),DH(2,3))
A3 = matra(DH(3,2),DH(3,4),DH(3,1),DH(3,3))
A4 = matra(DH(4,2),DH(4,4),DH(4,1),DH(4,3))
A5 = matra(DH(5,2),DH(5,4),DH(5,1),DH(5,3))

T1 = simple(A1)
T2 = simple(T1*A2)
T3 = simple(T2*A3)
T4 = simple(T3*A4)
T5 = simple(T4*A5)

clear pi
tx = pi/180; % Factor de Transformación de Sex a Rad
q1 = -90*tx; q2 = 47*tx; q3 = -36*tx; q4 = 79*tx; q5 = 86*tx;
%DEFINIENDO LOS ESLABONES HACIENDO USO DE LOS PARAMETROS DE DENAVIT-HARTENBERG
%    link([  al   a	th	d])
L1 = link([ pi/2   0    q1   d1 0 ], 'standard')
L2 = link([   0   d2    q2    0 0 ], 'standard')
L3 = link([   0   d3    q3    0 0 ], 'standard')
L4 = link([ pi/2   0    q4    0 0 ], 'standard')
L5 = link([   0    0    q5   d4 0 ], 'standard')

%ACOPLANDO LOS LINKS EN UNA ESTRUCTURA ROBOT
robotmmii = robot({L1 L2 L3 L4 L5},' ');
drivebot(robotmmii)

