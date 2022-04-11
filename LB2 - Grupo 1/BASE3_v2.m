% 1 teoria que solo debe estar en el paper
% 2 teoria indica cual es a1 a2 q1 q2
% 3 DH y matrices de transformacion.
clear all; clc; close all
syms a1 a2 q1 q2 pi
% a d al th
DH = [ a1 0 0 q1
       a2 0 0 q2 ];
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
T1 = A1;
T2 = T1*A2


DH = [ 1 0 0 q1
       1 0 0 q2 ];
A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
T1 = A1;
T2 = T1*A2
%%
px=1;
py=1;
l1=1;
l2=1;



cosq2=(px^2+py^2-l1^2-l2^2)/(2*l1*l2);
senq2=(1-(cosq2)^2)^0.5;
q2=atan(senq2/cosq2)*180/pi
beta=atan(py/px);
alfa=atan((l2*senq2)/(l1+l2*cosq2));
q1=(beta-alfa)*180/pi

%%
px=0;
py=0;
l1=1;
l2=1;
pocisiones=zeros(2,1000);

for i=1:1000
    pocisiones(1,i)=i/1000;
end
angulos=[0;0];
for i=1:1000
    px=pocisiones(1,i);
    cosq2=(px^2+py^2-l1^2-l2^2)/(2*l1*l2);
    senq2=(1-(cosq2)^2)^0.5;
    q2=atan(senq2/cosq2)*180/pi;
    beta=atan(py/px);
    alfa=atan((l2*senq2)/(l1+l2*cosq2));
    q1=(beta-alfa)*180/pi;
    angulos(i,1)=q1;
    angulos(i,2)=q2;
end
figure(1)
title("Angulo 1");
plot(angulos(:,1));

figure(2)
title("Angulo 2");
plot(angulos(:,2));

posi=[0;0];
for i=1:1000
    DH = [ l1 0 0 angulos(i,1)*pi/180
           l2 0 0 angulos(i,2)*pi/180];
    A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
    A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
    T1 = A1;
    T2 = T1*A2;
    posi(i,1)=T2(1,4);
    posi(i,2)=T2(4,4);
end
figure(3)
title("Posicion");
plot(posi(:,1),posi(:,2));






