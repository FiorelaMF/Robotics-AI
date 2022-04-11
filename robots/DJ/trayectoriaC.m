function [R,V,A] = trayectoriaC(amax,vmax,pi,pf,dt)
%  figure(1)
[T1,R1,V1,A1] = trayp(amax(1),vmax(1),pi(1),pf(1),dt);

% figure(2)
[T2,R2,V2,A2] = trayp(amax(2),vmax(2),pi(2),pf(2),dt);

 
k = max([length(T1) length(T2)]);
R = ones(k,2);
R(:,1) = R1(max(size(R1)),min(size(R1)));
R(:,2) = R2(max(size(R2)),min(size(R2)));

R(1:length(R1),1)=R1;
R(1:length(R2),2)=R2;

V = zeros(k,2);
V(1:length(V1),1)=V1;
V(1:length(V2),2)=V2;

 
A = zeros(k,2);
A(1:length(A1),1)=A1;
A(1:length(A2),2)=A2;
 
T = zeros(k,1);
T(1:length(T1),1)=T1;
T(1:length(T2),1)=T2;


end