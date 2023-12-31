%% 1 Preparation
close all
clear
clc

%% 2 Read Ortho and convert it to RGB
J=imread('Holes_Ortho_depured.tif');
J=J(:,:,1:3);
%J=J(:,:,1);
%[r1,c1] = size(J)

%% 3 Generation of Random coordinates and croping dimension boxes
r=round(1+(14143-1).*rand(1000,1))
c=round(1+(7747-1).*rand(1000,1))
a=round(200+(400-200).*rand(1000,1))

%% 4 Croping and saving cropped pictures
for i=501:550
    if r(i,1) < 7000
        I=imcrop(J,[r(i,1),c(i,1),a(i,1),a(i,1)]);
        imwrite(I,(sprintf('C%02d.png',i)))
    else
        i=i+1
    %pause(60);
    end
    
end