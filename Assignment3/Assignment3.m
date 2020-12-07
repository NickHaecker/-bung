I = imread('Cow.jpg');

I2 = im2double(I);
I3 = I2;

%imshow(I2);
%moving = I2;
%fixed = I2;

%cpselect(moving, fixed)




%cpselect(moving, fixed)
%fixedPoints = single(fixedPoints);
%fixedPoints1 = single(fixedPoints1);
%fixedPoints2 = single(fixedPoints2);
%fixedPoints3 = single(fixedPoints3);
%movingPoints = single(fixedPoints);
%movingPoints1 = single(fixedPoints1);
%movingPoints2 = single(fixedPoints2);
%movingPoints3 = single(fixedPoints3);

%fixedtransform = [fixedPoints ; fixedPoints1 ; fixedPoints2 ; fixedPoints3];
%movedtransform = [movingPoints; movingPoints1; movingPoints2; movingPoints3];

%TFORM = fitgeotrans(movingPoints4, fixedPoints4,'projective');

%TFORM = cp2tform(moving(:,:,1): moving(:,:,2),fixed(:,:,1): fixed(:,:,2),'projective')

%TFORM1 = TFORM.T'

%I4 = I2 .* TFORM;
%I4= I2(:,:,1)./I2(:,:,3);
%I5= I2(:,:,2)./I2(:,:,3);
%I9= I2(:,:,3)./I2(:,:,3);

%I6 = cat(2, I4, I5, I9);

%I8 = I4 + I5 + I9;

%I7= I6 .* TFORM1;






%u = movingPoints4(:,:,1) ./ movingPoints4(:,:,3)
%v = movingPoints4(:,:,2) ./ movingPoints4(:,:,3)

%Tinv = TFORM.tdata.Tinv;
%movingPoints4 = fixedPoints4 .* Tinv;

%I10 = I2 .* Tinv;



%I000 = I2(:,:,1);
%I10 = I2(:,:,1).* TFORM1;
%I11 = I2(:,:,2).* TFORM1;
%I12 = I2(:,:,3).* TFORM1;
%I6 = cat(3, I10, I11, I12);


fixedPoints5 = [83.711678832116760,73.857664233576710;3.472153284671532e+02,46.120437956204455;2.939306569343065e+02,2.665583941605839e+02;31.156934306569326,2.140036496350365e+02];
fixedPoints5 = single(fixedPoints5);
movingPoints5 = [1,1; 400,1; 400,300; 1,300];
%movingPoints5 = [1,1; 300,1; 300,400; 1,400];

TFORM = fitgeotrans(movingPoints5, fixedPoints5,'projective');


TFORM = TFORM.T';
TFORM1 = inv(TFORM);
TFORM2 = round(TFORM1);
%Newimg = I2(1:300,1:400,:) .* TFORM;


%Newimg = TFORM * I2(1:300,1:400,:);


[X,Y,Z] = size(I2);

%newimg = zeros(size(I2));

%imshow(newimg)

for y = 1:X
for x = 1:Y
coordinate1 = TFORM * [x;y;1];
coordinate1= round(coordinate1/coordinate1(3)-);
newimg(coordinate1(2), coordinate1(1),:) = I2(y,x,:);


end
end

imshow(newimg);


%for y = 1:Y
% for x = 1:X

%if newimg(x,y,1) == 0 && newimg(x,y,2) == 0 && newimg(x,y,3) == 0 && x>1 && y>1 && x<300 && y<400
% newimg(x,y,1) = (newimg(x-1,y-1,1)+ newimg(x+1,y+1,1) + newimg(x+1,y-1,1)+ newimg(x-1,y+1,1) + newimg(x-1,y,1)+ newimg(x+1,y,1) + newimg(x,y-1,1)+ newimg(x,y+1,1))/8;
% newimg(x,y,2) = (newimg(x-1,y-1,2)+ newimg(x+1,y+1,2) + newimg(x+1,y-1,2)+ newimg(x-1,y+1,2)+ newimg(x-1,y,2)+ newimg(x+1,y,2) + newimg(x,y-1,2)+ newimg(x,y+1,2))/8;
% newimg(x,y,3) = (newimg(x-1,y-1,3)+ newimg(x+1,y+1,3) + newimg(x+1,y-1,3)+ newimg(x-1,y+1,3)+ newimg(x-1,y,3)+ newimg(x+1,y,3) + newimg(x,y-1,3)+ newimg(x,y+1,3))/8;
%end



% end
%end

%imshow(newimg);










%imshow(img)
%fixedPoints