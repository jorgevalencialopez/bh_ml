%{
SLIDING WINDOW SCRIPT (SWMt_A.m) allows sliding window generation, sliding
window go through the whole picture and crop small patches useful for
drillhole detection. inputs: * Ortho image of the training area. outputs:
small patches (e.g. 300x300 pixels). Every patch will be classified later
as drillhole(1) or no drillhole(2) using Support Vector Machine. all the
patches are saved in a folder specified for the user. 2 of 5 scripts.
%}
%%
function [A, r,c,nrows,ncols,ws,B,R] = SWMt_aut(filename) 
%function [A, r,c,nrows,ncols,ws,B,R] = SWMt_aut(filename,s,f,min,max)
%filename:picture to be cropped using slide window like testing area
%, s:stride,
%f:factor,min-max:window sizes min and max
%[A,r,c,nrows,ncols,ws,B] = SWMt_aut('test.PNG',100,1,300,400)
%
s=100;f=1;min=300;max=310;
A=imread(filename); 
ws=300*f;
% 1 row values generation
nrows=floor(size(A,1)-ws);
ncols=floor(size(A,2)-ws);
r=(0:s:nrows)';
r=repmat(r,1,floor(ncols/100))';
r=r(:)';
r=transpose(r);
% 2 column values generation
 c=(0:s:ncols)';
 c(1)=[];
 c=repmat(c,floor(nrows/100)+1,1)';
 c=transpose(c);
%
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
 % 3 window size
wss=repmat(R,size(r,1),1);
% end
% 4 final matrix with coordinates and window size
for i=1:size(R,2)
    wss=repmat(R,size(r,1),1);
    B=[r c wss(:,1) wss(:,1)];
end
save('B.mat','B')
% 5 crop and save patches
 %mkdir('SWDEM/') %Change folder name also in line 52: imwrite...
% for i=1:size(R,2);
%     B=[r c wss(:,i) wss(:,i)];
       for j=1:size(B,1) 
            I=imcrop(A,[B(j,2),B(j,1),B(j,3),B(j,4)]);
            %imwrite(I,(sprintf('/Users/JV/Documents/Patches/FeatureEvaluationFramework/SWDEM/T%d.png',j)));%change folder name like in mkdir... line 47
            filename=sprintf('SWDEM/T%d.tiff',j);
            saving_tiff(filename,I);
       end
end
