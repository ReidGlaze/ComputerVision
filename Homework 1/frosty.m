%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 10
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = frosty(inImg, n, m)

tic

% Read image
inputImage = imread(inImg);
%disp(size(inputImage));

%outImg = inputImage;

[r,c,ch] = size(inputImage);

outImg = zeros(r,c,ch);

%outImg = zeros(r, c, ch);

%if n<=r && m<=c

num_pad = ceil((n - 1)/2);
pad_mat = NaN(r+(2*num_pad),c+(2*num_pad),ch);
pad_mat(num_pad+1:end-(num_pad), num_pad+1:end-(num_pad), :) = inputImage;
[r_o,c_o,ch_o] = size(pad_mat);

for i = 2:r+1
    for j = 2:c%+1
        for k = 1:ch
            %window = pad_mat(i-1:i+1, j-1:j+1, k);
            window = pad_mat(i-1:i-1+n-1, j-1:j-1+m-1, k);
            slide = reshape(window,1,[]);
            slide = slide(~isnan(slide));
            outImg(i-1, j-1, k) = randsample(slide, 1);
        end
    end
end

%disp(size(outImg));

% Plots
subplot(1,2,1), imshow(inImg);
subplot(1,2,2), imshow(uint8(outImg));

% Save iamge
imwrite(uint8(outImg),'/Users/rohitkharat/Downloads/CV/newimage_frosty.jpg');

toc

%end

end