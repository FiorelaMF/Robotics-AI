% Instrucciones Iniciales:
% ------------- ---------
close all; clear all; clc

% Algoritmo para la Cinemática y Dinámica del Robot:
% --------- ---- -- ---------- - -------- --- -----
syms q1 q2 pi q1p q2p m1 m2 m3 g real

%      a   d   al  th
DH = [ 0.0 q2  0.0 q1
       2.8 0.0 0.0 0.0 ];
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));

% Dimensiones del Robot:
% Altura total 5 m, centro de masa1 = 5/2 = 2.5
% Largo total 2.65 m, centro de masa1 = 2.65/2 = 1.3
A1m = matra(DH(1,1),2.5,DH(1,3),DH(1,4));
A2m = matra(1.3,DH(2,2),DH(2,3),DH(2,4));
T1  = A1m;
T2  = A1*A2m;

%% Cálculos para la Masa 1:
x1 = T1(1,4); y1 = T1(2,4); z1 = T1(3,4); CM1 = [x1 y1 z1];

% Derivando respecto al tiempo:
x1p = diff(x1,'q1')*q1p+diff(x1,'q2')*q2p;
y1p = diff(y1,'q1')*q1p+diff(y1,'q2')*q2p;
z1p = diff(z1,'q1')*q1p+diff(z1,'q2')*q2p;

% Elevando al cuadrado:
x1p2 = x1p^2;
y1p2 = y1p^2;
z1p2 = z1p^2;

% Velocidad al cuadrado:
v1_2 = simplify(x1p2 + y1p2 + z1p2);

%% Cálculos para la Masa 2:
x2 = T2(1,4); y2 = T2(2,4); z2 = T2(3,4); CM2 = [x2 y2 z2];

% Derivando respecto al tiempo:
x2p = diff(x2,'q1')*q1p+diff(x2,'q2')*q2p;
y2p = diff(y2,'q1')*q1p+diff(y2,'q2')*q2p;
z2p = diff(z2,'q1')*q1p+diff(z2,'q2')*q2p;

% Elevando al cuadrado:
x2p2 = x2p^2;
y2p2 = y2p^2;
z2p2 = z2p^2;

% Velocidad al cuadrado:
v2_2 = simplify(x2p2 + y2p2 + z2p2);


%% Energía Cinética del Sistema:
K1 = 1/2*m1*v1_2;
K2 = 1/2*m2*v2_2;
K  = K1 + K2;

%% Matriz de Inercias:
m11 = simplify(diff(diff(K,'q1p'),'q1p'));
m12 = simplify(diff(diff(K,'q2p'),'q1p'));
m21 = m12;
m22 = simplify(diff(diff(K,'q2p'),'q2p'));
M   = [ m11 m12 m21 m22 ];

%% Matriz de Fuerzas Centrífugas y de Coriolis
%  Empleamos los términos de Christoffel:

% c11:
c11 = 1/2*(diff(m11,'q1')+diff(m11,'q1')-diff(m11,'q1'))*q1p;
c11 = c11 + 1/2*(diff(m11,'q2')+diff(m12,'q1')-diff(m21,'q1'))*q2p;
c11 = simplify(c11);

% c12:
c12 = 1/2*(diff(m12,'q1')+diff(m11,'q2')-diff(m12,'q1'))*q1p;
c12 = c12 + 1/2*(diff(m12,'q2')+diff(m12,'q2')-diff(m22,'q1'))*q2p;
c12 = simplify(c12);

% c21:
c21 = 1/2*(diff(m21,'q1')+diff(m21,'q1')-diff(m11,'q2'))*q1p;
c21 = c21 + 1/2*(diff(m21,'q2')+diff(m22,'q1')-diff(m21,'q2'))*q2p;
c21 = simplify(c21);

% c22
c22 = 1/2*(diff(m22,'q1')+diff(m21,'q2')-diff(m12,'q2'))*q1p;
c22 = c22 + 1/2*(diff(m22,'q2')+diff(m22,'q2')-diff(m22,'q2'))*q2p;
c22 = simplify(c22);

% Matriz C:
C = [ c11 c12 c21 c22 ];

%% Calculando Energía Potencial:
P1 = m1*g*z1;
P2 = m2*g*z2;
P  = P1 + P2;

%% Determinando Vector de Gravedad:
g1 = simplify(diff(P,'q1'));
g2 = simplify(diff(P,'q2'));
G = [ g1 g2 ]';