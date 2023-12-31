%% 01
clear
close all
clc

%% Matrix generation
r=round(0.01+(0.20-0.01).*rand(500,1),2)
rd=2*randi([0 1],500,1)-1

%% Brightness modification and save new pictures

for i=1:9

   if isfile(sprintf('C0%d_90.png',i))
I=imread(sprintf('C0%d_90.png',i));


if rd == 1
    R1 = r.*rd+1
else
    
    R1 = r.*rd+1
end

I=I.*R1(i,1);

imwrite(I,(sprintf('B2_C0%d_90.png',i)))


else
        i=i+1
    end
end