function [ J ] = jac(t4,t5,d6)
J = [ sin(t4)*sin(t5)*d6 -cos(t4)*cos(t5)*d6 0
-cos(t4)*sin(t5)*d6 -sin(t4)*cos(t5)*d6 0
0 sin(t5)*d6 0
0 -sin(t4) -cos(t4)*sin(t5)
0 cos(t4) -sin(t4)*sin(t5)
1 0 -cos(t5) ];