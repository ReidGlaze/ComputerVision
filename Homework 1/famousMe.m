%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 14
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [outImg] = famousMe(myImage, targetImage, x_pos, y_pos, factor)

tic

% Read the image
%myImage = imread(myImage);
targetImage = imread(targetImage);

outImg = targetImage;

% Resizing the image
[myImage] = scaleNearest(myImage, factor);
myImage = uint8(myImage);
[r, c, ch] = size(myImage);

% Initializing binary mask image
bin_image = zeros(r, c);

[r_b, c_b, ~] = size(bin_image);

% Applying binary mask to your image
for i = 1:r
    for j = 1:c

        grayscale_part = ((0.299 * myImage(i, j, 1)) + (0.587 * myImage(i, j, 2)) + (0.114 * myImage(i, j, 3)));

        % Separating black background from white 0 > black
        if grayscale_part > 0 && grayscale_part < 10
            grayscale_part = 0;
        % 255 > white
        else
            grayscale_part = 255;
        end

        bin_image(i, j) = grayscale_part;
    end
end

% Separating the object of interest from the background
bin_image = uint8(bin_image)/255 .* myImage;

% Pasting your image to the target image
for i = 1:r_b
    for j = 1:c_b
        if bin_image(i, j, :) ~= 0
            outImg(i + y_pos, j + x_pos, :) = bin_image(i, j, :);
        end
    end
end

% Plots
subplot(1,3,1), imshow(myImage);
subplot(1,3,2), imshow(targetImage);
subplot(1,3,3), imshow(outImg);

% Save iamge
imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_famousMe.jpg')

end

