function[]=saving_tiff(filename,I)
% create object with picture properties from DEM
obj = Tiff('DEM_C_10362x15632_6.24mm_pix.tif','r');
%filename='DEM_C_TrainingArea.tiff'
t = Tiff(filename,'w');%filename cropped area
a=size(I,1);%cropped area width
b=size(I,2);%cropped area height
%picture properties from obj=DEM
setTag(t,'Photometric',getTag(obj, 'Photometric'));
setTag(t,'Compression',getTag(obj, 'Compression'));
setTag(t,'BitsPerSample',getTag(obj, 'BitsPerSample'));
setTag(t,'SamplesPerPixel',getTag(obj, 'SamplesPerPixel'));
setTag(t,'SampleFormat',getTag(obj, 'SampleFormat'));
setTag(t,'ImageLength',a);%replace for corresponding value
setTag(t,'ImageWidth',b);%replace for corresponding value
setTag(t,'TileLength',getTag(obj, 'TileLength'));
setTag(t,'TileWidth',getTag(obj, 'TileWidth'));
setTag(t,'PlanarConfiguration',getTag(obj, 'PlanarConfiguration'));

write(t,I); %save image
close(t);
end