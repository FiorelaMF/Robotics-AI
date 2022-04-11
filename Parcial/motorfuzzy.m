function [Z]=motorfuzzy(x1o,x2o);

x1o = deg2rad(x1o);
x2o = deg2rad(x2o);

load FM_MOTOR
%Fuzzyficacion
x1_EANI=interp1(x1,x1_EAN,x1o);
x1_NI=interp1(x1,x1_N,x1o);
x1_EAPI=interp1(x1,x1_EAP,x1o);

x2_VANI=interp1(x2,x2_VAN,x2o);
x2_NI=interp1(x2,x2_N,x2o);
x2_VAPI=interp1(x2,x2_VAP,x2o);

[x1_EANI x1_NI x1_EAPI];
[x2_VANI x2_NI x2_VAPI];

%reglas difusas
r1=min(x1_EANI,x2_VANI);
r2=min(x1_NI,x2_VANI);
r3=min(x1_EAPI,x2_VANI);

r4=min(x1_EANI,x2_NI);
r5=min(x1_NI,x2_NI);
r6=min(x1_EAPI,x2_NI);

r7=min(x1_EANI,x2_VAPI);
r8=min(x1_NI,x2_VAPI);
r9=min(x1_EAPI,x2_VAPI);

%FAM
FAM=[r1 r2 r3
    r4 r5 r6
    r7 r8 r9];

% Posición
mu_AN=[0];
mu_BN=[r1 r2 r3 r4];
mu_P=[r5];
mu_BP=[r6 r7 r8 r9];
mu_AP=[0];

%Union
mu_AN=max(mu_AN);
mu_BN=max(mu_BN);
mu_P=max(mu_P);
mu_BP=max(mu_BP);
mu_AP=max(mu_AP);

%VALORES ALFA CUT
mu_AN=mu_AN*ones(size(mu_AN));
mu_BN=mu_BN*ones(size(mu_BN));
mu_P=mu_P*ones(size(mu_P));
mu_BP=mu_BP*ones(size(mu_BP));
mu_AP=mu_AP*ones(size(mu_AP));

%Aplicamos la interseccion
mu_AN=min(mu_AN,u_AN);
mu_BN=min(mu_BN,u_BN);
mu_P=min(mu_P,u_P);
mu_BP=min(mu_BP,u_BP);
mu_AP=min(mu_AP,u_AP);

%aplicamos union
muZ=max([mu_AN;mu_BN;mu_P;mu_BP;mu_AP]);

%Desfuzzyficacion
Z=defuzz(u,muZ,'centroid');

end