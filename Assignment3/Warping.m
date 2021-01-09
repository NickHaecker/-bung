clear(); close all;

I = imread("Cow.jpg");

I2 = im2double(I);

[movingPoints, fixedPoints] = cpselect(I2, I2, "Wait", true);

tdata = fitgeotrans(movingPoints, fixedPoints, 'projective');
T = tdata.T';

[Y,X,Z] = size(I2);

topLeftCorner = T * [1; 1; 1];
topRightCorner = T * [1; Y; 1];
bottomLeftCorner = T * [X; 1; 1];
bottomRightCorner = T * [X; Y; 1];

topLeftCorner = round(topLeftCorner / topLeftCorner(3));
topRightCorner = round(topRightCorner / topRightCorner(3));
bottomLeftCorner = round(bottomLeftCorner / bottomLeftCorner(3));
bottomRightCorner = round(bottomRightCorner / bottomRightCorner(3));

maxX = max([topLeftCorner(1) topRightCorner(1) bottomRightCorner(1) bottomLeftCorner(1)]);
minX = min([topLeftCorner(1) topRightCorner(1) bottomRightCorner(1) bottomLeftCorner(1)]);

maxY = max([topLeftCorner(2) topRightCorner(2) bottomRightCorner(2) bottomLeftCorner(2)]);
minY = min([topLeftCorner(2) topRightCorner(2) bottomRightCorner(2) bottomLeftCorner(2)]);


relHeight = -minY + 1 + maxY;
relWidth = -minX + 1 + maxX;

forwardWarpedImage = zeros(relHeight, relWidth, 3, 'uint8');

offset = [1;1;0] - [minX; minY; 0];

%Forward Warping
for y = 1:Y
    for x = 1:X
        newCoord = T * [x;y;1];
        newCoord= round(newCoord / newCoord(3)) + offset;
        forwardWarpedImage(newCoord(2), newCoord(1),:) = I(y,x,:);
    end
end


inverserWarpedImage = forwardWarpedImage;

relY = 1 - minY;
relX = 1 - minX;

%Inverse Warping
for y = 1:relHeight
    for x = 1:relWidth
        newCoord = T \ [x - relX; y - relY; 1];
        newCoord = round(newCoord / newCoord(3));

        if(newCoord(1) > 0 && newCoord(2) > 0 && newCoord(1) <= X && newCoord(2) <= Y)
            inverserWarpedImage(y,x,:) = I(newCoord(2), newCoord(1), :);
        end
    end
end

montage({forwardWarpedImage, inverserWarpedImage});