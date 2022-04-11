function[A] = matra(a,d,a1,th)
%function[A] = matra(th,d,a,a1);
% Matriz de Transformacion
A = [ cos(th) -cos(a1)*sin(th) sin(a1)*sin(th) a*cos(th)
sin(th) cos(a1)*cos(th) -sin(a1)*cos(th) a*sin(th)
0 sin(a1) cos(a1) d
0 0 0 1 ];

