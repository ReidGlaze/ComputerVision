%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 1
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = makeBright_L( inImg, brightness )

% Clock starts
tic

% Read image
inputImage = imread(inImg);
outImg = inputImage;

[rows, columns, channels] = size(outImg);

% Loop for adding brightness, pixel-by-pixel
for x = 1:columns
    for y = 1:rows
        for z = 1:channels
            t = inputImage(y, x, z);
            outImg(y, x, z) = t + brightness;
        end
    end
end

% Check if brightness has applied
isequal(outImg, inputImage+brightness);

% Plots
subplot(1,2,1), imshow(inputImage);
subplot(1,2,2), imshow(outImg);

% Save image
imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_bright_L.jpg');

% Clock stops
toc

end