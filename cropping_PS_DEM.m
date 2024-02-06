%% 1 Load coordinates PS 
load C.mat %coordinates labeled drillholes
load D.mat %DEM Training Area 
load O.mat %ORTHO Training Area 
%% 2 Croping and saving cropped pictures first for Ortho
for i=1:length(C) 
        I=imcrop(O,[C(i,1),C(i,2),C(i,3),C(i,4)]);
        imwrite(I,(sprintf('PS%d.png',i)))
end
%% 3 Croping and saving cropped pictures DEM as TIFF
for i=1:length(C) 
        I=imcrop(D,[C(i,1),C(i,2),C(i,3),C(i,4)]);
        %I=tiffcrop(D,[C(i,1),C(i,2),C(i,3),C(i,4)]);
        %imwrite(I,(sprintf('PSDEMtest%d.tif',i)));
        filename=sprintf('PSDEM%d.tiff',i);
        saving_tiff(filename,I);
end
%% 4 saving augmented PS as tiff from PSDEM
%load PSDEM.mat
for i=1:length(PSDEM) %NSDEM 
        I=PSDEM{i,2};
        %I=tiffcrop(D,[C(i,1),C(i,2),C(i,3),C(i,4)]);
        %imwrite(I,(sprintf('PSDEMtest%d.tif',i)));
        filename=sprintf(PSDEM{i,1});
        ext='.tiff'
        filename=strcat(filename,ext)
        saving_tiff(filename,I);
end
%% 5 Croping and saving Training Area DEM as TIFF
        I=imcrop(J,[0, 2044, 8097, 10680]);
        filename='DEM_C_TrainingArea.tiff';
        saving_tiff(filename,I);
%% 6 Croping and saving Testing Area DEM as TIFF
        I=imcrop(J,[0, 0, 8097, 2045]);
        filename='DEM_C_TestingArea.tiff';
        saving_tiff(filename,I);