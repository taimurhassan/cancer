clc
clear all
close all

pn = 'C:\Users\Windows\Downloads\Data_P_011\';
pn2 = 'C:\Users\Windows\Downloads\train_label_masks\';

imagefiles = dir([pn '*.tiff']);

one = [255, 0, 0];
two = [0, 255, 0];
three = [0, 0, 255];
four = [255, 255, 0];
five = [255, 0, 255];
six=[0, 255, 255];

nfiles = length(imagefiles);    

for ii=1:1:nfiles

    fn = imagefiles(ii).name;
    img=imread([pn fn]);
    im = img;
    
    fn2 = fn;
    
    fn3 = replace(fn,'.tiff','_mask.tiff');
    
    gt = imread([pn2 fn3]);
   
    [r,c,ch] = size(im);
    
    xstep = 350; %floor((r-1)/350);
    ystep = 350; %floor((c-1)/350);
    
	fn = replace(fn,'.tiff','_patch_');
    patches = {};
    index = 1;
    for i = 1:xstep:r
        for j = 1:ystep:c
            if i+xstep-1 <= r && j+ystep-1 <= c
                im2 = img(i:i+xstep-1,j:j+ystep-1,:);
                gt2 = gt(i:i+xstep-1,j:j+ystep-1,:);
                imshow(im2);
                
                if sum(sum(sum(gt2))) == 0 %discarding background patches
                    continue;
                end
                
                im3 = generateAnnotatedPatch(gt2,im2);
                
                [r1,c1,ch] = size(im3);
                
                im4 = zeros(r1,2*c1,3);
                
                im4(:,1:c1,1) = im2(:,:,1);
                im4(:,1:c1,2) = im2(:,:,2);
                im4(:,1:c1,3) = im2(:,:,3);

                im4(:,c1+1:end,1) = im3(:,:,1);
                im4(:,c1+1:end,2) = im3(:,:,2);
                im4(:,c1+1:end,3) = im3(:,:,3);

%                 imwrite(mat2gray(im4),[pn 'results\patchesCombined\' fn num2str(index) '.jpg'],'JPEG');
%                 imwrite(mat2gray(im2),[pn 'results\patches\' fn num2str(index) '.jpg'],'JPEG');
%                 imwrite(mat2gray(im3),[pn 'results\annotated\' fn num2str(index) '.jpg'],'JPEG');
                
                patches{index} = im2;
                
                im2 = imresize(im2,[576 768],'bilinear');
                gt2 = imresize(gt2,[576 768],'bilinear');
                imwrite(im2,[pn 'results\images\' fn num2str(index) '.png'],'PNG');
                imwrite(gt2(:,:,1),[pn 'results\gt\' fn num2str(index) '.png'],'PNG');
                imwrite(63*gt2(:,:,1),[pn 'results\gt2\' fn num2str(index) '.png'],'PNG');
                
                index = index + 1;
            end
        end
    end
end

function [img]=generateAnnotatedPatch(gt,img)
    one = [255, 0, 0];
    two = [0, 255, 0];
    three = [0, 0, 255];
    four = [255, 255, 0];
    five = [255, 0, 255];
    
    gtr = gt(:,:,1);
    gtg = gt(:,:,2);
    gtb = gt(:,:,3);
    
    [r,c,ch] = size(img);
    mask = zeros(r,c,ch);
    
    for i = 1:r
        for j = 1:c
            if gtr(i,j) == 1 || gtg(i,j) == 1 || gtb(i,j) == 1
                img(i,j,1) = one(1);
                img(i,j,2) = one(2);
                img(i,j,3) = one(3);
                
                mask(i,j,1) = one(1);
                mask(i,j,2) = one(2);
                mask(i,j,3) = one(3);
            elseif gtr(i,j) == 2 || gtg(i,j) == 2 || gtb(i,j) == 2
                img(i,j,1) = two(1);
                img(i,j,2) = two(2);
                img(i,j,3) = two(3);
                
                mask(i,j,1) = two(1);
                mask(i,j,2) = two(2);
                mask(i,j,3) = two(3);
            elseif gtr(i,j) == 3 || gtg(i,j) == 3 || gtb(i,j) == 3
                img(i,j,1) = three(1);
                img(i,j,2) = three(2);
                img(i,j,3) = three(3);
                
                mask(i,j,1) = three(1);
                mask(i,j,2) = three(2);
                mask(i,j,3) = three(3);
            elseif gtr(i,j) == 4 || gtg(i,j) == 4 || gtb(i,j) == 4
                img(i,j,1) = four(1);
                img(i,j,2) = four(2);
                img(i,j,3) = four(3);
                
                mask(i,j,1) = four(1);
                mask(i,j,2) = four(2);
                mask(i,j,3) = four(3);
            elseif gtr(i,j) == 5 || gtg(i,j) == 5 || gtb(i,j) == 5
                img(i,j,1) = five(1);
                img(i,j,2) = five(2);
                img(i,j,3) = five(3);
                
                mask(i,j,1) = five(1);
                mask(i,j,2) = five(2);
                mask(i,j,3) = five(3);
            end
        end
    end
end