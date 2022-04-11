function [T,R,V,A] = traypunt(amax,vmax,pi,pf)

rmax = abs(pf-pi);
% Cálculo de los tiempos
dt = 0.001;
t0 = 0;
t1 = vmax/amax;
r1 = 0.5*amax*t1^2;
r2 = rmax-2*r1;
t2 = t1+r2/vmax;
r2 = r1+r2;
tf = t1+t2;
r3 = r2+vmax*(tf-t2)+0.5*(-amax)*(tf-t2)^2;
t = [ t0 t1 t2 tf ];
r = [ r1 r2 r3 ];
% Definiendo y renombrando las C.I.
r0 = 0; v0 = 0; a0 = amax;
r = r0; v = v0; a = a0;
% Reproducción de la trayectoria
k = 1;
for t = t0:dt:t1
a = amax;
v = v + a*dt;
r = r + v*dt+0.5*a*dt^2;
A(k,1) = a; V(k,1) = v;
R(k,1) = r; T(k,1) = t;
k = k + 1;
end
for t = (t1+dt):dt:t2
a = 0;
v = vmax;
r = r + v*dt;
A(k,1) = a; V(k,1) = v;
R(k,1) = r; T(k,1) = t;
k = k + 1;
end

for t = (t2+dt):dt:tf
a = -amax;
v = v + a*dt;
r = r + v*dt+0.5*a*dt^2;
A(k,1) = a; V(k,1) = v;
R(k,1) = r; T(k,1) = t;
k = k + 1;
end
if pf<pi
A = -A;
V = -V;
R = pi*ones(size(R))+ones(size(R))*min(R)-R;
else
R = pi*ones(size(R))+R;
end