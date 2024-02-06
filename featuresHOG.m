%% 1 Start the function 
function [H24] = featuresHOG(imageName)
%% 2 Run vlfeat
run vlfeat-0.9.21/toolbox/vl_setup;
%% 3 Read each patch
imageName;
im = imread(imageName);
%{ 
 if(size(im,3) == 3)
     im = rgb2gray(im);
 end
%}
im = single(im);
%% 4 Resize patches to 96x96
I24 = imresize(im, 'bilinear', 'OutputSize', [96 96]);
%% 5 Histogram of gradients computation
hog24 = vl_hog(I24, 8, 'verbose') ;%key,HOG = VL_HOG(IM, CELLSIZE)
H24 = reshape(hog24, [size(hog24,1).*size(hog24,2).*31 1]);

H48 = 0;
%{
 I48 = imresize(im, 'bilinear', 'OutputSize', [48 48]);
 hog48 = vl_hog(I48, 8, 'verbose') ;
 H48 = reshape(hog48, [size(hog48,1).*size(hog48,2).*31 1]);
 
 I96 = imresize(im, 'bilinear', 'OutputSize', [96 96]);
 hog96 = vl_hog(I96, 8, 'verbose') ;
 H96 = reshape(hog96, [size(hog96,1).*size(hog96,2).*31 1]);
%}
H96 =0;
end
