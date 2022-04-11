

clear all
clc

%X = [0.05 0.1];

%D = [0.01 0.99];
   

X = [0.5 0.2];

D = [0.3 0.7];


w1=0.10;
w2=0.25;
w3=0.20;
w4=0.35;
w5=0.35;
w6=0.40;
w7=0.45;
w8=0.50;



W1 = [w1 w2
    w3 w4];

W2 = [w5 w6
    w7 w8];

b1=0.35;
b2=0.6;


for epoch = 1:10000       % train
  [W1 W2] = BackpropTO(W1, W2, X, D);
  
end

N = 1;                        % inference
for k = 1:N
  x  = X(k, :)';
  v1 = W1*x +b1;
  y1 = Sigmoid(v1);
  
  v  = W2*y1 +b2;
  y  = Sigmoid(v)
end
load es1
es1(1,1)+es1(2,1)