%{
SLIDING WINDOW SCRIPT (SWMt_A.m) allows sliding window generation, sliding
window go through the whole picture and crop small patches which will be 
classifieed as drillhole or no drillhole. inputs: * Ortho image of the training area. outputs:
small patches (e.g. 300x300 pixels). Every patch will be classified later
as drillhole(1) or no drillhole(2) using Support Vector Machine. all the
patches are saved in a folder specified for the user. 2 of 5 scripts.
%}
%% 1 Function definition
function [A, r,c,nrows,ncols,ws,B,R] = SWMt_A(filename) 
%function [A, r,c,nrows,ncols,ws,B,R] = SWMt_aut(filename,s,f,min,max)
%filename:picture to be cropped using slide window like testing area
%, s:stride,
%f:factor,min-max:window sizes min and max
%[A,r,c,nrows,ncols,ws,B] = SWMt_aut('test.PNG',100,1,300,400)
%% 2 Sliding Window patch size
s=100;f=1;min=300;max=310;
A=imread(filename); 
ws=300*f;
%% 3 Patch coordinates to be cropped
nrows=floor(size(A,1)-ws);
ncols=floor(size(A,2)-ws);
r=(0:s:nrows)';
r=repmat(r,1,floor(ncols/100))';
r=r(:)';
r=transpose(r);
c=(0:s:ncols)';
 c(1)=[];
 c=repmat(c,floor(nrows/100)+1,1)';
 c=transpose(c);
R=[ones(10,1)];
sf=1;
i=1;
while R < max
    if R > max;
        R(i-1)=[];
        break
   
    end
    R(i,1)=sf * min;
    sf=sf+0.1;
    i=i+1;
end
R(i-1:size(R))=[];
R=transpose(R);
R=floor(R);
wss=repmat(R,size(r,1),1);
for i=1:size(R,2)
    wss=repmat(R,size(r,1),1);
    B=[r c wss(:,1) wss(:,1)];
end
save('B.mat','B')
%% 4 crop patches
 mkdir('At/test/') %Change folder name also in line 59: imwrite...
% for i=1:size(R,2);
%     B=[r c wss(:,i) wss(:,i)];
       for j=1:size(B,1) 
            I=imcrop(A,[B(j,2),B(j,1),B(j,3),B(j,4)]);
            imwrite(I,(sprintf('/Users/JV/Documents/Patches/FeatureEvaluationFramework/At/T%d.png',j)));%change folder name like in mkdir... line 47
       end
     %j=j+1
     %classify_dh_directory_A('~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/Model_HoG_train_SVM.mat', '~JV/Documents/Patches/FeatureEvaluationFramework/EF_CB/HoG_train_SVM_opt_mddl_thresh_auc.txt', '/Users/JV/Documents/Patches/FeatureEvaluationFramework/At/', 'Testing/HoG.txt')
 %classify_dh_directory_A;
end
