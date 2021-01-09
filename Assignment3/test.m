%Abgabe Assignment 3 - Gruppe 2
%Stand: 08.01.2020

close all;
clear(); 

imageFixed = imread("IMG_0703.jpg");
imageMoving = imread("IMG_0702.jpg");

movingPoints = [236,93;611,375;611,520;234,585];
fixedPoints = [705,78;1095,332;1103,487;719,547];

%----------------------%

firstConnection = [
    movingPoints(1, 1), movingPoints(1, 2), 1, 0, 0, 0, -fixedPoints(1, 1) * movingPoints(1, 1), -fixedPoints(1, 1) * movingPoints(1, 2), -fixedPoints(1, 1);
    0, 0, 0, movingPoints(1, 1), movingPoints(1, 2), 1, -fixedPoints(1, 2) * movingPoints(1, 1), -fixedPoints(1, 2) * movingPoints(1, 2), -fixedPoints(1, 2)
];

secondConnection = [
    movingPoints(2, 1), movingPoints(2, 2), 1, 0, 0, 0, -fixedPoints(2, 1) * movingPoints(2, 1), -fixedPoints(2, 1) * movingPoints(2, 2), -fixedPoints(2, 1);
    0, 0, 0, movingPoints(2, 1), movingPoints(2, 2), 1, -fixedPoints(2, 2) * movingPoints(2, 1), -fixedPoints(2, 2) * movingPoints(2, 2), -fixedPoints(2, 2)
];

thirdConnection = [
    movingPoints(3, 1), movingPoints(3, 2), 1, 0, 0, 0, -fixedPoints(3, 1) * movingPoints(3, 1), -fixedPoints(3, 1) * movingPoints(3, 2), -fixedPoints(3, 1);
    0, 0, 0, movingPoints(3, 1), movingPoints(3, 2), 1, -fixedPoints(3, 2) * movingPoints(3, 1), -fixedPoints(3, 2) * movingPoints(3, 2), -fixedPoints(3, 2)
];

fourthConnection = [
    movingPoints(4, 1), movingPoints(4, 2), 1, 0, 0, 0, -fixedPoints(4, 1) * movingPoints(4, 1), -fixedPoints(4, 1) * movingPoints(4, 2), -fixedPoints(4, 1);
    0, 0, 0, movingPoints(4, 1), movingPoints(4, 2), 1, -fixedPoints(4, 2) * movingPoints(4, 1), -fixedPoints(4, 2) * movingPoints(4, 2), -fixedPoints(4, 2)
];

A = [firstConnection; secondConnection; thirdConnection; fourthConnection];

%----------------------%

[U, S, V] = svd(A,0);

H = reshape(V(:, 9), [3, 3]);
H = H';
[rows, cols,Z] = size(imageMoving);

p1 = H * [1; 1; 1];
p1 = round(p1 / p1(3));

p2 = H * [cols; 1; 1];
p2 = round(p2 / p2(3));

p3 = H * [cols; rows; 1];
p3 = round(p3 / p3(3));

p4 = H * [1; rows; 1];
p4 = round(p4 / p4(3));

%----------------------%

initMinimumRow = 1;
initMinimumCol = 1;
initMaximumRow = rows;
initMaximumCol = cols;

minimumRow = min([initMinimumRow, p1(2), p2(2), p3(2), p4(2)]);
maximumRow = max([initMaximumRow, p1(2), p2(2), p3(2), p4(2)]);
minimumCol = min([initMinimumCol, p1(1), p2(1), p3(1), p4(1)]);
maximumCol = max([initMaximumCol, p1(1), p2(1), p3(1), p4(1)]);

mosaicRows = 1 + maximumRow - minimumRow;
mosaicCols = 1 + maximumCol - minimumCol;

panorama = zeros(mosaicRows, mosaicCols, 3, 'uint8');
offset = [1;1;0] - [minimumRow; minimumCol; 0];

p1_y_relation = 1 - minimumRow;
p1_x_relation = 1 - minimumCol;

%----------------------%

for y = 1:rows
    for x = 1:cols
        panorama(y + p1_y_relation, x + p1_x_relation, :) = imageFixed(y,x,:);
    end
end

for y = 1:mosaicRows
    for x = 1:mosaicCols
        newCoordinate = H \ [x - p1_x_relation; y - p1_y_relation; 1];
        newCoordinate = round(newCoordinate / newCoordinate(3));
        if(newCoordinate(1) > 0 && newCoordinate(2) > 0 && newCoordinate(1) <= cols && newCoordinate(2) <= rows)
            if(newCoordinate(1) > 1 && newCoordinate(1) < cols && newCoordinate(2) > 1 && newCoordinate(2) < rows)
                dx = newCoordinate(1) - floor(newCoordinate(1));
                dy = newCoordinate(2) - floor(newCoordinate(2));
            
                w1 = imageMoving(newCoordinate(2), newCoordinate(1), :) * (1 - dx) * (1 - dy);
                w2 = imageMoving(newCoordinate(2), newCoordinate(1) + 1, :) * (dx) * (1 - dy);
                w3 = imageMoving(newCoordinate(2) + 1, newCoordinate(1), :) * (1 - dx) * (dy);
                w4 = imageMoving(newCoordinate(2) + 1, newCoordinate(1) + 1, :) * (dx) * (dy);
                
                panorama(y, x, :) = w1 + w2 + w3 + w4;
            else
                panorama(y, x, :) = imageMoving(newCoordinate(2), newCoordinate(1), :); 
            end
        end
    end
end

%----------------------%
%Filter

firstImage= zeros(853,1281,1);
[h,f] = size(firstImage);
secondImage= zeros(853,1281,1);
[h2,f2] = size(secondImage);

firstImage(:,1:round(f/2)) = repmat(0:2/f:1,h,1);
firstImage(:,round(f/2):f) = repmat(1:-2/f:0,h,1);

s = (0:2/h2:1);
secondImage(1:h2/2+1,:) = repmat(s',1,f2);

s = 1:-2/h2:0;
secondImage(h2/2:h2,:) = repmat(s',1,f2);

f = firstImage .* secondImage;
f2 = imresize(f,[10  10]);

G = fspecial('gaussian',10,50);
blurred = imfilter(panorama,G,'replicate');
laplacian = panorama - blurred;


%----------------------%
%Output

figure 
montage({f, f2, blurred , panorama, laplacian})