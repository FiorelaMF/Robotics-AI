clear all;
clc;
close all;

kkk=0;
k=1;
for titf=1:1:10
Px=kkk*0.1;

l2 =2; l3 =3;Py=1.7;
tita2(k,1)=acos((Px^2+Py^2-l2^2-l3^2)/(2*l2*l3));

aaa=l3*sin(tita2(k,1))*Px+(l2+l3*cos(tita2(k,1)))*Py;
bbb=-l3*sin(tita2(k,1))*Py+(l2+l3*cos(tita2(k,1)))*Px;
tita1(k,1)= -atan(aaa/bbb);

x_cart(k,1) =  -(l3*cos(tita1(k,1) + tita2(k,1)) + l2*cos(tita1(k,1)));
y_cart(k,1) =  (l3*sin(tita1(k,1) + tita2(k,1)) + l2*sin(tita1(k,1)));


k=k+1;
kkk=kkk+1;
end    
    
figure(1)
plot(x_cart,y_cart)
