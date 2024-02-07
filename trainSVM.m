%% 1 Define function inputs:
%trainFile:Features Vector,saveDir:Where the SVM will be saved
%saveName:filename SVM Model
%e.g. trainSVM('EF/HoG.txt','EF/','HoG_train_SVM')
function trainSVM(trainFile, saveDir, saveName)
%% 2 Import features vector as matrix 
dataTrain = dlmread(trainFile);%dlmread--->readmatrix
dSize = size(dataTrain);
%% 3 Get classes train set (PS=1 and NS=2)
groupsTrain = dataTrain(:, dSize(2));
%% 4 Redefine dataTrain (delete last column with classes)
dataTrain= dataTrain(:, 1:(dSize(2) -1) );
%% 5 Train SVM Model
SVMModel = fitcsvm(dataTrain,groupsTrain);
%% 6 Emulate dataTrain as dataTest
dataTest= dlmread(trainFile);
%% 7 Get classes test set (PS=1 and NS=2)
groupsTest = dataTest(:, dSize(2));
%% 8 Data test redefinition (1 less column)
dataTest = dataTest(:, 1:dSize(2)-1);
%% 9 SVM Predictions
[label,Score] = predict(SVMModel,dataTest);
%% 10 ROC curve (Receiver operating characteristic curve)
[x1,y1,T,auc1, optroc] = perfcurve(groupsTest,Score(:,1),1);
% x1: x-coordinates performance curve.
% y1: y-coordinates performance curve.
% T: Thresholds on classifier scores.
% auc1: Area under the curve.
% optroc: Optimal operating point of the ROC curve
%save(plotSavename, 'plotVaraibles');
hold on; plot(x1,y1)
plot(optroc(1),optroc(2),'ro')
%% 11 Calculate threshOpt, thresh
coords = [x1 y1];
index = find(ismember(coords, optroc, 'rows'));
coords(index, :);
threshOpt = T(index);

[mi, miI] = min(Score(:,1));
[ma, maI] = max(Score(:,1));

range = (ma - mi)/2;

if(range < ma)
    Score(:, 1) = Score(:, 1) - (ma - range);
    thresh = ma - range;
else
    Score(:, 1) = Score(:, 1) + (range-ma);
    thresh = ma - range;
end
%% 12 Save SVM training model
    mName = strcat (saveDir , '/Model_', saveName);
    save(mName, 'SVMModel', '-v7.3');
%% 13 Save threshOpt, thresh, auc1
    threshSaveName = strcat (saveDir , '/', saveName,'_opt_mddl_thresh_auc', '.txt');
    data = [threshOpt; thresh; auc1];
    dlmwrite(threshSaveName, data);
end