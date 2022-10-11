%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 11
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = scaleNearest(inImg, factor)

tic

% Read image
inputImage = imread(inImg);
%disp(size(inputImage));

[r,c,ch] = size(inputImage);

width = c*factor;
height = r*factor;

outImg = zeros(floor(height), floor(width), ch);

[r_o,c_o,ch_o] = size(outImg);


for i = 0:height - 1
    for j = 0:width - 1
        col_j = floor(j/factor);
        row_i = floor(i/factor);
        for k = 1:ch_o
            outImg(i+1, j+1, k) = inputImage(row_i+1, col_j+1, k);
        end
    end
end

%outImg = outImg;

%disp(size(outImg));

subplot(1,2,1), imshow(inputImage); axis on; %axis([0,r_o,0,c_o]); 
subplot(1,2,2), imshow(uint8(outImg)); axis on; %axis([0,r_o,0,c_o]); axis on;

% Save iamge
imwrite(uint8(outImg),'/Users/rohitkharat/Downloads/CV/newimage_scaleNearest.jpg')

toc

end

