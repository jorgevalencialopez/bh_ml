%1 read and show picture
   
for i=1
    if isfile(sprintf('C%d.png',i)) 
T=imread(sprintf('C%d.png',i));

%2 rotate 90 degrees and save picture
R1=imrotate(T,90);
imwrite(R1,(sprintf('C%d_90.png',i)))

%2 rotate 180 degrees and save picture
R2=imrotate(T,180);
imwrite(R2,(sprintf('C%d_180.png',i)))
%imwrite(R2,(sprintf('T1%02d_180.png',i)))

%2 rotate 270 degrees and save picture
R3=imrotate(T,270);
imwrite(R3,(sprintf('C%d_270.png',i)))
    else
        i=i+1
    end
end

