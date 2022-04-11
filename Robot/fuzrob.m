function RF = fuzrob(r,ZF);
% RF = fuzrob(r,ZF)
% En el archivo FUZROB r es el erro filtrado,
% r = derivada del error + lambda*error
% y ZF es la Norma Frobenius de Z
% ZF = sum(z(i,j)^2), donde z son los elementos
% de la matriz Z.
% Z = [ W 0
% 0 V ], donde W y V son los pesos adaptivos de la red neuronal
%
% RF es la señal Robusta Difusa del manipulador.
% Funciones de Membresía de las entradas r y ZF
BNR = max(min(tan(-1/8)*(r+2),1),0);
SNR = max(min(min(tan(1/8)*(r+10),tan(-1/(2-0.005))*(r+0.005)),1),0);
ZER = max(min(min(tan(1/2)*(r+2),tan(-1/2)*(r-2)),1),0);
SPR = max(min(min(tan(1/(2-0.005))*(r-0.005),tan(-1/8)*(r-10)),1),0);
BPR = max(min(tan(1/8)*(r-2),1),0);
ZEZ = max(min(tan(-1/150)*(ZF-200),1),0);
SPZ = max(min(min(tan(1/150)*(ZF-50),tan(-1/800)*(ZF-1000)),1),0);
LPZ = max(min(tan(1/800)*(ZF-200),1),0);
% Reglas Difusas
R1 = min(BNR,ZEZ);% R1 = if r is BNR and ZF is ZEZ then RF is BPRF.
R2 = min(BNR,SPZ);% R2 = if r is BNR and ZF is SPZ then RF is XBPRF.
R3 = min(BNR,LPZ);% R3 = if r is BNR and ZF is LPZ then RF is XBPRF.
R4 = min(SNR,ZEZ);% R4 = if r is SNR and ZF is ZEZ then RF is SPRF.
R5 = min(SNR,SPZ); % R5 = if r is SNR and ZF is SPZ then RF is BPRF.
R6 = min(SNR,LPZ); % R6 = if r is SNR and ZF is LPZ then RF is BPRF.
R7 = min(ZER,ZEZ); % R7 = if r is ZER and ZF is ZEZ then RF is ZRF.
R8 = min(ZER,SPZ); % R8 = if r is ZER and ZF is SPZ then RF is ZRF.
R9 = min(ZER,LPZ); % R9 = if r is ZER and ZF is LPZ then RF is ZRF.
R10 = min(SPR,ZEZ); % R10 = if r is SPR and ZF is ZEZ then RF is SNRF.
R11 = min(SPR,SPZ); % R11 = if r is SPR and ZF is SPZ then RF is BNRF.
R12 = min(SPR,LPZ); % R12 = if r is SPR and ZF is LPZ then RF is BNRF.
R13 = min(BPR,ZEZ); % R13 = if r is BPR and ZF is ZEZ then RF is BNRF.
R14 = min(BPR,SPZ); % R14 = if r is BPR and ZF is SPZ then RF is XBNRF.
R15 = min(BPR,LPZ); % R15 = if r is BPR and ZF is LPZ then RF is XBNRF

XBPRF = max(R2,R3);
BPRF = max(max(R1,R5),R6);
SPRF = R4;
ZRF = max(max(R7,R8),R9);
SNRF = R10;
BNRF = max(max(R11,R12),R13);
XBNRF = max(R14,R15);
% Salida Difusa (COA)
salidanum = XBPRF*1000000+BPRF*200000+SPRF*20000+ ...
ZRF*0.5+SNRF*(-20000)+BNRF*(-200000)+XBNRF*(-1000000);
salidaden = XBPRF+BPRF+SPRF+ZRF+SNRF+BNRF+XBNRF;
RF = salidanum/salidaden;