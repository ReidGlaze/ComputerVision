%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 5
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = addRandomNoise_NL( inImg )

    % Clock starts
    tic

    % Read image
    inputImage = imread(inImg);
    outImg = inputImage;
    
    [rows, columns, channels] = size(outImg);

    % Matrix with random values for noise 
    rand_matrix = -255 + (255+255)*rand(rows, columns, channels);

    % Output image
    outImg = outImg + uint8(rand_matrix);

    % Plots
    subplot(1,2,1), imshow(inImg);
    subplot(1,2,2), imshow(outImg);

    % Clock stops
    toc

    % Save image
    imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_noise_NL.jpg')

end
