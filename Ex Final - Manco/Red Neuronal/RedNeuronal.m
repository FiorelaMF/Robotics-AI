close all; clc; clear all;
ruta = "C:\Users\Fiorela\Documents\MATLAB\Robótica e IA codes\Ex Final - Manco\Red Neuronal\imagenes\";

% IMÁGENES DE APRENDIZAJE
A1 = imread(ruta+"A1.png");
%A1r = imresize(A1, 1.3);
A1BE = edge(A1(:,:,1), 'Canny');

B1 = imread(ruta+"B1.png");
%B1r = imresize(B1, 1.3);
B1BE = edge(B1(:,:,1), 'Canny');

personajes = ["Shusei Kagari" "Akane Tsunemori"];

figure(1);
subplot(121); imshow(A1); title(personajes(1));
subplot(122); imshow(B1); title(personajes(2));

% ENTRADA
global ndim;
ndim = 269;
X = zeros(ndim, ndim, 2);

%%
% AJUNTAR IMAGS A ENTRADA
X(:,:,1) = A1BE(1:ndim,1:ndim);       
X(:,:,2) = B1BE(1:ndim,1:ndim);

D = diag([1 1]);    %respuesta deseada

% PESOS ENTRE NEURONAS
W1 = 2*rand(4, ndim^2) - 1;
W2 = 2*rand(2, 4) - 1;
W3 = 2*rand(1, 2) - 1;
W4 = 2*rand(2, 1) - 1;

% ENTRENAMIENTO DE LA RED NEURONAL
for epoch = 1:10000
    [W1, W2, W3, W4] = DeepDropout(W1, W2, W3, W4, X, D);
end
%%
%Resize de imágenes
A2 = imread(ruta+"A5.png");
A2r = imresize(A2, 0.6);
A2b = edge(A2r(:,:,1), 'Canny');

A3 = imread(ruta+"A6.png");
A3r = imresize(A3, 1.2);
A3b = edge(A3r(:,:,1), 'Canny');

B2 = imread(ruta+"B5.png");
B2r = imresize(B2, 0.45);
B2b = edge(B2r(:,:,1), 'Canny');

%B3 = imread(ruta+"B3.png");
B3 = imread(ruta+"B4.png");
B3r = imresize(B3, 0.4);
B3b = edge(B3r(:,:,1), 'Canny');
%%
X(:,:,1) = A2b(1:ndim,1:ndim);       %269 x 269
X(:,:,2) = A3b(1:ndim,1:ndim);
X(:,:,3) = B2b(1:ndim,1:ndim);
X(:,:,4) = B3b(1:ndim,1:ndim);
%X(:,:,4) = B3b(1:269,200:468);

% Guarda los resultados
salida_list = ["" "" "" ""];

%CALCULO DE RESPUESTA
N = 4;
for k = 1:N  
  x  = reshape(X(:, :, k), ndim^2, 1);
  v1 = W1*x;
  y1 = Sigmoid(v1);
  
  v2 = W2*y1;
  y2 = Sigmoid(v2);
  
  v3 = W3*y2;
  y3 = Sigmoid(v3);
  
  v = W4*y3;
  y = Softmax(v);
  AA = round(y);
  SALIDA = personajes(find(AA == 1))
  salida_list(k) = SALIDA;
end



imgs = {A2 A3 B2 B3};
%imgs = {A2 B2};
% SUBPLOT MUESTRA RESULTADOS
for i =1:4
    figure(2);
    subplot(1,4,i);
    imshow(imgs{1,i});
    title(salida_list(i));
end

%% FUNCIONES
function [W1, W2, W3, W4] = DeepDropout(W1, W2, W3, W4, X, D)
alpha = 0.01;
N = 2;
for k = 1:N
    x = reshape(X(:, :, k), 269*269, 1);
    v1 = W1*x;
    y1 = Sigmoid(v1);
    y1 = y1 .* Dropout(y1, 0.2);
    v2 = W2*y1;
    y2 = Sigmoid(v2);
    y2 = y2 .* Dropout(y2, 0.2);
    v3 = W3*y2;
    y3 = Sigmoid(v3);
    y3 = y3 .* Dropout(y3, 0.2);
    v = W4*y3;
    y = Softmax(v);
    d = D(k, :)';
    e = d - y;
    delta = e;
    e3 = W4'*delta;
    delta3 = y3.*(1-y3).*e3;
    e2 = W3'*delta3;
    delta2 = y2.*(1-y2).*e2;
    e1 = W2'*delta2;
    delta1 = y1.*(1-y1).*e1;
    dW4 = alpha*delta*y3';
    W4 = W4 + dW4;
    dW3 = alpha*delta3*y2';
    W3 = W3 + dW3;
    dW2 = alpha*delta2*y1';
    W2 = W2 + dW2;
    dW1 = alpha*delta1*x';
    W1 = W1 + dW1;
end
end
function ym = Dropout(y, ratio)
  [m, n] = size(y);  
  ym     = zeros(m, n);
  
  num     = round(m*n*(1-ratio));
  idx     = randperm(m*n, num);
  ym(idx) = 1 / (1-ratio);
end
function y = Sigmoid(x)
  y = 1 ./ (1 + exp(-x));
end
function y = Softmax(x)
  ex = exp(x);
  y  = ex / sum(ex);
end



