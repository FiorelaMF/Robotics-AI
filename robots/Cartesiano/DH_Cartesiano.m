% Robot Cartesiano de un almacén
clear all; clc; close all
syms q1 q2 q3
% al a th d
DH = [ pi/2 0 pi 10
        pi/2 0 3*pi/2 q1
        pi/2 0 pi/2 q2
        0 0 0 q3 ];

% a d al th
A1 = matra(DH(1,2),DH(1,4),DH(1,1),DH(1,3))
A2 = matra(DH(2,2),DH(2,4),DH(2,1),DH(2,3))
A3 = matra(DH(3,2),DH(3,4),DH(3,1),DH(3,3))
A4 = matra(DH(4,2),DH(4,4),DH(4,1),DH(4,3))
T1 = A1; T2 = T1*A2; T3 = T2*A3; T4 = T3*A4