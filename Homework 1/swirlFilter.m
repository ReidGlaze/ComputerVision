%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 13
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [outImg] = swirlFilter(inImg, factor, ox, oy)

tic

% Read image
inputImage = imread(inImg);

[row,col,ch] = size(inputImage);

%disp(size(inputImage));

%outImg = zeros(r, c, ch);
outImg = inputImage;

% Computing the distances from the specified origin to the edge
dist_array = [ox row-ox-1 oy col-oy-1];

% Getting the minimum radius in order to find the closest edge
rad = min(dist_array)-1;

% Maximum angle according to factor
max_angle = factor*2*pi;

% Looping the area defined by the radius from the closest edge
for i = ox-rad:ox+rad

    for j = oy-rad:oy+rad

        norm_radius = sqrt((i - ox)^2 + (j - oy)^2);

        if norm_radius ~= 0
            %theta = max_angle * norm_radius/rad;
            %theta = (pi*factor)/180;
            theta = (pi*norm_radius)/factor;
        end

        if norm_radius <= rad
            x = (i - ox)*cos(theta) + (j - oy)*sin(theta) + ox;
            %x = cos(theta)*radius + ox;
            y = -(i - ox)*sin(theta) + (j - oy)*cos(theta) + oy;
            %y = sin(theta)*radius + oy;
            outImg(i, j, :) = inputImage(round(x), round(y), :);
        end

    end
end

% Plots
subplot(1,2,1), imshow(inImg);
subplot(1,2,2), imshow(outImg);

% Save iamge
imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_swirlFilter.jpg')

end