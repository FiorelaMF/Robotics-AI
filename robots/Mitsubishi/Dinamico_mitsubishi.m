clc; clear all; close all;

syms q1 q2 q3 q4 q5 q1p q2p q3p q4p q5p m1 m2 m3 m4 m5
d1 = 0.252;  d2 = 0.220;   d3 = 0.160;   d4 = 0.065; 

%      al     a     th    di
DH = [ pi/2   0     q1    d1 
       0      d2    q2    0
       0      d3    q3    0
       pi/2   0     q4    0
       0      0     q5    d4 ];


A1 = matra( DH(1,2), DH(1,4), DH(1,1), DH(1,3) );
A2 = matra( DH(2,2), DH(2,4), DH(2,1), DH(2,3) );
A3 = matra( DH(3,2), DH(3,4), DH(3,1), DH(3,3) );
A4 = matra( DH(4,2), DH(4,4), DH(4,1), DH(4,3) );
A5 = matra( DH(5,2), DH(5,4), DH(5,1), DH(5,3) );

T1 = simplify(A1);
T2 = simplify(T1*A2);
T3 = simplify(T2*A3);
T4 = simplify(T3*A4);
T5 = simplify(T4*A5);


%%


% Armamos los link y los acoplamos

L1 = SerialLink( [0  0.25  0     pi/2] );
L2 = SerialLink( [0  0     0.22  0   ] );
L3 = SerialLink( [0  0     0.16  0   ] );
L4 = SerialLink( [0  0     0     pi/2] );
L5 = SerialLink( [0  0.07  0     0   ] );

MMII = SerialLink([L1 L2 L3 L4 L5]);
figure(1)

MMII.plot( [0      0     0     0     0    ] ); pause
MMII.plot( [-pi/4  0     0     0     0    ] ); pause
MMII.plot( [-pi/4  pi/4  0     0     0    ] ); pause
MMII.plot( [-pi/4  pi/4 -pi/4  0     0    ] ); pause
MMII.plot( [-pi/4  pi/4 -pi/4  pi/4  0    ] ); pause
MMII.plot( [-pi/4  pi/4 -pi/4  pi/4  pi/4] ); pause

%%

%centro de  masa 1 
x1 = T1(1,4);
y1 = T1(2,4);
z1 = T1(3,4)/2;

%centro de  masa 2 
x2 = T2(1,2);
y2 = T2(2,4);
z2 = T1(3,4)/2;


%centro de  masa 3 
x3 = T3(1,4);
y3 = T3(2,4);
z3 = T3(3,4)/2;

%centro de  masa 4 
x4 = T4(1,4);
y4 = T4(2,4);
z4 = T4(3,4)/2;

%centro de  masa 5 
x5 = T5(1,4);
y5 = T5(2,4);
z5 = T5(3,4)/2;


%%

x1p = diff(x1,'q1')*q1p + diff(x1,'q2')*q2p + diff(x1,'q3')*q3p + diff(x1,'q4')*q4p + diff(x1,'q5')*q5p;
y1p = diff(y1,'q1')*q1p + diff(y1,'q2')*q2p + diff(y1,'q3')*q3p + diff(y1,'q4')*q4p + diff(y1,'q5')*q5p;
z1p = diff(z1,'q1')*q1p + diff(z1,'q2')*q2p + diff(z1,'q3')*q3p + diff(z1,'q4')*q4p + diff(z1,'q5')*q5p;

x2p = diff(x2,'q1')*q1p + diff(x2,'q2')*q2p + diff(x2,'q3')*q3p + diff(x2,'q4')*q4p + diff(x2,'q5')*q5p;
y2p = diff(y2,'q1')*q1p + diff(y2,'q2')*q2p + diff(y2,'q3')*q3p + diff(y2,'q4')*q4p + diff(y2,'q5')*q5p;
z2p = diff(z2,'q1')*q1p + diff(z2,'q2')*q2p + diff(z2,'q3')*q3p + diff(z2,'q4')*q4p + diff(z2,'q5')*q5p;

x3p = diff(x3,'q1')*q1p + diff(x3,'q2')*q2p + diff(x3,'q3')*q3p + diff(x3,'q4')*q4p + diff(x3,'q5')*q5p;
y3p = diff(y3,'q1')*q1p + diff(y3,'q2')*q2p + diff(y3,'q3')*q3p + diff(y3,'q4')*q4p + diff(y3,'q5')*q5p;
z3p = diff(z3,'q1')*q1p + diff(z3,'q2')*q2p + diff(z3,'q3')*q3p + diff(z3,'q4')*q4p + diff(z3,'q5')*q5p;

x4p = diff(x4,'q1')*q1p + diff(x4,'q2')*q2p + diff(x4,'q3')*q3p + diff(x4,'q4')*q4p + diff(x4,'q5')*q5p;
y4p = diff(y4,'q1')*q1p + diff(y4,'q2')*q2p + diff(y4,'q3')*q3p + diff(y4,'q4')*q4p + diff(y4,'q5')*q5p;
z4p = diff(z4,'q1')*q1p + diff(z4,'q2')*q2p + diff(z4,'q3')*q3p + diff(z4,'q4')*q4p + diff(z4,'q5')*q5p;

x5p = diff(x5,'q1')*q1p + diff(x5,'q2')*q2p + diff(x5,'q3')*q3p + diff(x5,'q4')*q4p + diff(x5,'q5')*q5p;
y5p = diff(y5,'q1')*q1p + diff(y5,'q2')*q2p + diff(y5,'q3')*q3p + diff(y5,'q4')*q4p + diff(y5,'q5')*q5p;
z5p = diff(z5,'q1')*q1p + diff(z5,'q2')*q2p + diff(z5,'q3')*q3p + diff(z5,'q4')*q4p + diff(z5,'q5')*q5p;



x1p2 = x1p^2;  y1p2 = y1p^2;  z1p2 = z1p^2;
x2p2 = x2p^2;  y2p2 = y2p^2;  z2p2 = z2p^2;
x3p2 = x3p^2;  y3p2 = y3p^2;  z3p2 = z3p^2;
x4p2 = x4p^2;  y4p2 = y4p^2;  z4p2 = z4p^2;
x5p2 = x5p^2;  y5p2 = y5p^2;  z5p2 = z5p^2;

v12 = simplify(x1p2 + y1p2 + z1p2);
v22 = simplify(x2p2 + y2p2 + z2p2);
v32 = simplify(x3p2 + y3p2 + z3p2);
v42 = simplify(x4p2 + y4p2 + z4p2);
v52 = simplify(x5p2 + y5p2 + z5p2);


K1 = 1/2*m1*v12;
K2 = 1/2*m2*v22;
K3 = 1/2*m3*v32;
K4 = 1/2*m4*v42;
K5 = 1/2*m5*v52;
K = K1+K2+K3+K4+K5;

m11 = simplify(diff(diff(K,'q1p'),'q1p'));
m12 = simplify(diff(diff(K,'q1p'),'q2p'));
m13 = simplify(diff(diff(K,'q1p'),'q3p'));
m14 = simplify(diff(diff(K,'q1p'),'q4p'));
m15 = simplify(diff(diff(K,'q1p'),'q5p'));

m21 = m12;
m22 = simplify(diff(diff(K,'q2p'),'q2p'));
m23 = simplify(diff(diff(K,'q2p'),'q3p'));
m24 = simplify(diff(diff(K,'q2p'),'q4p'));
m25 = simplify(diff(diff(K,'q2p'),'q5p'));

m31 = m13;
m32 = m23;
m33 = simplify(diff(diff(K,'q3p'),'q3p'));
m34 = simplify(diff(diff(K,'q3p'),'q4p'));
m35 = simplify(diff(diff(K,'q3p'),'q5p'));

m41 = m14;
m42 = m24;
m43 = m34;
m44 = simplify(diff(diff(K,'q4p'),'q4p'));
m45 = simplify(diff(diff(K,'q4p'),'q5p'));

m51 = m15;
m52 = m25;
m53 = m35;
m54 = m45;
m55 = simplify(diff(diff(K,'q5p'),'q5p'));

M = [m11 m12 m13 m14 m15
     m21 m22 m23 m24 m25
     m31 m32 m33 m34 m35
     m41 m42 m43 m44 m45
     m51 m52 m53 m54 m55];

% M está mal porque los centros de masa definidos arriba también están
% 





%%

% Matriz de fuerzas de Centripetas y de Corialos 
% c11

c11 =       1/2*( (diff(m11,'q1') + diff(m11,'q1') - diff(m11,'q1')) * q1p );
c11 = c11 + 1/2*( (diff(m11,'q2') + diff(m12,'q1') - diff(m21,'q1')) * q2p );
c11 = c11 + 1/2*( (diff(m11,'q3') + diff(m13,'q1') - diff(m31,'q1')) * q3p );
c11 = c11 + 1/2*( (diff(m11,'q4') + diff(m14,'q1') - diff(m41,'q1')) * q4p );
c11 = c11 + 1/2*( (diff(m11,'q5') + diff(m15,'q1') - diff(m51,'q1')) * q5p );


c11 = simplify (c11);

% c12

c12 =       1/2*( (diff(m12,'q1') + diff(m11,'q2') - diff(m12,'q1')) * q1p );
c12 = c12 + 1/2*( (diff(m12,'q2') + diff(m12,'q2') - diff(m22,'q1')) * q2p );
c12 = c12 + 1/2*( (diff(m12,'q3') + diff(m13,'q2') - diff(m32,'q1')) * q3p );
c12 = c12 + 1/2*( (diff(m12,'q4') + diff(m14,'q2') - diff(m42,'q1')) * q4p );
c12 = c12 + 1/2*( (diff(m12,'q5') + diff(m15,'q2') - diff(m52,'q1')) * q5p );

c12 = simplify (c12);

% c11

c13 =       1/2*( (diff(m13,'q1') + diff(m11,'q3') - diff(m13,'q1')) * q1p );
c13 = c13 + 1/2*( (diff(m13,'q2') + diff(m12,'q3') - diff(m23,'q1')) * q2p );
c13 = c13 + 1/2*( (diff(m13,'q3') + diff(m13,'q3') - diff(m33,'q1')) * q3p );
c13 = c13 + 1/2*( (diff(m13,'q4') + diff(m14,'q3') - diff(m43,'q1')) * q4p );
c13 = c13 + 1/2*( (diff(m13,'q5') + diff(m15,'q3') - diff(m53,'q1')) * q5p );

c13 = simplify (c13);

% c11

c14 =       1/2*( (diff(m14,'q1') + diff(m11,'q4') - diff(m14,'q1')) * q1p );
c14 = c14 + 1/2*( (diff(m14,'q2') + diff(m12,'q4') - diff(m24,'q1')) * q2p );
c14 = c14 + 1/2*( (diff(m14,'q3') + diff(m13,'q4') - diff(m34,'q1')) * q3p );
c14 = c14 + 1/2*( (diff(m14,'q4') + diff(m14,'q4') - diff(m44,'q1')) * q4p );
c14 = c14 + 1/2*( (diff(m14,'q5') + diff(m15,'q4') - diff(m54,'q1')) * q5p );

c14 = simplify (c14);

% c11

c15 =       1/2*( (diff(m15,'q1') + diff(m11,'q5') - diff(m15,'q1')) * q1p );
c15 = c15 + 1/2*( (diff(m15,'q2') + diff(m12,'q5') - diff(m25,'q1')) * q2p );
c15 = c15 + 1/2*( (diff(m15,'q3') + diff(m13,'q5') - diff(m35,'q1')) * q3p );
c15 = c15 + 1/2*( (diff(m15,'q4') + diff(m14,'q5') - diff(m45,'q1')) * q4p );
c15 = c15 + 1/2*( (diff(m15,'q5') + diff(m15,'q5') - diff(m55,'q1')) * q5p );

c15 = simplify (c15);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% c11

c21 =       1/2*( (diff(m21,'q1') + diff(m21,'q1') - diff(m11,'q2')) * q1p );
c21 = c21 + 1/2*( (diff(m21,'q2') + diff(m22,'q1') - diff(m21,'q2')) * q2p );
c21 = c21 + 1/2*( (diff(m21,'q3') + diff(m23,'q1') - diff(m31,'q2')) * q3p );
c21 = c21 + 1/2*( (diff(m21,'q4') + diff(m24,'q1') - diff(m41,'q2')) * q4p );
c21 = c21 + 1/2*( (diff(m21,'q5') + diff(m25,'q1') - diff(m51,'q2')) * q5p );

c21 = simplify (c21);

% c12

c22 =       1/2*( (diff(m22,'q1') + diff(m21,'q2') - diff(m12,'q2')) * q1p );
c22 = c22 + 1/2*( (diff(m22,'q2') + diff(m22,'q2') - diff(m22,'q2')) * q2p );
c22 = c22 + 1/2*( (diff(m22,'q3') + diff(m23,'q2') - diff(m32,'q2')) * q3p );
c22 = c22 + 1/2*( (diff(m22,'q4') + diff(m24,'q2') - diff(m42,'q2')) * q4p );
c22 = c22 + 1/2*( (diff(m22,'q5') + diff(m25,'q2') - diff(m52,'q2')) * q5p );

c22 = simplify (c22);

% c11

c23 =       1/2*( (diff(m23,'q1') + diff(m21,'q3') - diff(m13,'q2')) * q1p );
c23 = c23 + 1/2*( (diff(m23,'q2') + diff(m22,'q3') - diff(m23,'q2')) * q2p );
c23 = c23 + 1/2*( (diff(m23,'q3') + diff(m23,'q3') - diff(m33,'q2')) * q3p );
c23 = c23 + 1/2*( (diff(m23,'q4') + diff(m24,'q3') - diff(m43,'q2')) * q4p );
c23 = c23 + 1/2*( (diff(m23,'q5') + diff(m25,'q3') - diff(m53,'q2')) * q5p );

c23 = simplify (c23);

% c11

c24 =       1/2*( (diff(m24,'q1') + diff(m21,'q4') - diff(m14,'q2')) * q1p );
c24 = c24 + 1/2*( (diff(m24,'q2') + diff(m22,'q4') - diff(m24,'q2')) * q2p );
c24 = c24 + 1/2*( (diff(m24,'q3') + diff(m23,'q4') - diff(m34,'q2')) * q3p );
c24 = c24 + 1/2*( (diff(m24,'q4') + diff(m24,'q4') - diff(m44,'q2')) * q4p );
c24 = c24 + 1/2*( (diff(m24,'q5') + diff(m25,'q4') - diff(m54,'q2')) * q5p );

c24 = simplify (c24);

% c11

c25 =       1/2*( (diff(m25,'q1') + diff(m21,'q5') - diff(m15,'q2')) * q1p );
c25 = c25 + 1/2*( (diff(m25,'q2') + diff(m22,'q5') - diff(m25,'q2')) * q2p );
c25 = c25 + 1/2*( (diff(m25,'q3') + diff(m23,'q5') - diff(m35,'q2')) * q3p );
c25 = c25 + 1/2*( (diff(m25,'q4') + diff(m24,'q5') - diff(m45,'q2')) * q4p );
c25 = c25 + 1/2*( (diff(m25,'q5') + diff(m25,'q5') - diff(m55,'q2')) * q5p );

c25 = simplify (c25);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


% c11

c31 =       1/2*( (diff(m31,'q1') + diff(m31,'q1') - diff(m11,'q3')) * q1p );
c31 = c31 + 1/2*( (diff(m31,'q2') + diff(m32,'q1') - diff(m21,'q3')) * q2p );
c31 = c31 + 1/2*( (diff(m31,'q3') + diff(m33,'q1') - diff(m31,'q3')) * q3p );
c31 = c31 + 1/2*( (diff(m31,'q4') + diff(m34,'q1') - diff(m41,'q3')) * q4p );
c31 = c31 + 1/2*( (diff(m31,'q5') + diff(m35,'q1') - diff(m51,'q3')) * q5p );

c31 = simplify (c31);

% c12

c32 =       1/2*( (diff(m32,'q1') + diff(m31,'q2') - diff(m12,'q3')) * q1p );
c32 = c32 + 1/2*( (diff(m32,'q2') + diff(m32,'q2') - diff(m22,'q3')) * q2p );
c32 = c32 + 1/2*( (diff(m32,'q3') + diff(m33,'q2') - diff(m32,'q3')) * q3p );
c32 = c32 + 1/2*( (diff(m32,'q4') + diff(m34,'q2') - diff(m42,'q3')) * q4p );
c32 = c32 + 1/2*( (diff(m32,'q5') + diff(m35,'q2') - diff(m52,'q3')) * q5p );

c32 = simplify (c32);

% c11

c33 =       1/2*( (diff(m33,'q1') + diff(m31,'q3') - diff(m13,'q3')) * q1p );
c33 = c33 + 1/2*( (diff(m33,'q2') + diff(m32,'q3') - diff(m23,'q3')) * q2p );
c33 = c33 + 1/2*( (diff(m33,'q3') + diff(m33,'q3') - diff(m33,'q3')) * q3p );
c33 = c33 + 1/2*( (diff(m33,'q4') + diff(m34,'q3') - diff(m43,'q3')) * q4p );
c33 = c33 + 1/2*( (diff(m33,'q5') + diff(m35,'q3') - diff(m53,'q3')) * q5p );

c33 = simplify (c33);

% c11

c34 =       1/2*( (diff(m34,'q1') + diff(m31,'q4') - diff(m14,'q3')) * q1p );
c34 = c34 + 1/2*( (diff(m34,'q2') + diff(m32,'q4') - diff(m24,'q3')) * q2p );
c34 = c34 + 1/2*( (diff(m34,'q3') + diff(m33,'q4') - diff(m34,'q3')) * q3p );
c34 = c34 + 1/2*( (diff(m34,'q4') + diff(m34,'q4') - diff(m44,'q3')) * q4p );
c34 = c34 + 1/2*( (diff(m34,'q5') + diff(m35,'q4') - diff(m54,'q3')) * q5p );

c34 = simplify (c34);

% c11

c35 =       1/2*( (diff(m35,'q1') + diff(m31,'q5') - diff(m15,'q3')) * q1p );
c35 = c35 + 1/2*( (diff(m35,'q2') + diff(m32,'q5') - diff(m25,'q3')) * q2p );
c35 = c35 + 1/2*( (diff(m35,'q3') + diff(m33,'q5') - diff(m35,'q3')) * q3p );
c35 = c35 + 1/2*( (diff(m35,'q4') + diff(m34,'q5') - diff(m45,'q3')) * q4p );
c35 = c35 + 1/2*( (diff(m35,'q5') + diff(m35,'q5') - diff(m55,'q3')) * q5p );

c35 = simplify (c35);


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 


% c11

c41 =       1/2*( (diff(m41,'q1') + diff(m41,'q1') - diff(m11,'q4')) * q1p );
c41 = c41 + 1/2*( (diff(m41,'q2') + diff(m42,'q1') - diff(m21,'q4')) * q2p );
c41 = c41 + 1/2*( (diff(m41,'q3') + diff(m43,'q1') - diff(m31,'q4')) * q3p );
c41 = c41 + 1/2*( (diff(m41,'q4') + diff(m44,'q1') - diff(m41,'q4')) * q4p );
c41 = c41 + 1/2*( (diff(m41,'q5') + diff(m45,'q1') - diff(m51,'q4')) * q5p );

c41 = simplify (c41);

% c12

c42 =       1/2*( (diff(m42,'q1') + diff(m41,'q2') - diff(m12,'q4')) * q1p );
c42 = c42 + 1/2*( (diff(m42,'q2') + diff(m42,'q2') - diff(m22,'q4')) * q2p );
c42 = c42 + 1/2*( (diff(m42,'q3') + diff(m43,'q2') - diff(m32,'q4')) * q3p );
c42 = c42 + 1/2*( (diff(m42,'q4') + diff(m44,'q2') - diff(m42,'q4')) * q4p );
c42 = c42 + 1/2*( (diff(m42,'q5') + diff(m45,'q2') - diff(m52,'q4')) * q5p );

c42 = simplify (c42);

% c11

c43 =       1/2*( (diff(m43,'q1') + diff(m41,'q3') - diff(m13,'q4')) * q1p );
c43 = c43 + 1/2*( (diff(m43,'q2') + diff(m42,'q3') - diff(m23,'q4')) * q2p );
c43 = c43 + 1/2*( (diff(m43,'q3') + diff(m43,'q3') - diff(m33,'q4')) * q3p );
c43 = c43 + 1/2*( (diff(m43,'q4') + diff(m44,'q3') - diff(m43,'q4')) * q4p );
c43 = c43 + 1/2*( (diff(m43,'q5') + diff(m45,'q3') - diff(m53,'q4')) * q5p );

c43 = simplify (c43);

% c11

c44 =       1/2*( (diff(m44,'q1') + diff(m41,'q4') - diff(m14,'q4')) * q1p );
c44 = c44 + 1/2*( (diff(m44,'q2') + diff(m42,'q4') - diff(m24,'q4')) * q2p );
c44 = c44 + 1/2*( (diff(m44,'q3') + diff(m43,'q4') - diff(m34,'q4')) * q3p );
c44 = c44 + 1/2*( (diff(m44,'q4') + diff(m44,'q4') - diff(m44,'q4')) * q4p );
c44 = c44 + 1/2*( (diff(m44,'q5') + diff(m45,'q4') - diff(m54,'q4')) * q5p );

c44 = simplify (c44);

% c11

c45 =       1/2*( (diff(m45,'q1') + diff(m41,'q5') - diff(m15,'q4')) * q1p );
c45 = c45 + 1/2*( (diff(m45,'q2') + diff(m42,'q5') - diff(m25,'q4')) * q2p );
c45 = c45 + 1/2*( (diff(m45,'q3') + diff(m43,'q5') - diff(m35,'q4')) * q3p );
c45 = c45 + 1/2*( (diff(m45,'q4') + diff(m44,'q5') - diff(m45,'q4')) * q4p );
c45 = c45 + 1/2*( (diff(m45,'q5') + diff(m45,'q5') - diff(m55,'q4')) * q5p );

c15 = simplify (c15);

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 



% c11

c51 =       1/2*( (diff(m51,'q1') + diff(m51,'q1') - diff(m11,'q5')) * q1p );
c51 = c51 + 1/2*( (diff(m51,'q2') + diff(m52,'q1') - diff(m21,'q5')) * q2p );
c51 = c51 + 1/2*( (diff(m51,'q3') + diff(m53,'q1') - diff(m31,'q5')) * q3p );
c51 = c51 + 1/2*( (diff(m51,'q4') + diff(m54,'q1') - diff(m41,'q5')) * q4p );
c51 = c51 + 1/2*( (diff(m51,'q5') + diff(m55,'q1') - diff(m51,'q5')) * q5p );

c51 = simplify (c51);

% c12

c52 =       1/2*( (diff(m52,'q1') + diff(m51,'q2') - diff(m12,'q5')) * q1p );
c52 = c52 + 1/2*( (diff(m52,'q2') + diff(m52,'q2') - diff(m22,'q5')) * q2p );
c52 = c52 + 1/2*( (diff(m52,'q3') + diff(m53,'q2') - diff(m32,'q5')) * q3p );
c52 = c52 + 1/2*( (diff(m52,'q4') + diff(m54,'q2') - diff(m42,'q5')) * q4p );
c52 = c52 + 1/2*( (diff(m52,'q5') + diff(m55,'q2') - diff(m52,'q5')) * q5p );

c52 = simplify (c52);

% c11

c53 =       1/2*( (diff(m53,'q1') + diff(m51,'q3') - diff(m13,'q5')) * q1p );
c53 = c53 + 1/2*( (diff(m53,'q2') + diff(m52,'q3') - diff(m23,'q5')) * q2p );
c53 = c53 + 1/2*( (diff(m53,'q3') + diff(m53,'q3') - diff(m33,'q5')) * q3p );
c53 = c53 + 1/2*( (diff(m53,'q4') + diff(m54,'q3') - diff(m43,'q5')) * q4p );
c53 = c53 + 1/2*( (diff(m53,'q5') + diff(m55,'q3') - diff(m53,'q5')) * q5p );

c53 = simplify (c53);

% c11

c54 =       1/2*( (diff(m54,'q1') + diff(m51,'q4') - diff(m14,'q5')) * q1p );
c54 = c54 + 1/2*( (diff(m54,'q2') + diff(m52,'q4') - diff(m24,'q5')) * q2p );
c54 = c54 + 1/2*( (diff(m54,'q3') + diff(m53,'q4') - diff(m34,'q5')) * q3p );
c54 = c54 + 1/2*( (diff(m54,'q4') + diff(m54,'q4') - diff(m44,'q5')) * q4p );
c54 = c54 + 1/2*( (diff(m54,'q5') + diff(m55,'q4') - diff(m54,'q5')) * q5p );

c14 = simplify (c14);

% c11

c55 =       1/2*( (diff(m55,'q1') + diff(m51,'q5') - diff(m15,'q5')) * q1p );
c55 = c55 + 1/2*( (diff(m55,'q2') + diff(m52,'q5') - diff(m25,'q5')) * q2p );
c55 = c55 + 1/2*( (diff(m55,'q3') + diff(m53,'q5') - diff(m35,'q5')) * q3p );
c55 = c55 + 1/2*( (diff(m55,'q4') + diff(m54,'q5') - diff(m45,'q5')) * q4p );
c55 = c55 + 1/2*( (diff(m55,'q5') + diff(m55,'q5') - diff(m55,'q5')) * q5p );

c55 = simplify (c55);


C = [c11 c12 c13 c14 c15
     c21 c22 c23 c24 c25
     c31 c32 c33 c34 c35
     c41 c42 c43 c44 c45
     c51 c52 c53 c54 c55];



%%











































