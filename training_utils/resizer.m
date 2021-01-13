clc
clear all
close all

pn = 'images\'; % create images folder in the same directory. Also create another folder with the name 'Resized' in which the resized images will be saved 

imagefiles = dir([pn '*.png']);

nfiles = length(imagefiles);    

for ii=1:1:nfiles

    fn = imagefiles(ii).name;
    img=imread([pn fn]);
    
    if ismatrix(img) == false
        img = img(:,:,2);
    end
    
%     if(size(img,3) ~= 3)
%         img = cat(3,img,img,img);
%     end

    img = imresize(img,[576 768],'bilinear');
    fn = replace(fn,'.png','');
    imwrite(img,[pn 'Resized\' fn '.png'],'PNG');

end
