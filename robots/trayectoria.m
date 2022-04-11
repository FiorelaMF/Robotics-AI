function [rf,T,R,V,A] = trayectoria(a_max,v_max,ro,rf,plotear);

% input data
%   [rf,T,R,V,A] = trayectoria(a_max,v_max,ro,rf,plot)
% 
%   imput values:
%   a_max: (int or float) maximum possible aceleration
%   v_max: (int or float) maximum possible speed
%   ro: (int or float) initial position
%   rf: (int or float) desired final position
%   plote: (string) write "plot" if you want to plot
% 
%   output values 
%   rf = final position
%   T = vector of time
%   R = vector of position
%   V = vector of speed
%   A = vector of aceleration


dt = 0.001;
if ~exist('plotear','var')
     % third parameter does not exist, so default it to something
      plotear = " ";
 end
 
% recorrido deseado
% ro = 0;
% rf = 40;

% definicion de variables
ts = v_max/a_max;
rs = a_max*ts*ts/2;
re = abs(ro-rf);
signo = (rf - ro)/re;

% verifiacion de numero de etapas
if re>rs*2
%     3 etapas
%     disp("3 etapas")
    t1 = v_max / a_max;

    r12 = re - 2*rs;
    t12 = r12 / v_max;

    t22 = t1 + t12; 
    t23 = t1 + t12;

    t3 = t22+t1;
else
%     2 etapas
%     disp("2 etapas")
    t1 = (re/a_max)^(1/2);

    t22 = 0;
    t23 = t1;

    t3 = 2*t1;
end




%  1era etapa (t0 - t1) acelareacion maxima

a1 = a_max*signo;
v = 0;
r = ro;
k = 1;
for t = 0:dt:t1
    A(k,1) = a1;
    V(k,1) = v;
    R(k,1) = r;
    T(k,1) = t;

    r = r + v*dt + a1*dt*dt/2;
    v = v + a1*dt;

    k = k+1;
end


% 2so erapa (t1 - t0) velocidad maxima
a2 = 0; 
v = V(end);
r = R(end) + V(end) * dt ;

for t = t1+dt:dt:t22
A(k,1) = a2;
V(k,1) = v;
R(k,1) = r;
T(k,1) = t;

r = r + v*dt;
k = k +1;


end


% 3ra erapa (t1 - t0) aceleracion maxima negativa
a3 = - a_max * signo; 
v = V(end);
r = R(end) + V(end) * dt;


for t = t23+dt:dt:t3
    A(k,1) = a3;
    V(k,1) = v;
    R(k,1) = r;
    T(k,1) = t;

    r = r + v*dt + a3*dt*dt/2;
    v = v + a3*dt;

    k = k +1;
end

if plotear == "plot"
    plot(T,R,"b",T,V,"g",T,A,"r")
    grid
    legend("path", "speed", "acceleration")
end

rf = R(end);





















