bsp_image = imread('Eclectus_roratus-20030511.jpg');
assignment_image = im2double(bsp_image);
%subplot(3,3,2);
%imshow(assignment_image);
%title('Original Image')

assignment_image_2_added_brightness = assignment_image+ 0.2;
%montage({assignment_image,assignment_image_2_added_brightness})
%subplot(3,3,4);
%imshow(assignment_image_2_added_brightness)
%title('added britghness')


redChannel = assignment_image(:,:,1)*0.8;
greenChannel = assignment_image(:,:,2) *0.2;
blueChannel = assignment_image(:,:,3)*0.1;
newImage = cat(3, redChannel, greenChannel, blueChannel);
%subplot(3,3,5);
%imshow(newImage)
%title('multiplicated britghness')
%montage({assignment_im,newImage})


redChannel_1 = assignment_image(:,:,1)*0.3;
greenChannel_1 = assignment_image(:,:,2) *0.6;
blueChannel_1 = assignment_image(:,:,3)*0.1;
newImage_1 = 0.2126 * redChannel_1 + 0.7152 * greenChannel_1 + 0.0722 * blueChannel_1;
newImage_1 = newImage_1 / max(newImage_1(:));
%subplot(3,3,6);
%imshow(newImage_1);
%title('greyed Image')
%montage({assignment_image,newImage})



height_ = size(assignment_image, 1)*0.2;
width_ = size(assignment_image,2)*0.8;
square_image = insertShape(assignment_image, 'FilledRectangle', [width_, height_, 10, 10], 'Color', 'white', 'Opacity', 1);
%subplot(3,3,7);
%imshow(square_image);
%title('Sliced Image')

Image_with_horizontical_line = assignment_image;
Image_with_horizontical_line(415, 1:975, 1) = 1;
Image_with_horizontical_line(415, 1:975, 2) = 1;
Image_with_horizontical_line(415, 1:975, 3) = 1;
%subplot(3,3,8);
%imshow(Image_with_horizontical_line);
%title('Horizonticle line')


Image_with_verticle_line = assignment_image;
Image_with_verticle_line(1:553, 244, 1)=1;
Image_with_verticle_line(1:553,244,2)=1;
Image_with_verticle_line(1:553,244,3)=1;

%subplot(3,3,9);
%imshow(Image_with_verticle_line);
%title('Vertical line')


whos 