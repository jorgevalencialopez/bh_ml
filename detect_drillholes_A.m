%{
STEPS FOR TESTING SVM This script and associated scripts contains all the
necessary steps for test trained SVM (Support Vector Machine) models.
Inputs: - SVM model. - Testing picture. Outputs: - Bounding boxes with
detected drillholes. To run the script, write the following in Command
Window: detect_drillholes_A(trainedSvmModel, testImage) e.g:
detect_drillholes_A('Model_HoG_train_SVM.mat', 'TestingArea.png') 1 of 5
scripts.
%}
%%
function[]=detect_drillholes_A(trainedSvmModel,testImage)
SWMt_A(testImage);
classify_dh_directory_A(trainedSvmModel, '~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/HoG_train_SVM_opt_mddl_thresh_auc.txt','/Users/JV/Documents/Patches/FeatureEvaluationFramework/At/', 'Testing/HoG.txt');
draw_bboxes_A(testImage);
end