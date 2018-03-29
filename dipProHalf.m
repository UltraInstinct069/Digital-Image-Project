subplot(3,3,1);
imshow(imread('inputImage.png'));
title('Input Image');
I = im2double(rgb2gray(imread('inputImage.png')));

I1 = imgaussfilt(I,0.5);
subplot(3,3,2);
imshow(I1);
title('Gaussian filterd Image');
I2=imgradient(I1);
subplot(3,3,3);
imshow(I2)
title('Gradient image');

BW = im2bw(I2,0.4);

se = strel('diamond',2);
dilatedBW = imdilate(BW,se);
subplot(3,3,4);
imshow(dilatedBW);
title('First dilation');

se1=strel('disk',4);
 
 erodedBW = imerode(dilatedBW,se1);
 subplot(3,3,5)
 imshow(erodedBW);
 title('First erosion');
 
 sn=strel('disk',2);
 topht=imtophat(erodedBW,sn);
 %subplot(1,3,2);
 %imshow(topht);
 newimg=erodedBW-topht;
 subplot(3,3,6);
 imshow(newimg);
 title('Subtacted Image');
 
 
sd2=strel('disk',5);
dilatedBW2 = imdilate(newimg,sd2);
subplot(3,3,7) ;
imshow(dilatedBW2);
title('Closing Operation(Dilation)');

se2=strel('disk',6);
erodedBW2 = imerode(dilatedBW2,se2);
subplot(3,3,8);
imshow(erodedBW2 );
title('Closing Operation(Erosion)');

final = bwareaopen(erodedBW2 ,6000); 
subplot(3,3,9);
imshow(final);
