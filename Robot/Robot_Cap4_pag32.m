clear all;close all
d6 = 1;
cdor = 1;
for t4 = 0:pi/180:2*pi
for t5 = 0:pi/180:2*pi
J = jac(t4,t5,d6);
if rank(J) < 3;
t4J(cdor,1) = t4;
t5J(cdor,1) = t5;
rk(cdor,1) = rank(J);
cdor = cdor + 1;
end
end
end