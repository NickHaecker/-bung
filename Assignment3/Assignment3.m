I = im2double(imread("cow.jpg"));


moving = (I);
fixed = (I);

[moving1,fixed1] = cpselect(moving,fixed,'Wait', true);

%tdata = fitgeotrans(movingPoints, fixedPoints, 'projective');

fixedPoints5 = [83.711678832116760,73.857664233576710;3.472153284671532e+02,46.120437956204455;2.939306569343065e+02,2.665583941605839e+02;31.156934306569326,2.140036496350365e+02];
fixedPoints5 = single(fixedPoints5);
movingPoints5 = [1,1; 3024,1; 3024,4032; 1,3024];


TFORM = fitgeotrans(moving1,fixed1,'projective');

TFORM1 = TFORM.T';
%I2G =im2gray(I);
%IT =  TFORM1 .* I2G
[X,Y,Z] = size(I);

newimg = ones(size(I));

for x = 1:X
    for y = 1:Y
        koor = TFORM1 * [x;y;1];
       koor = round(koor/koor(3));
        newimg(koor(1), koor(2), :) = I(x,y,:);
    end
end

imshow(newimg)