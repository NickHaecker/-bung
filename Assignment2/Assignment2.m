%Code von Sebastian Pfeiffer, Nick Häcker und Raphael Hild
%09.11.2020

clear

%----------------------------------------%

%Demosaicing und Interpolation

I = imread('test.pgm');

Mask_Red = [1 0 1; 0 0 0; 0 1 0] * 1/4;
Mask_Green = [0 1 0; 1 0 1; 0 1 0] * 1/4;
Mask_Blue = [0 0 0; 0 1 0; 0 0 0] * 1/4;

%red
y(1:2:height(I), 1:2:width(I), 1) = I(1:2:height(I), 1:2:width(I),1);

%green
y(1:2:height(I), 2:2:width(I), 2) = I(1:2:height(I), 2:2:width(I),1);
y(2:2:height(I), 1:2:width(I), 2) = I(2:2:height(I), 1:2:width(I),1);

%blue
y(2:2:height(I), 2:2:width(I), 3) = I(2:2:height(I), 2:2:width(I),1);


Red = imfilter(y(:,:,1), Mask_Red);
Green = imfilter(y(:,:,2), Mask_Green);
Blue = imfilter(y(:,:,3), Mask_Blue);

y(:,:,1) = y(:,:,1) + Red;
y(:,:,2) = y(:,:,2) + Green;
y(:,:,3) = y(:,:,3) + Blue;

DemosaicedPicture = cat(3, y(1:2:height(I), 1:2:width(I), 1), y(1:2:height(I), 2:2:width(I), 2), y(2:2:height(I), 2:2:width(I), 3));
imshow(DemosaicedPicture);


%----------------------------------------%

%White Balancing

DemosaicedPicture = im2double(DemosaicedPicture);

p1 = reshape(DemosaicedPicture(854,933, :),1,3);
p2 = reshape(DemosaicedPicture(862,947, :),1,3);
p3 = reshape(DemosaicedPicture(869,963, :),1,3);
p4 = reshape(DemosaicedPicture(877,981, :),1,3);
p5 = reshape(DemosaicedPicture(882,997, :),1,3);
p6 = reshape(DemosaicedPicture(890,1009, :),1,3);
p7 = reshape(DemosaicedPicture(898,1029, :),1,3);
p8 = reshape(DemosaicedPicture(904,1053, :),1,3);

pges = (p1+p2+p3+p4+p5+p6+p7+p8)/8;

INewred= DemosaicedPicture(:,:,1)*(1/pges(1));
INewgreen= DemosaicedPicture(:,:,2)*(1/pges(2));
INewblue= DemosaicedPicture(:,:,3)*(1/pges(3));

INew = cat(3,INewred,INewgreen,INewblue);

imshow(INew);


%----------------------------------------%

%Gamma Correction

Igrey = rgb2gray(INew);

imshow(Igrey);

Igrey = Igrey.^1/2.2;

ratio1 = INew(:,:,1)./ Igrey(:,:,1);
ratio2 = INew(:,:,2)./ Igrey(:,:,1);
ratio3 = INew(:,:,3)./ Igrey(:,:,1);


ratio1 = ratio1.*Igrey(:,:,1);
ratio2 = ratio2.*Igrey(:,:,1);
ratio3 = ratio3.*Igrey(:,:,1);

Igrey2 = cat(3,ratio1,ratio2,ratio3);

montage({INew, Igrey2});


%----------------------------------------%

%Histogram Equalization

%histogram(Igrey)
I2nd = imread('uneqImg.jpg');

%%histogram(I2nd)