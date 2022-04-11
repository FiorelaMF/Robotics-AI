close all, clc, clear all;

% Letra T
G1 = [0.30 0.20 0.25 0.25];
G2 = [0.30 0.30 0.30 0.20];
movement(G1,G2);

% ROBOT PLOTTER
function movement(POSX,POSY)
m1 = 0.0644;
m2 = 0.0644;
l1 = 0.25; 
l2 = 0.25;
g = 9.81;
Xi = POSX(1); 
Yi = POSY(1);
k = 1;
TT = 0;
for pts = 1:(length(POSX)-1)
    % Inverse Cinematic
    [q1m1,q2m1]=Cinv(Xi,Yi,l1,l2);
    [q1m2,q2m2]=Cinv(POSX(pts+1),POSY(pts+1),l1,l2);
    p0 = [q1m1 q2m1]';
    pf = [q1m2 q2m2]';
    pfp =[0 0]';
    t0 = 0;
    dt = 0.005;
    x = [p0' pfp' 0 0]';
    Txpts=[Xi POSX(pts+1)];
    Typts=[Yi POSY(pts+1)];
    [~,R1,V1,A1] = PLOTTER(false,50,Txpts,Typts,l1,l2,dt,14);
    QD = R1;
    QDP = V1;
    QDPP = A1;
    T = 0:(max(size(QD))-1);
    T = T'*dt;
    TT = [TT; T+TT(end,1)];  
    qd = QD(:,1:2)';
    qdp = QDP(:,1:2)';
    qdpp = QDPP(:,1:2)';
    % Controller Parameters
    Kp = 500*eye(2); 
    Kv = 200*eye(2);
    Ki = 10*eye(2);
    kk = 1;
    for t=0:dt:(max(T))
        q1 = x(1) ; q2 = x(2);
        q1p = x(3); q2p = x(4);
        % Following Errors
        e = qd(:,kk)-x(1:2);    % Planned Trajectory - Actual
        ep = qdp(:,kk)-x(3:4);    % Planned Speed - Actual Speed
        % Dinamical Model Robot Matrix Calculation
        % Inercial Matrix
        M = [(m2*(2*l1^2+2*cos(q2)*l1*l2+l2^2/2))/2+(l1^2*m1)/4 (l2*m2*(l2+2*l1*cos(q2)))/4;(l2*m2*(l2+2*l1*cos(q2)))/4 (l2^2*m2)/4];
        % Coriolis Matriz
        C = [-(l1*l2*m2*q2p*sin(q2))/2 -(l1*l2*m2*sin(q2)*(q1p+q2p))/2;(l1*l2*m2*q1p*sin(q2))/2 0];
        N = C*[q1p q2p]';
        % Gravity Vector
        G = [g*m2*((l2*cos(q1+q2))/2+l1*cos(q1))+(g*l1*m1*cos(q1))/2;(g*l2*m2*cos(q1 + q2))/2];
        % Control Torque
        S = qdpp(:,kk) + Kv*ep + Kp*e+ Ki*x(5:6);
        tau = M*S+N+G;
        % Space State
        xp = [x(3:4); inv(M)*(-N-G+tau);e];
        % Integration
        x = x + xp*dt;
        % Direct Cinematic
        [T1,T2] = Cdir(x(1),x(2),l1,l2);
        x1(k,1) = T1(1,4);
        y1(k,1) = T1(2,4);
        x2(k,1) = T2(1,4);
        y2(k,1) = T2(2,4);
        [~,IT2] = Cdir(QD(kk,1),QD(kk,2),l1,l2);
        ix2(k,1) = IT2(1,4);
        iy2(k,1) = IT2(2,4);
        kk = kk + 1;
        k = k + 1;
    end
    Xi = x2(end,1);
    Yi = y2(end,1);
end
TT = TT(2:end);
% SIMULATION
for i = 1:floor(length(x1)/10):length(x1)
    figure(1)
    plot(ix2(:,1),iy2(:,1),'r--');hold on;
    plot(0,0,'kO','LineWidth',3);
    plot([-(l1*2.5) (l1*2.5)],[0 0],'k-','LineWidth',3);
    plot(x1(i,1),y1(i,1),'kO','LineWidth',3);
    plot(x2(1:i,1),y2(1:i,1),'b');  
    plot([0 x1(i,1) x2(i,1)],[0 y1(i,1) y2(i,1)],'k','LineWidth',3);hold off;
    title("Letra T - Fiorela Manco");grid minor;
    axis([-(l1*2.5) l1*2.5 -0.1 (l1*2.5)-0.1]);
    pause(0.2)
end
figure(1);
plot(ix2(:,1),iy2(:,1),'r--');hold on;
plot(0,0,'kO','LineWidth',3);
plot([-(l1*2.5) (l1*2.5)],[0 0],'k-','LineWidth',3);
plot(x1(i,1),y1(i,1),'kO','LineWidth',3);
plot(x2(:,1),y2(:,1),'b');
plot([0 x1(end,1) x2(end,1)],[0 y1(end,1) y2(end,1)],'k','LineWidth',3);hold off;
title("Letra T - Fiorela Manco");grid minor;
axis([-(l1*2.5) l1*2.5 -0.1 (l1*2.5)-0.1]);
end
function [T,R,V,A] = PLOTTER(conti,npts,px,py,l1,l2,dt,time)
    POSX = linspace(px(1),px(2),npts);
    POSY = linspace(py(1),py(2),npts);
    i=1;
    for pts=1:npts
        [q1(i,1),q2(i,1)]=Cinv(POSX(pts),POSY(pts),l1,l2);
        i=i+1;
    end
    [T1,R1,V1,A1] = MovC(npts,q1,dt,time,conti);
    [T2,R2,V2,A2] = MovC(npts,q2,dt,time,conti);
    k = max([length(T1) length(T2)]);
    R = ones(k,2);
    R(:,1) = R1(length(R1),1); R(:,2) = R2(length(R2),1);
    R(1:length(R1),1)=R1; R(1:length(R2),2)=R2;
    V = zeros(k,2);
    V(1:length(V1),1)=V1; V(1:length(V2),2)=V2;
    A = zeros(k,2);
    A(1:length(A1),1)=A1; A(1:length(A2),2)=A2;
    T = zeros(k,2);
    T(1:length(T1),1)=T1; T(1:length(T2),2)=T2;
end
function [T1,R1,V1,A1] = MovC(npts,pos,dt,tf,conti)
    th0=pos(1);
    thf=pos(end);
    t0 = 0;
    time = linspace(t0,tf,npts);
    k = 1;
    if conti
        [a] = MatrixCon(th0,0,thf,0,0,tf);
        vel = a(2)+2*a(3)*time+3*a(4)*time.^2;
    else
        vel = zeros(1,npts);
    end 
    for i = 1:(length(time)-1)
        [a] = MatrixCon(pos(i),vel(i),pos(i+1),vel(i+1),time(i),time(i+1));
        for t =time(i):dt:(time(i+1)-dt)
            T(k,1) = t; 
            Pfuncion1 = a(1) + a(2)*t + a(3)*t^2 + a(4)*t^3;
            Pf(k,1)=Pfuncion1;
            Vfuncion1 = a(2) + 2*a(3)*t + 3*a(4)*t^2;
            Vf(k,1)=Vfuncion1;
            Afuncion1 = 2*a(3) + 6*a(4)*t;
            Af(k,1)=Afuncion1;
            k=k+1;
        end
    end
    T1=T;R1=Pf;V1=Vf;A1=Af;
end
function [a] = MatrixCon(q0,v0,q1,v1,t0,tf)
    M = [ 1 t0 t0^2 t0^3; 
         0 1 2*t0 3*t0^2;
         1 tf tf^2 tf^3; 
         0 1 2*tf 3*tf^2];
    b = [q0;v0;q1;v1];
    a = inv(M)*b;
end
function [T1,T2] = Cdir(q1,q2,l1,l2)
    DH = [l1 0 0  q1; 
          l2 0 0  q2];
    A1 = matra(DH(1,1),DH(1,2),DH(1,3),DH(1,4));
    A2 = matra(DH(2,1),DH(2,2),DH(2,3),DH(2,4));
    T1 = A1;
    T2 = T1*A2;
end
function [q1,q2] = Cinv(x,y,l1,l2)
    cosq2 = (x^2+y^2-l1^2-l2^2)/(2*l1*l2);
    q2 = atan2(-(sqrt(1 - cosq2^2)),cosq2);
    beta = atan2(y,x);
    alpha = atan2((l2*sin(q2)),(l1+l2*cos(q2)));
    q1 = beta-alpha;
end
function [A] = matra(a,d,a1,th)
A = [ cos(th) -cos(a1)*sin(th)  sin(a1)*sin(th) a*cos(th);
    sin(th)  cos(a1)*cos(th) -sin(a1)*cos(th) a*sin(th); 
    0 sin(a1) cos(a1) d; 
    0 0 0 1];
end

