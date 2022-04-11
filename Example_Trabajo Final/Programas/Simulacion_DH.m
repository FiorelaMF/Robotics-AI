clear all; close all; clc


% Armamos los eslabones o links
  
%                 th         d    a         al    s
L1 = SerialLink([ 0          0    0         pi/2  0]);
L2 = SerialLink([ 0          0    0.9      0     0]);
L3 = SerialLink([ 0          0    0.5      0     0]);
L4 = SerialLink([ 0          0    0.4       0     0]);

DJ = SerialLink([L1 L2 L3 L4]) % Los acoplamos
% Definimos el espacio cartesiano
W = [ -1 1 -1 1 0 2 ];
figure(1)

% q1: 0 a 180
% q2: 0 a 128
% q3: 0 a 320
% q4: 0 a 320
pause
qm = [  0         pi/8     pi/2    pi/2
        0         pi/6     pi/2    pi/2
        0         pi/4     pi/2    pi/2
        0         pi/2     pi/2    pi/2
        0         pi/1.5   pi/2    pi/2
        0         pi/1.2   pi/2    pi/2
        0         pi       pi/2    pi/2
        0         pi/1.2   pi/2    pi/2
        0         pi/1.5   pi/2    pi/2
        0         pi/2     pi/4    pi/2
        0         pi/2     pi/8    pi/2
        0         pi/2     pi/4    pi/2
        0         pi/2     pi/2    pi/2
        0         pi/2     pi/2    pi/4
        0         pi/2     pi/2    pi/5
        0         pi/2     pi/2    pi/6
        0         pi/2     pi/2    pi/5
        0         pi/2     pi/2    pi/4
        pi/8      pi/2     pi/2    pi/2
        pi/4      pi/2     pi/2    pi/2
        pi/2      pi/2     pi/2    pi/2
        pi/4      pi/2     pi/2    pi/2
        pi/8      pi/2     pi/2    pi/2
        0         pi/1.8   pi/3    pi/3];




    
    
        
        DJ.plot(qm,'workspace',W)

