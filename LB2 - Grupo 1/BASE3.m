% 1 teoria que solo debe estar en el paper
% 2 teoria indica cual es a1 a2 q1 q2
% 3 DH y matrices de transformacion.
clear all; clc; close all
syms	 q1 q2 pi
% a d al th
DH = [ a1 0 0 q1
       a2 0 0 q2 ];
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
T1 = A1;
T2 = T1*A2


DH = [ 1 0 0 q1
       1 0 0 q2 ];
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
T1 = A1;
T2 = T1*A2

% Cinematica Inversa
q = ik(T2)
