%{
DRILLHOLE CLASSIFIER (classify_dh_A.m) takes the patches generated through
the sliding window approach and assign an score and a classification label
to every patch being 1=drillhole and 2= NO drillhole. Inputs: sliding
window patches. Output: Excel file containing filename, label and scores. 3
of 5 scripts.
%}
%% 1 Function definition
function [M] = classify_dh_directory(trainedSvmModel,  threshfileName, testDir, outPutPrefix)
%NOV19:
%classify_dh_directory('~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/Model_HoG_train_SVM.mat', '~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/HoG_train_SVM_opt_mddl_thresh_auc.txt', '/Users/JV/Documents/Patches/FeatureEvaluationFramework/Testing/temporary2/', 'Testing/HoG.txt')
%classify_dh_directory('~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/Model_HoG_train_SVM.mat', '~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/HoG_train_SVM_opt_mddl_thresh_auc.txt', '/Users/JV/Documents/Patches/Sliding Window/Aut/', 'Testing/HoG.txt')
%classify_dh_directory_A('~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/Model_HoG_train_SVM.mat', '~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/HoG_train_SVM_opt_mddl_thresh_auc.txt', '/Users/JV/Documents/Patches/FeatureEvaluationFramework/At/', 'Testing/HoG.txt')
%DIC19
%classify_dh_directory_A('~JV/Documents/Patches/FeatureEvaluationFramework/EF_DEM/Model_DEM_HoG_train_SVM.mat', '~JV/Documents/Patches/FeatureEvaluationFramework/EF_DEM/DEM_HoG_train_SVM_opt_mddl_thresh_auc.txt', '/Users/JV/Documents/Patches/FeatureEvaluationFramework/SWDEM/', 'Testing/HoG.txt')
%% 2 Load model and threshold
SVMModel = load(trainedSvmModel)
SVMModel = SVMModel.SVMModel
thresh = dlmread(threshfileName)
%% 3 Classify patches and save them in an excel spreadsheet
l = dir(strcat(testDir, '/*.png'));
%l = dir(strcat(testDir, '/*.tiff'));%use this if the patches has .tiff extension
nodata = size(l);
for i=1:size(l)
        imName=strcat(testDir, l(i).name)
        [feat] = featuresHOG(imName);
        [label,score] = predict(SVMModel, feat.');%--TRY OUTSIDE LOOP
        imNames=convertCharsToStrings(imName);
        info(i,:)=[label imNames score];
        writematrix(info,'DEMpred.xls');
        %writematrix(info,'/Users/JV/Documents/Patches/A1_Training/Data_Augmentation/NS_FP/FP_imp2.xls');
end
    %sortFilenames_A;
%end

