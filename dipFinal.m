I = im2double(rgb2gray(imread('IP1.png')));

subplot(3,3,1);
imshow(imread('IP1.png'));
title('Input Image');

subplot(3,3,2);
I1 = imgaussfilt(I,0.5);
imshow(I1);
title('Gaussian filterd Image');

subplot(3,3,3);
I2=imgradient(I1);
imshow(I2);
title('Gradient image');

subplot(3,3,4);
BW = im2bw(I2,0.4);
imshow(BW);
title('Coverting to binary image using threshold');

se = strel('diamond',2);
dilatedBW = imdilate(BW,se);


 se1=strel('disk',4);
 
 erodedBW = imerode(dilatedBW,se1);
 
 
 
 sn=strel('disk',2);
 topht=imtophat(erodedBW,sn);
 newimg=erodedBW-topht;
 
 subplot(3,3,5);
 imshow(newimg);
 title('After First round of dilation and erosion');
 
sd2=strel('disk',5);
dilatedBW2 = imdilate(newimg,sd2);

se2=strel('disk',5);
erodedBW2 = imerode(dilatedBW2,se2);


sn=strel('octagon',3);
topht=imtophat(erodedBW2,sn);


newimg2=erodedBW2-topht;
 
 subplot(3,3,6);
 imshow(newimg2);
title('After second round of dilation and erosion');

final = bwareaopen(newimg2 ,4000); 

subplot(3,3,7);
imshow(final);
title('Removing small regions');

[B,L] = bwboundaries(final,'noholes');
BB=label2rgb(L, @jet, [.5 .5 .5]);

subplot(3,3,8);
imshow(label2rgb(L, @jet, [1 1 1]));
hold on
title('Coloring the regions');
%figure;
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

subplot(3,3,9);
imshowpair(I,BB);
title('Output image');

[row,col]=size(final);
totalSize=row*col;
WhiteReg=sum(final(:));
urbanArea=(WhiteReg*100)/totalSize;
fprintf('Urban area: %d percent',urbanArea);
