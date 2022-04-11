close all; clear; clc;
figuritas = ["PACMAN", "JINETE", "CONEJO", "HELICO", "PAJARO", "CAMELL", "DIAMAN", "CRUZAR", "OCTAGO", "HOURSE"];
for i=1:10
    imagen = Ruido(figuritas(i));
    subplot(2,5,i);
    
    imshow(imagen);
    xlabel(figuritas(i),'FontSize',30,'FontWeight','bold','Color','k')
    %impixelinfo;

end