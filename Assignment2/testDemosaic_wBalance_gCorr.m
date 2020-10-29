close all;
rawImg = (imread('test.pgm'));

dImg = demosaic(im2double(rawImg));
imshow(dImg);
wdImg = wBalance(dImg);%output is again double
figure;imshow(wdImg);

gC=gammaCorrect(wdImg);
gImg = im2uint8(gC);
figure;imshow(gImg);
gEq = myhistEq(gImg);
figure; imshow(gEq);






