%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 9
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = meanFilter(inImg, kernel_size)

%if mod(kernel_size, 2) == 1


tic

% Read image
inputImage = imread(inImg);

%disp(size(inputImage));

[r,c,ch] = size(inputImage);

outImg = zeros(r,c,ch);

num_pad = ceil((kernel_size - 1)/2);

pad_mat = NaN(r+(2*num_pad),c+(2*num_pad),ch);

pad_mat(num_pad+1:end-(num_pad), num_pad+1:end-(num_pad), :) = inputImage;

[r_o, c_o, ch_o] = size(pad_mat);

for i = 2:r+1
    for j = 2:c+1
        for k = 1:ch
            mat_mean = pad_mat(i-1:i-1+kernel_size-1, j-1:j-1+kernel_size-1, k);
            outImg(i-1, j-1, k) = ceil(nanmean(mat_mean, 'All'));
        end
    end
end

%disp(size(outImg));

% Plots
subplot(1,2,1), imshow(inImg);
subplot(1,2,2), imshow(uint8(outImg));

% Save iamge
imwrite(uint8(outImg),'/Users/rohitkharat/Downloads/CV/newimage_meanFilter.jpg');

toc

%else

%    disp('Enter an odd number for kernel');

%end

end