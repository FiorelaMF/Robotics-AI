% Calculando el Modelo Dinámico.
% Robot Plotter
clear all
syms a1 a2 q1 q2 q1p q2p pi
% a d al th
DH = [ a1 0 0 q1
a2 0 0 q2 ];
% masa 1
% a d al th
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
T1 = A1;
x1 = T1(1,4)
y1 = T1(2,4)
z1 = T1(3,4)

% Derivamos con respecto al tiempo
x1p = diff(x1,'q1')*q1p+diff(x1,'q2')*q2p;
y1p = diff(y1,'q1')*q1p+diff(y1,'q2')*q2p;
z1p = diff(z1,'q1')*q1p+diff(z1,'q2')*q2p;
% Elevamos al cuadrado
x1p2 = x1p^2; y1p2 = y1p^2; z1p2 = z1p^2;
% Vel. cuadrado v^2 = xp^2 + yp^2 + zp^2
v12 = simplify(x1p2 + y1p2 + z1p2);


% masa 2
T2 = A1*A2;
x2 = T2(1,4);
y2 = T2(2,4);
z2 = T2(3,4);
% Derivamos con respecto al tiempo
x2p = diff(x2,'q1')*q1p+diff(x2,'q2')*q2p;
y2p = diff(y2,'q1')*q1p+diff(y2,'q2')*q2p;
z2p = diff(z2,'q1')*q1p+diff(z2,'q2')*q2p;
% Elevamos al cuadrado
x2p2 = x2p^2; y2p2 = y2p^2; z2p2 = z2p^2;
% Vel. cuadrado v^2 = xp^2 + yp^2 + zp^2
v22 = simplify(x2p2 + y2p2 + z2p2);

syms m1 m2 % Masas
% Energía Cinética del Sistema
% K = K1 + K2 ---> Ki = 1/2*mi*vi^2
K1 = 1/2*m1*v12; K2 = 1/2*m2*v22; K = K1 + K2;
% Matriz de Inercias
m11 = simplify(diff(diff(K,'q1p'),'q1p'));
m12 = simplify(diff(diff(K,'q2p'),'q1p'));
m21 = m12;
m22 = simplify(diff(diff(K,'q2p'),'q2p'));
M =[ m11 m12
m21 m22 ];


% Matriz de Fuerzas Centrípetas y de Coriolis
% Empleamos los términos de Christoffel
% c11
c11 = 1/2*(diff(m11,'q1')+diff(m11,'q1')-diff(m11,'q1'))*q1p;
c11 = c11 + 1/2*(diff(m11,'q2')+diff(m12,'q1')-diff(m21,'q1'))*q2p;
c11 = simplify(c11);
% c12
c12 = 1/2*(diff(m12,'q1')+diff(m11,'q2')-diff(m12,'q1'))*q1p;
c12 = c12 + 1/2*(diff(m12,'q2')+diff(m12,'q2')-diff(m22,'q1'))*q2p;
c12 = simplify(c12);
% c21
c21 = 1/2*(diff(m21,'q1')+diff(m21,'q1')-diff(m11,'q2'))*q1p;
c21 = c21 + 1/2*(diff(m21,'q2')+diff(m22,'q1')-diff(m21,'q2'))*q2p;
c21 = simplify(c21);
% c22
c22 = 1/2*(diff(m22,'q1')+diff(m21,'q2')-diff(m12,'q2'))*q1p;
c22 = c22 + 1/2*(diff(m22,'q2')+diff(m22,'q2')-diff(m22,'q2'))*q2p;
c22 = simplify(c22);
C = [ c11 c12
c21 c22 ];

% Cálculo de la Energía Potencial
% P = P1 + P2 ---> Pi = mi*g*zi
syms g
P1 = m1*g*y1; P2 = m2*g*y2;
P = P1 + P2;
% Determinación del Vector de Gravedad
g1 = simplify(diff(P,'q1'));
g2 = simplify(diff(P,'q2'));
G = conj([ g1 g2 ])';



