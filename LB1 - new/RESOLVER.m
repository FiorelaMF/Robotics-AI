%function RESOLVER()
%LIMPIAMOS TODOS LOS DATOS EXISTENTES
clc,clear,close all;
%CREAMOS 10 MATRICES DE CEROS DE 16X16 Y VARIABLES
N = 10;
X = zeros(16, 16, N);
ErrorCE=zeros(10,20000);
ErrorSSE=zeros(10,20000);
%MATRIZ DE DATOS
SOL = ["PACMAN" "JINETE" "CONEJO" "HELICOPTERO" "PAJARO" "CAMELLO" "DIAMANTE" "CRUZ" "OCTAGONO" "HOURSE" "CISNE" "PEZ" "DELFIN" "UNO" "DOS" "TRES" "CUATRO" "CINCO"];
%ASIGNAMOS LAS 10 MATRICES CREADAS CON FUNSION FIGURA
X(:, :, 1) = Figuras('PACMAN');
X(:, :, 2) = Figuras('JINETE');
X(:, :, 3) = Figuras('CONEJO');
X(:, :, 4) = Figuras('HELICO');
X(:, :, 5) = Figuras('PAJARO');
X(:, :, 6) = Figuras('CAMELL');
X(:, :, 7) = Figuras('DIAMAN');
X(:, :, 8) = Figuras('CRUZAR');
X(:, :, 9) = Figuras('OCTAGO');
X(:, :,10) = Figuras('HOURSE');
% X(:, :,11) = Figuras('CISNEE');
% X(:, :,12) = Figuras('PECESI');
% X(:, :,13) = Figuras('DELFIN');
% X(:, :,14) = Figuras('1');
% X(:, :,15) = Figuras('2');
% X(:, :,16) = Figuras('3');
% X(:, :,17) = Figuras('4');
% X(:, :,18) = Figuras('5');
%RESPUESTAS QUE DEBE TENER NUESTRA SALIDA
D = diag([1 1 1 1 1 1 1 1 1 1]);
%PESOS ENTRE NEURONAS
W1 = 2*rand(100, 256) - 1;
W2 = 2*rand(50, 100) - 1;
W3 = 2*rand(25, 50) - 1;
W4 = 2*rand( N, 25) - 1;

Wa = 2*rand(100, 256) - 1;
Wb = 2*rand(50, 100) - 1;
Wc = 2*rand(25, 50) - 1;
Wd = 2*rand( N, 25) - 1;
%ENTRENAMIENTO DE LA RED NEURONAL
for epoch = 1:20000
    %LOS PESOS CON CROSS ENTROPY
    [W1, W2, W3, W4] = DeepDropout(W1, W2, W3, W4, X, D);
    %PESOS CON ERROR CUADRATICO MEDIO
    [Wa, Wb, Wc, Wd] = DeepDropoutSSE(Wa, Wb, Wc, Wd, X, D);
    %ERRORES Y VARIABLES
    es1 = 0;
    es2 = 0;
    for k = 1:N
        %CROSS ENTROPY
        x  = reshape(X(:, :, k), 256, 1);
        d = D(k,:);  
        v1 = W1*x;
        y1 = Sigmoid(v1);
        y1 = y1 .* Dropout(y1, 0.2);
        v2 = W2*y1;
        y2 = Sigmoid(v2);
        y2 = y2 .* Dropout(y2, 0.2);
        v3 = W3*y2;
        y3 = Sigmoid(v3);
        y3 = y3 .* Dropout(y3, 0.2);
        v  = W4*y3;
        y  = Softmax(v);
        a=d-y';
        es1 = es1 + (a(k))^2;
        %ERROR CUADRATICO MEDIO
        x  = reshape(X(:, :, k), 256, 1);
        d = D(k,:);
        v1 = Wa*x;
        y1 = Sigmoid(v1);
        y1 = y1 .* Dropout(y1, 0.2);
        v2 = Wb*y1;
        y2 = Sigmoid(v2);
        y2 = y2 .* Dropout(y2, 0.2);
        v3 = Wc*y2;
        y3 = Sigmoid(v3);
        y3 = y3 .* Dropout(y3, 0.2);
        v  = Wd*y3;
        y  = Softmax(v);
        a=d-y';
        es2 = es2 + (a(k))^2;
        %SE AÑADE A LA MATRIZ
        ErrorCE(k,epoch) = es1 / N;
        ErrorSSE(k,epoch) = es2 / N;
    end
end
%PLOTEO DE LOS ERRORES Y SU APRENDIZAJE
for i = 1:N
    subplot(2,N,i);
    plot(ErrorCE(i,1:20000), '.r')
    subplot(2,N,i+N);
    plot(ErrorSSE(i,1:20000), '.b')
end
suptitle("Error Cross Entropy VS Error Cuadratico Medio")

%IMPLEMENTACION DEL RUIDO

X(:, :, 1) = Ruido('JINETE');
X(:, :, 2) = Ruido('PACMAN');
X(:, :, 3) = Ruido('CONEJO');
X(:, :, 4) = Ruido('CAMELL');
X(:, :, 5) = Ruido('PAJARO');
X(:, :, 6) = Ruido('HELICO');
X(:, :, 7) = Ruido('DIAMAN');
X(:, :, 8) = Ruido('CRUZAR');
X(:, :, 9) = Ruido('HOURSE');
X(:, :,10) = Ruido('OCTAGO');

%CALCULO DE RESPUESTA
for k = 1:N
  x  = reshape(X(:, :, k), 256, 1);
  v1 = W1*x;
  y1 = Sigmoid(v1);
  v2 = W2*y1;
  y2 = Sigmoid(v2);
  v3 = W3*y2;
  y3 = Sigmoid(v3);
  v = W4*y3;
  y = Softmax(v);
  AA = round(y);
  SALIDA = SOL(find(AA == 1))
end