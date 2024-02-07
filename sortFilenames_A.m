%{
This code sort the spreadsheet obtained in the previous step and assign the
"coordinates" of the patches for then draw the bounding boxes. 4 of 5
scripts.
%}
%%
%% 1 read excel with patches filenames and scores
opts=spreadsheetImportOptions('NumVariables',4);
T=readtable('DEMpred.xls',opts);
%% 2 convert table to array, column with filenames
TT=table2array(T(:,2));
%% 3 for loop to extract "sortable" values in the filenames
CH={}
for i=1:length(TT)
    CH(i,1) = extractBetween(TT(i,1),"T",".")
end
%% 4 convert to numbers
iwant=cellfun(@str2num,CH,'UniformOutput',false)
%% 5 sort
Col2=sortrows(iwant,1);
%% 6 add sorted column
T3=[T iwant]
Col3=sortrows(T3,5);
%% 7 read "coordinates"
 %B=readtable('coordinates_DEM_TestingArea.xlsx');%modify accordingly
%% 8 add "coordinates"
T4=[Col3 B]
%% 9 erase second column
T5=T4
T5(:,2)=[] %eliminate long filename including directory
%% 10 convert table to array
T513=T5(:,1:3);
T51=str2double(T513.Var1);
T52=str2double(T513.Var3);
T53=str2double(T513.Var4);
T5133=[T51 T52 T53];

T548=T5(:,4:8);
T5488=table2array(T548);

T6=[T5133 T5488];

%% 11 filter for label 2 (1=drillhole, 2=no drillhole)
ind1=T6(:,1)==1;
T7=T6(ind1,:);
%% 12 save file
save('T7_DEM.mat','T7');%modify accordingly %detected drillholes
%% 
draw_bboxes_A(testImage);