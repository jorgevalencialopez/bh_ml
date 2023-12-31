%% 0 Preparation
clc;clear;close all
%% 1 import ortho with masks
D=imread('N-DS11.tiff');
%I=I(:,:,1:3);
%save I.mat
%load coordinates.mat %coordinates of Positive Samples (Drillholes)
%J=coordinates
%% 2 random values [0 30] and random signs generation
r=round(1+(30-1).*rand(151,1))%rand(x,1) x:Number of holes/labels (bbxoxes)
c=round(1+(30-1).*rand(151,1))
rd=2*randi([0 1],151,1)-1

%% 3 multiplication of random numbers and sign
R1 = r.*rd
C1 = c.*rd
%% load original C
%save C.mat %faster if you copy and paste from Excel
load C.mat
%% 4 row translation
%load C.mat
B=C(:,1)+R1 %reset C to its original coordinates
C(:,1)=B
%% 5 column translation
E=C(:,2)+C1
C(:,2)=E
%% 6 save translated pictures
for i=1:size(C,1)
    K = imcrop(D,[C(i,1) C(i,2) C(i,3) C(i,4)]);
    imwrite(K,(sprintf('DS11_T3_%d.png',i)))% rename accordingly
end