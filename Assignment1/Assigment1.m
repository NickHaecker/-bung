bsp_image = imread('Eclectus_roratus-20030511.jpg');
assignment_image = im2double(bsp_image);
subplot(3,3,2);
imshow(assignment_image);
title('Original Image')

assignment_image_2_added_brightness = assignment_image+ 0.2;
%montage({assignment_image,assignment_image_2_added_brightness})
subplot(3,3,4);
imshow(assignment_image_2_added_brightness)
title('added britghness')


redChannel = assignment_image(:,:,1)*0.8;
greenChannel = assignment_image(:,:,2) *0.2;
blueChannel = assignment_image(:,:,3)*0.1;
newImage = cat(3, redChannel, greenChannel, blueChannel);
subplot(3,3,5);
imshow(newImage)
title('multiplicated britghness')
%montage({assignment_im,newImage})


redChannel_1 = assignment_image(:,:,1)*0.3;
greenChannel_1 = assignment_image(:,:,2) *0.6;
blueChannel_1 = assignment_image(:,:,3)*0.1;
newImage_1 = 0.2126 * redChannel_1 + 0.7152 * greenChannel_1 + 0.0722 * blueChannel_1;
newImage_1 = newImage_1 / max(newImage_1(:));
subplot(3,3,6);
imshow(newImage_1);
title('greyed Image')
%montage({assignment_image,newImage})



start_width = assignment_image(1,:,:) / 100 * 80;
end_width = assignment_image(1,:,:) / 100 * 80 + 10;

start_height = assignment_image(:,1,:) / 100 * 20;
end_height = assignment_image(:,^1,:) / 100 * 20 + 10;

%start_width =  assignment_image(: / 100) * 80,:,:);
%start_height = ( assignment_image(:,1 ,:)/ 100 ) * 20;
%end_width = ( assignment_image(1,:,:) / 100 ) * 80 + 10;
%end_height = ( assignment_image(:,1 ,:)/ 100 ) * 20 + 10;

width = end_width - start_width;
r_width = width(:,:,1)*0.3;
g_width = width(:,:,2)*0.1;
b_width = width(:,:,3)*0.6;
width_img = r_width+g_width+b_width;
new_width = width_img / max(width_img(:));

height= end_height - start_height;
r_height = height(:,:,1)*0.3;
g_height = height(:,:,2)*0.1;
b_height = height(:,:,3)*0.6;
height_img = r_height+ g_height+ b_height;
new_height = height_img / max(height_img(:));

square_image= assignment_image + new_width + new_height;
square_image = square_image / 3;
subplot(3,3,7);
imshow(square_image);
title('blubb Image')
whos 