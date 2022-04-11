clear all; close all; clc
% Armamos los links y los acoplamos
%th d aal
L1 = SerialLink([ 0 0 0.5 0 ]);
L2 = SerialLink([ 0 0 0.5 0 ]);
plotter = SerialLink([L1 L2])


figure(1)
plotter.plot([0 0]); pause
plotter.plot([pi/4 0]); pause
plotter.plot([pi/4 pi/4]); pause
plotter.plot([0    0
              pi/8 pi/8
              pi/6 pi/6
              pi/4 pi/4
              pi/2 pi/2])
%%
syms a1 a2 th1 th2
%       a  d al th
DH = [ a1  0  0 th1
       a2  0  0 th2 ];
   
   A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4))
   A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4))
   T1 = A1
   T2 = A1*A2
          
          
dx2_dth1 = simplify(diff(T2(1,4),th1));
dx2_dth2 = simplify(diff(T2(1,4),th2));
dy2_dth1 = simplify(diff(T2(2,4),th1));
dy2_dth2 = simplify(diff(T2(2,4),th2));
dz2_dth1 = simplify(diff(T2(3,4),th1));
dz2_dth2 = simplify(diff(T2(3,4),th2));

Jv= [ dx2_dth1 dx2_dth2 
      dy2_dth1 dy2_dth2
      dz2_dth1 dz2_dth2 ]     
          
          
Jv= [    -a2*sin(th1+th2)-a1*sin(th1),        -a2*sin(th1+th2)]
    [     a2*cos(th1+th2)+a1*cos(th1),         a2*cos(th1+th2)]
    [                               0,                       0]  
          
k0 = 1; k1 = 1; % Movimientos articulares 
Jw = [ T1(1:3,3)*k0 T2(1:3,3)*k1 ]


J = [ Jv; Jw]


J = [    -a2*sin(th1+th2)-a1*sin(th1),  -a2*sin(th1+th2)]
    [  a2*cos(th1+th2)+a1*cos(th1),   a2*cos(th1+th2)]
    [                            0,                           0]
    [                            0,                           0]
    [                            0,                           0]
    [                            1,                           1]
   













          
          