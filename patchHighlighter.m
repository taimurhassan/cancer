clc
clear all
close all

pn3 = 'C:\isbi\testingDataset\segmentation_results\';
pn = 'C:\isbi\testingDataset\images\';
pn2 = 'C:\isbi\testingDataset\gt\';

imagefiles = dir([pn '*.png']);

one = [255, 0, 0];
two = [0, 255, 0];
three = [0, 0, 255];
four = [255, 255, 0];
five = [255, 0, 255];
six=[0, 255, 255];

l1 = [207, 248, 132];
l2 = [183, 244, 155];
l3 = [144, 71, 111];
l4=[128,48,71];
l5= [50 158 75];
bg = [20 215 197];

nfiles = length(imagefiles);    

for ii=1:1:nfiles

    fn = imagefiles(ii).name;
    im3=imread([pn3 fn]);
    
%     fn3 = replace(fn,'.png','.tiff');
    img=imread([pn fn]);
    
    im = img;
    
    fn2 = fn;
    
    im3 = imresize(im3,[350 350],'bilinear');
    im = imresize(im,[350 350],'bilinear');
    
%     fn3 = replace(fn,'.tiff','_mask.tiff');
    
    gt = imread([pn2 fn]);
    gt = imresize(gt,[350 350],'bilinear');
    
    [r,c,ch] = size(im);
    
    [r,c,ch] = size(im);
    im5 = zeros(r,c);
    
    for i = 1:r
        for j = 1:c
            if im3(i,j,1) == l1(1) || im3(i,j,2) == l1(2) || im3(i,j,3) == l1(3)
                im5(i,j) = 1;
            elseif im3(i,j,1) == l2(1) || im3(i,j,2) == l2(2) || im3(i,j,3) == l2(3)
                im5(i,j) = 2;
            elseif im3(i,j,1) == l3(1) || im3(i,j,2) == l3(2) || im3(i,j,3) == l3(3)
                im5(i,j) = 3;
            elseif im3(i,j,1) == l4(1) || im3(i,j,2) == l4(2) || im3(i,j,3) == l4(3)
                im5(i,j) = 4;
            elseif im3(i,j,1) == l5(1) || im3(i,j,2) == l5(2) || im3(i,j,3) == l5(3)
                im5(i,j) = 5;
            end
        end
    end
    
    im4 = zeros(r,3*c,3);
                
    im4(:,1:c,1) = im(:,:,1);
    im4(:,1:c,2) = im(:,:,2);
    im4(:,1:c,3) = im(:,:,3);

    im4(:,c+1:2*c,1) = 36*gt(:,:);
    im4(:,c+1:2*c,2) = 36*gt(:,:);
    im4(:,c+1:2*c,3) = 36*gt(:,:);
    
    im4(:,2*c+1:end,1) = 36*im5(:,:);
    im4(:,2*c+1:end,2) = 36*im5(:,:);
    im4(:,2*c+1:end,3) = 36*im5(:,:);
    
    imwrite(mat2gray(im4),['C:\isbi\testingDataset\segmentation_results\newResults\' fn],'PNG');
    
end