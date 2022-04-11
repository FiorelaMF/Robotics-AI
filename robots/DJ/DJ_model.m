
clear all; close all; clc

syms q1 q2 q3 l

DH = [0   q1   pi/2     pi/2
      0   q2   3*pi/2   3*pi/2
      l   0    0        q3];

A1 = matra( DH(1,2), DH(1,4), DH(1,2), DH(1,3)  );
A2 = matra( DH(2,2), DH(2,4), DH(2,2), DH(2,3)  );
A3 = matra( DH(3,2), DH(3,4), DH(3,2), DH(3,3)  );

T1 = A1;
T2 = A1*A2;
T3 = A1*A2*A3;


L1 = SerialLink([ pi/2    0      0     pi/2     1]); 
L2 = SerialLink([ 3*pi/2  0      0     3*pi/2   1]);
L3 = SerialLink([ 0       0      0.5   0        0]);
DJ = SerialLink([L1 L2 L3]); % Los acoplamos

% Definimos el espacio cartesiano
W = [ -0.5 0.5 -0.5 0.5 0 2.0 ];

figure(1)
DJ.plot([ 0     0  0    ],'workspace',W); pause
DJ.plot([-pi/4  0  0    ],'workspace',W); pause
DJ.plot([-pi/4  1  0    ],'workspace',W); pause
DJ.plot([-pi/4  1  0.25 ],'workspace',W)



qm = [ 0.00 0.00 0.00
    -pi/8 0.00 0.00
    -pi/6 0.00 0.00
    -pi/4 0.25 0.00
    -pi/4 0.50 0.00
    -pi/4 0.75 0.00
    -pi/4 0.75 0.00
    -pi/4 1.00 0.10
    -pi/4 1.00 0.15
    -pi/4 1.00 0.20
    -pi/4 1.00 0.25 ];

pause
DJ.plot(qm,'workspace',W)












