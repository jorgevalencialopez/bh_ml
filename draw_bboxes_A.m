%{
This script allows to draw bounding boxes in the location of the extracted
patches.These patches were classified previously as drillhole(1) or no
drillhole(2). The patches classified as drillholes(1) were filtered out so
this script draw red bounding boxes, over the testing ortho image, using
only the detected drillhole positions.
%}
%% 1 read picture
function[]= draw_bboxes_A(testImage)
I = imread(testImage);
% 2 copy I---FASTER if you make right click over I and select duplicate
K=I;
%% 3 loop for insert bboxes
for i=1:size(T7)
    K = insertShape(K,'rectangle',[T7(i,6) T7(i,5) T7(i,7) T7(i,8)],'LineWidth',10,'Color','red');
end
%% 4 display picture and bboxes
figure;imshow(K);
title('Drillholes detected by SVM(HoG) using DEM');
end
