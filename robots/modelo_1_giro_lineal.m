clc; clear all; close all;

syms q1 q2 q1p q2p m g pi

q = [q1; q2];

qp = [q1p;q2p];

x = q2 * cos(q1);
y = q2 * sin(q1);

xp = diff(x,q1) * q1p + diff(x,q2)*q2p;
yp = diff(y,q1) * q1p + diff(y,q2)*q2p;

xp_2 = expand(xp^2);
yp_2 = expand(yp^2);

v_2 = simplify(xp_2 + yp_2);

% energía cinética
K = simplify(1/2*m*v_2);

% Extraer M(q)
m11 = diff(diff(K,q1p),q1p);
m12 = diff(diff(K,q1p),q2p);
m21 = m12;
m22 = diff(diff(K,q2p),q2p);

M = [ m11 m12
      m21 m22];

% Matriz C
% Terminos de Christoffel

c11 =       1/2*( diff(m11,q1) + diff(m11,q1) - diff(m11,q1) ) * q1p;
c11 = c11 + 1/2*( diff(m11,q2) + diff(m12,q1) - diff(m21,q1) ) * q2p;

c12 =       1/2*( diff(m12,q1) + diff(m11,q2) - diff(m12,q1) ) * q1p;
c12 = c12 + 1/2*( diff(m12,q2) + diff(m12,q2) - diff(m22,q1) ) * q2p;

c21 =       1/2*( diff(m21,q1) + diff(m21,q1) - diff(m11,q2) ) * q1p;
c21 = c21 + 1/2*( diff(m21,q2) + diff(m22,q1) - diff(m21,q2) ) * q2p;

c22 =       1/2*( diff(m22,q1) + diff(m21,q2) - diff(m12,q2) ) * q1p;
c22 = c22 + 1/2*( diff(m22,q2) + diff(m22,q2) - diff(m22,q2) ) * q2p;

C = [c11 c12
     c21 c22];
 

% Energía potencial

P = m*g*y;

% Vector de gravedad
g1 = diff(P,q1);
g2 = diff(P,q2);

G = [ g1 ; g2];


% Modelo completo - en lagrangiano 

M*qp + C*qp + G = tau;







