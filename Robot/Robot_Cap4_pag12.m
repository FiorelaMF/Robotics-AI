% Cálculo de la Matriz de Transformación
clear all;
close all;
clc
syms c1 c2 c3 s1 s2 s3 l1 l2 d
A1 = [ c1 0 s1 0; s1 0 -c1 0; 0 1 0 l1; 0 0 0 1 ];
A2 = [ c2 0 s2 0; s2 0 -c2 0; 0 1 0 0 ; 0 0 0 1 ];
A3 = [ c3 -s3 0 0; s3 c3 0 0; 0 0 1 l2; 0 0 0 1 ];
A4 = [ 1 0 0 0; 0 1 0 0; 0 0 1 d ; 0 0 0 1 ];
A12 = A1*A2;
A23 = A2*A3;
T = A1*A2*A3*A4
