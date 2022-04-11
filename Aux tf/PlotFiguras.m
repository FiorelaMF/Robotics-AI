close all; clc; 

nums = [0, 1, 2];

for i = 1:length(nums)
    img = RUIDO(nums(i));
    
    figure(1);
    subplot(1,3,i);
    imshow(img);
end
    


