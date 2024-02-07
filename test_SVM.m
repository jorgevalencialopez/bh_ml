function test_SVM(SVMModel, thresh, testDir, outprefix)%, outprefix) %, outDirP, outDirN)

tofind = strcat(testDir, '*.png')
l = ls(tofind)
l = strsplit(l, ' ')

run ~/Desktop/code/vlfeat-0.9.20/toolbox/vl_setup

for i=1:size(l,2)-1
    imName=strcat(testDir, '/SW (', num2str(i),').png');
    [f20] = featuresHOG(char(imName));
    data20(i,:)= f20;
    label(i)=1;
    %size(l)    
    %testDir
    i
end

makeTextFormat(data20, label, strcat(testDir, 'features_', outprefix, '.txt'));


dataTest= dlmread(strcat(testDir, 'features_', outprefix, '.txt'));
dSize = size(dataTest);
groupsTest = dataTest(:, dSize(2));
dataTest = dataTest(:, 1:dSize(2)-1);
[label,Score] = predict(SVMModel,dataTest);


labelo = updateLabel(label, Score, thresh(1));

dlmwrite(strcat(testDir, outprefix, '.txt'), labelo)

end
