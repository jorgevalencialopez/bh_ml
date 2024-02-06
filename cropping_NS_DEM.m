%% 1 Load DEM
load D.mat %DEM Training Area 
load C.mat %coordinates labeled drillholes
%% 2 Generation of Random coordinates and croping dimension boxes
r=round(400+((size(D,1)-400)-400).*rand(700,1))
c=round(400+((size(D,2)-400)-400).*rand(700,1))
a=round(200+(400-200).*rand(700,1))
%%
NSDEM={}
for i=1:length(a) 
    NSDEM(i,1) = {['NSDEM',num2str(i)]}    
end
%% 3 Croping and saving cropped pictures DEM
for i=1:length(a) 
    NSDEM{i,2} = imcrop(D,[c(i,1),r(i,1),a(i,1),a(i,1)]);
end
%% see NS DEM generated
set(0,'DefaultFigureWindowStyle','docked');
for i=497:500 
figure;imshow(NSDEM{i,2},[]);
end
%% 3 Croping and saving cropped pictures DEM as TIFF
load NSDEM_448.mat
for i=201:448 %NSDEM 
        I=NSDEM{i,2};
        %I=tiffcrop(D,[C(i,1),C(i,2),C(i,3),C(i,4)]);
        %imwrite(I,(sprintf('PSDEMtest%d.tif',i)));
        filename=sprintf(NSDEM{i,1});
        ext='.tiff'
        filename=strcat(filename,ext)
        saving_tiff(filename,I);
end