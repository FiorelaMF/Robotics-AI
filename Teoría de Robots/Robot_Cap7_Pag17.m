% Cinemática Robot
clc;close all;clear all
syms q1 q2 q3 l1 l2
% a d al th
DH = [ 0 l1 pi/2 q1
0 0 pi/2 q2
0 l2+q3 0 0 ];

A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4))
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4))
A3 = matra(DH(3,1),DH(3,2),DH(3,3),DH(3,4))
T1 = A1
T2 = T1*A2
T3 = T2*A3

