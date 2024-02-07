%% 1) Define function inputs: Directories for PS, NS, Feature Vector, Filename Feature Vector
function makeFeatures(imageDirP1, ImageDirN1, outDir, name)
%% 2) Run vlfeat
%{
creates features vector
function makeFeatures(imageDirP1, outDir, name)---only positive samples
to use the patches of the sliding window
makeFeatures('PS_DEM', 'NS_DEM','EF_DEM/', 'traingHogDEM')
%}
run vlfeat-0.9.21/toolbox/vl_setup
%% 3) List of positive samples patches 
%{
run ~/JV/Documents/Patches/vlfeat-0.9.21/toolbox/vl_setup
run ~/vlfeat_test/vlfeat-0.9.21/toolbox/vl_setup
%}
l = dir(strcat(imageDirP1, '/*.png'));
nodata = size(l);
%% 4) HoG Features Extraction PS
%{
    %imName=strcat(imageDirP1, 'p (', num2str(i),').png');
    %[f20] = featuresRawIntensity(imName);
%}
for i=1:size(l)
    imName=strcat(imageDirP1, '/', l(i).name);
    [f20] = featuresHOG(imName);
    data20(i,:)= f20;
    label(i)=1;
    i
end
%% 5) List of negative samples patches
l = dir(strcat(ImageDirN1, '/*.png'));
%% 6 HoG Features Extraction NS
for i=1:size(l)
    %{
    imName = strcat(ImageDirN1, 'n (', num2str(i),').png');
    [f20] = featuresRawIntensity(imName);
    %}
    imName=strcat(ImageDirN1, '/' ,l(i).name);
    [f20] = featuresHOG(imName);
    label(i + nodata(1))=2;
    data20(i + nodata(1),:)= f20;
    i + nodata;
end
%% 7 Final features vector concatenation and saving
makeTextFormat(data20, label, strcat(outDir, name, '.txt'));