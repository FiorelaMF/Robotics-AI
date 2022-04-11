function [Tf,Rf,Vf,Af] = trayp(amax,vmax,pi,pf,dt)
rmax = abs(pf-pi);
% Cálculo de los tiempos
t0 = 0; t1 = vmax/amax;
r1 = 0.5*amax*t1^2; r2 = rmax-2*r1;
t2 = t1+r2/vmax;
r2 = r1+r2;
tf = t1+t2;
r3 = r2+vmax*(tf-t2)+0.5*(-amax)*(tf-t2)^2;
t = [ t0 t1 t2 tf ];
r = [ r1 r2 r3 ];

% Definiendo y renombrando las Condiciones Iniciales
r0 = 0; v0 = 0; a0 = amax; r = r0; v = v0; a = a0;
% Reproducción de la trayectoria
k = 1;
if t1<t2 %Trayectoria de 3 etapas
for t = t0:dt:t1
A(k,1) = a; V(k,1) = v; R(k,1) = r; T(k,1) = t;
a = amax; v = v + a*dt; r = r + v*dt+0.5*a*dt^2;
if v > vmax; v = vmax; end
k = k + 1;
end
for t = (t1+dt):dt:t2
A(k,1) = a; V(k,1) = v; R(k,1) = r; T(k,1) = t;
a = 0; v = vmax; r = r + v*dt;
k = k + 1;
end
for t = (t2+dt):dt:tf
A(k,1) = a; V(k,1) = v; R(k,1) = r; T(k,1) = t;
a = -amax; v = v + a*dt; r = r + v*dt+0.5*a*dt^2;
k = k + 1;
end
else %Trayectoria de 2 etapas
t1 = sqrt(rmax/amax);

tf = 2*t1;
for t = t0:dt:t1
A(k,1) = a; V(k,1) = v; R(k,1) = r; T(k,1) = t;
a = amax; v = v + a*dt; r = r + v*dt+0.5*a*dt^2;
k = k + 1;
end
for t = (t1+dt):dt:tf
A(k,1) = a; V(k,1) = v; R(k,1) = r; T(k,1) = t;
a = -amax; v = v + a*dt; r = r + v*dt+0.5*a*dt^2;
k = k + 1;
end
end
if pf<pi
A = -A; V = -V; R = pi*ones(size(R))-R +ones(size(R))*min(R)*1;
else
R = pi*ones(size(R))+R;
end
if pf==pi
A = zeros(size(A)); V = zeros(size(V));R = pi*ones(size(R));
end
Tf = T(1:k-1,1); Rf = R(1:k-1,1); Vf = V(1:k-1,1); Af = A(1:k-1,1);