function [T,R,V,A] = trayectoria(amax_t,vmax_t,pi,pf)

[T1,R1,V1,A1] = traypunt_cart(amax_t,vmax_t,pi(1),pf(1));
[T2,R2,V2,A2] = traypunt_cart(amax_t,vmax_t,pi(2),pf(2));
[T3,R3,V3,A3] = traypunt_cart(amax_t,vmax_t,pi(3),pf(3));

k = max([length(T1) length(T2) length(T3)]);
R = ones(k,3);
R(:,1) = R1(max(size(R1)),min(size(R1)));
R(:,2) = R2(max(size(R2)),min(size(R2)));
R(:,3) = R3(max(size(R3)),min(size(R3)));

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

end