function RESOLVER()
%LIMPIAMOS TODOS LOS DATOS EXISTENTES
clc,clear,close all;
%CREAMOS 10 MATRICES DE CEROS DE 16X16
X = zeros(16, 16, 10);
%MATRIZ DE DATOS
SOL = ["PACMAN" "JINETE" "CONEJO" "HELICOPTERO" "PAJARO" "CAMELLO" "DIAMANTE" "CRUZ" "OCTAGONO" "HOURSE"];
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
%RESPUESTAS QUE DEBE TENER NUESTRA SALIDA
D = diag([1 1 1 1 1 1 1 1 1 1]);
%PESOS ENTRE NEURONAS
W1 = 2*rand(100, 256) - 1;
W2 = 2*rand(50, 100) - 1;
W3 = 2*rand(25, 50) - 1;
W4 = 2*rand( 10, 25) - 1;
%ENTRENAMIENTO DE LA RED NEURONAL
for epoch = 1:20000
  [W1, W2, W3, W4] = DeepDropout(W1, W2, W3, W4, X, D);
end
%IMPLEMENTACION DEL RUIDO
X(:, :, 1) = Ruido('PACMAN');
X(:, :, 2) = Ruido('JINETE');
X(:, :, 3) = Ruido('CONEJO');
X(:, :, 4) = Ruido('HELICO');
X(:, :, 5) = Ruido('PAJARO');
X(:, :, 6) = Ruido('CAMELL');
X(:, :, 7) = Ruido('DIAMAN');
X(:, :, 8) = Ruido('CRUZAR');
X(:, :, 9) = Ruido('OCTAGO');
X(:, :,10) = Ruido('HOURSE');
%CALCULO DE RESPUESTA
N = 10;
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