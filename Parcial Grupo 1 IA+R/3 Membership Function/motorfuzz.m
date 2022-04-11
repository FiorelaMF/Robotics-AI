function [Z] = motorfuzz(x1o,x2o);
load FM_Motor

% Fuzzification
x1_EANI = interp1(x1,x1_EAN,x1o);
x1_NI = interp1(x1,x1_N,x1o);
x1_EAPI = interp1(x1,x1_EAP,x1o);

x2_VANI = interp1(x2,x2_VAN,x2o);
x2_NI = interp1(x2,x2_N,x2o);
x2_VAPI = interp1(x2,x2_VAP,x2o);

[x1_EANI x1_NI x1_EAPI];
[x2_VANI x2_NI x2_VAPI];

% Fuzzy Rules 
% 9 rules 3x3
r1 = min(x1_EANI,x2_VANI);
r2 = min(x1_NI, x2_VANI);
r3 = min(x1_EAPI, x2_VANI);

r4 = min(x1_EANI, x2_NI);
r5 = min(x1_NI, x2_NI);
r6 = min(x1_EAPI, x2_NI);

r7 = min(x1_EANI, x2_VAPI);
r8 = min(x1_NI, x2_VAPI);
r9 = min(x1_EAPI, x2_VAPI);

% FAM
FAM = [r1 r2 r3 
    r4 r5 r6 
    r7 r8 r9];

% Speed
% mu_AN = [r1];
% mu_BN = [r2 r4];
% mu_P = [r3 r5 r7];
% mu_BP = [r8 r8];
% mu_AP = [r9];

% Position
mu_AN = [0];
mu_BN = [r1 r2 r3 r4];
mu_P = [r5];
mu_BP = [r6 r7 r8 r9];
mu_AP = [0];

% Union 
mu_AN = max(mu_AN);
mu_BN = max(mu_BN);
mu_P = max(mu_P);
mu_BP = max(mu_BP);
mu_AP = max(mu_AP);

% alfa-cut Values
mu_AN = mu_AN*ones(size(u_AN));
mu_BN = mu_BN*ones(size(u_BN));
mu_P = mu_P*ones(size(u_P));
mu_BP = mu_BP*ones(size(u_BP));
mu_AP = mu_AP*ones(size(u_AP));


% Intersection
mu_AN = min(mu_AN,u_AN);
mu_BN = min(mu_BN,u_BN);
mu_BP = min(mu_BP,u_BP);
mu_P = min(mu_P,u_P);
mu_AP = min(mu_AP,u_AP);

% Union applied
muZ = max([mu_AN; mu_BN; mu_P; mu_BP; mu_AP; mu_AP]);

% Defuzzyfication
Z = defuzz(u,muZ,'centroid');

end
