function [R,V,A] = trayrobot2(amax,vmax,pi,pf,dt)
[T1,R1,V1,A1] = trayp(amax(1),vmax(1),pi(1),pf(1),dt);
[T2,R2,V2,A2] = trayp(amax(2),vmax(2),pi(2),pf(2),dt);
[T3,R3,V3,A3] = trayp(amax(3),vmax(3),pi(3),pf(3),dt);
k = max([length(T1) length(T2) length(T3)]);
R = ones(k,3);R(:,1) = R1(length(R1),1);
R(:,2) = R2(length(R2),1);
R(:,3) = R3(length(R3),1);
R(1:length(R1),1)=R1;
R(1:length(R2),2)=R2;
R(1:length(R3),3)=R3;
V = zeros(k,3);
V(1:length(V1),1)=V1;
V(1:length(V2),2)=V2;
V(1:length(V3),3)=V3;
A = zeros(k,3);
A(1:length(A1),1)=A1;

A(1:length(A2),2)=A2;
A(1:length(A3),3)=A3;
T = zeros(k,1);
T(1:length(T1),1)=T1;
T(1:length(T2),1)=T2;
T(1:length(T3),1)=T3;

