clc; clear all; close all

syms a1 a2 q1 q2 pi

%      a   d   al  th

DH = [ a1  0   0   q1 
       a2  0   0   q2 ];
   

   
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));

T1 = A1;
T2 = T1*A2;