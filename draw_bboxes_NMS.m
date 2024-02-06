%% 0 Preparation
clc;clear;close all
%% read picture
I = imread('TestingArea.png');
%% load matrix with detected drillholes (label=1)
load T7_DEM.mat
%% Define bbox and score 
bbox=T7(:,[6 5 7 8]);
score=T7(:,2);
%%
[selectedBbox,selectedScore] = selectStrongestBbox(bbox,score,'OverlapThreshold',0.1);
%% Display detection before NMS
I1 = insertObjectAnnotation(I,'rectangle',bbox,cellstr(num2str(score)),'Color','r');
figure;imshow(I1);
title('Before NMS');
%% display detection after NMS
I2 = insertObjectAnnotation(I,'rectangle',selectedBbox,cellstr(num2str(selectedScore)),'Color','r','LineWidth',8);
figure;imshow(I2);
title('After NMS');
%% previous method
%% loop for creation of remaining bboxes (sortFilenamesSW.m)
for i=1:size(T7)
    III = insertShape(I2,'rectangle',[T7(i,6) T7(i,5) T7(i,7) T7(i,8)],'LineWidth',10,'Color','red');
end
%% display picture and bboxes
figure;imshow(I);
title('drawing of bboxes with our method');