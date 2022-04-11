% Cinemática Robot
clc;close all;clear all
syms q1 q2 q3 q4 l1 l2 l3 l4 l5
% a d al th
%DH = [ l2 l1 0 q1
 %      l3 0 0 q2
  %     0 q3 0 0
   %    0 -l4 pi q4];

   DH = [ q1 l1 l2 0
       q2 0 l3 0
       0 q3 0 0
       q4 -l4 0 pi];
   
   
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4))
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4))
A3 = matra(DH(3,1),DH(3,2),DH(3,3),DH(3,4))
A4 = matra(DH(4,1),DH(4,2),DH(4,3),DH(4,4))

T1 = A1
T2 = T1*A2
T3 = T2*A3
T4 = simplify(T3*A4)

