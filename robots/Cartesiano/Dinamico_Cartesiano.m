clear all
syms q1 q2 q3 q1p q2p q3p
% al a th d
DH = [ pi/2 0 pi 10
pi/2 0 3*pi/2 q1
pi/2 0 pi/2 q2
0 0 0 q3 ];

% masa 1
% a d al th
A1 = matra(DH(1,2),DH(1,4),DH(1,1),DH(1,3));
A2 = matra(DH(2,2),10,DH(2,1),DH(2,3));
T1 = simplify(A1*A2);
x1 = T1(1,4); y1 = T1(2,4); z1 = T1(3,4);

% Derivamos con respecto al tiempo
x1p = diff(x1,'q1')*q1p+diff(x1,'q2')*q2p+diff(x1,'q3')*q3p;
y1p = diff(y1,'q1')*q1p+diff(y1,'q2')*q2p+diff(y1,'q3')*q3p;
z1p = diff(z1,'q1')*q1p+diff(z1,'q2')*q2p+diff(z1,'q3')*q3p;

% Elevamos al cuadrado
x1p2 = x1p^2;
y1p2 = y1p^2;
z1p2 = z1p^2;
% Velocidad al cuadrado v^2 = xp^2 + yp^2 + zp^2
v12 = simplify(x1p2 + y1p2 + z1p2);

% masa 2
% a d al th
A2 = matra(DH(2,2),DH(2,4),DH(2,1),DH(2,3));
A3 = matra(DH(3,2),5,DH(3,1),DH(3,3));
T2 = simplify(A1*A2*A3);
% Se extraen los puntos de la Matriz
x2 = T2(1,4); y2 = T2(2,4); z2 = T2(3,4);
% Derivamos con respecto al tiempo
x2p = diff(x2,'q1')*q1p+diff(x2,'q2')*q2p+diff(x2,'q3')*q3p;
y2p = diff(y2,'q1')*q1p+diff(y2,'q2')*q2p+diff(y2,'q3')*q3p;
z2p = diff(z2,'q1')*q1p+diff(z2,'q2')*q2p+diff(z2,'q3')*q3p;
% Elevamos al cuadrado
x2p2 = x2p^2;
y2p2 = y2p^2;
z2p2 = z2p^2;
% Velocidad al cuadrado v^2 = xp^2 + yp^2 + zp^2
v22 = simplify(x2p2 + y2p2 + z2p2);

% masa 3
% a d al th
A3 = matra(DH(3,2),DH(3,4),DH(3,1),DH(3,3));
A4 = matra(DH(4,2),DH(4,4),DH(4,1),DH(4,3));
T3 = simplify(A1*A2*A3*A4);
% Se extraen los puntos de la Matriz
x3 = T3(1,4); y3 = T3(2,4); z3 = T3(3,4);
% Derivamos con respecto al tiempo
x3p = diff(x3,'q1')*q1p+diff(x3,'q2')*q2p+diff(x3,'q3')*q3p;
y3p = diff(y3,'q1')*q1p+diff(y3,'q2')*q2p+diff(y3,'q3')*q3p;
z3p = diff(z3,'q1')*q1p+diff(z3,'q2')*q2p+diff(z3,'q3')*q3p;
% Elevamos al cuadrado
x3p2 = x3p^2;
y3p2 = y3p^2;
z3p2 = z3p^2;
% Velocidad al cuadrado v^2 = xp^2 + yp^2 + zp^2
v32 = simplify(x3p2 + y3p2 + z3p2);

syms m1 m2 m3
% Energía Cinética del Sistema
% K = K1 + K2 + K3
% Ki = 1/2*mi*vi^2
K1 = 1/2*m1*v12;
K2 = 1/2*m2*v22;
K3 = 1/2*m3*v32;
K = simplify(K1+K2+K3); 

% Matriz de Inercias
m11 = simplify(diff(diff(K,'q1p'),'q1p'));
m12 = simplify(diff(diff(K,'q1p'),'q2p'));
m13 = simplify(diff(diff(K,'q1p'),'q3p'));
m21 = m12;
m22 = simplify(diff(diff(K,'q2p'),'q2p'));
m23 = simplify(diff(diff(K,'q2p'),'q3p'));
m31 = m13;
m32 = m23;
m33 = simplify(diff(diff(K,'q3p'),'q3p'));
M =[ m11 m12 m13
m21 m22 m23
m31 m32 m33 ];

% c11
c11 = 1/2*(diff(m11,'q1')+diff(m11,'q1')-diff(m11,'q1'))*q1p;
c11 = c11 + 1/2*(diff(m11,'q2')+diff(m12,'q1')-diff(m21,'q1'))*q2p;
c11 = c11 + 1/2*(diff(m11,'q3')+diff(m13,'q1')-diff(m31,'q1'))*q3p;
c11 = simplify(c11);
% c12
c12 = 1/2*(diff(m12,'q1')+diff(m11,'q2')-diff(m12,'q1'))*q1p;
c12 = c12 + 1/2*(diff(m12,'q2')+diff(m12,'q2')-diff(m22,'q1'))*q2p;
c12 = c12 + 1/2*(diff(m12,'q3')+diff(m13,'q2')-diff(m32,'q1'))*q3p;
c12 = simplify(c12);
% c13
c13 = 1/2*(diff(m13,'q1')+diff(m11,'q3')-diff(m13,'q1'))*q1p;
c13 = c13 + 1/2*(diff(m13,'q2')+diff(m12,'q3')-diff(m23,'q1'))*q2p;
c13 = c13 + 1/2*(diff(m13,'q3')+diff(m13,'q3')-diff(m33,'q1'))*q3p;
c13 = simplify(c13);

% c21
c21 = 1/2*(diff(m21,'q1')+diff(m21,'q1')-diff(m11,'q2'))*q1p;
c21 = c21 + 1/2*(diff(m21,'q2')+diff(m22,'q1')-diff(m21,'q2'))*q2p;
c21 = c21 + 1/2*(diff(m21,'q3')+diff(m23,'q1')-diff(m31,'q2'))*q3p;
c21 = simplify(c21);
% c22
c22 = 1/2*(diff(m22,'q1')+diff(m21,'q2')-diff(m12,'q2'))*q1p;
c22 = c22 + 1/2*(diff(m22,'q2')+diff(m22,'q2')-diff(m22,'q2'))*q2p;
c22 = c22 + 1/2*(diff(m22,'q3')+diff(m23,'q2')-diff(m32,'q2'))*q3p;
c22 = simplify(c22);
% c23
c23 = 1/2*(diff(m23,'q1')+diff(m21,'q3')-diff(m13,'q2'))*q1p;
c23 = c23 + 1/2*(diff(m23,'q2')+diff(m22,'q3')-diff(m23,'q2'))*q2p;
c23 = c23 + 1/2*(diff(m23,'q3')+diff(m23,'q3')-diff(m33,'q2'))*q3p;
c23 = simplify(c23);


% c31
c31 = 1/2*(diff(m31,'q1')+diff(m31,'q1')-diff(m11,'q3'))*q1p;
c31 = c31 + 1/2*(diff(m31,'q2')+diff(m32,'q1')-diff(m21,'q3'))*q2p;
c31 = c31 + 1/2*(diff(m31,'q3')+diff(m33,'q1')-diff(m31,'q3'))*q3p;
c31 = simplify(c31);
% c32
c32 = 1/2*(diff(m32,'q1')+diff(m31,'q2')-diff(m12,'q3'))*q1p;
c32 = c32 + 1/2*(diff(m32,'q2')+diff(m32,'q2')-diff(m22,'q3'))*q2p;
c32 = c32 + 1/2*(diff(m32,'q3')+diff(m33,'q2')-diff(m32,'q3'))*q3p;
c32 = simplify(c32);
% c33
c33 = 1/2*(diff(m33,'q1')+diff(m31,'q3')-diff(m13,'q3'))*q1p;
c33 = c33 + 1/2*(diff(m33,'q2')+diff(m32,'q3')-diff(m23,'q3'))*q2p;
c33 = c33 + 1/2*(diff(m33,'q3')+diff(m33,'q3')-diff(m33,'q3'))*q3p;
c33 = simplify(c33);
C = [ c11 c12 c13
c21 c22 c23
c31 c32 c33 ];

% Cálculo de la Energía Potencial
% P = P1 + P2 + P3
% Pi = mi*g*zi
syms g
P1 = m1*g*z1;
P2 = m2*g*z2;
P3 = m3*g*z3;
P = P1 + P2 + P3;
% Determinación del Vector de Gravedad
g1 = simplify(diff(P,'q1'));
g2 = simplify(diff(P,'q2'));
g3 = simplify(diff(P,'q3'));
G = [ g1 g2 g3 ]';