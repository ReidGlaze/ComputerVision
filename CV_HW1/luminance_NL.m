%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 6
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = luminance_NL( inImg )

    % Clock starts
    tic

    % Read image
    inputImage = imread(inImg);
    outImg = inputImage;
    
    [rows, columns, ~] = size(outImg);

    % Separate RGB channel
    red_channel = outImg(:, :, 1);
    green_channel = outImg(:, :, 2);
    blue_channel = outImg(:, :, 3);

    % Weighting system
    I = 0.299*red_channel + 0.587*green_channel + 0.114*blue_channel;

    % Plots
    subplot(1,2,1), imshow(inImg);
    subplot(1,2,2), imshow(I);

    % Clock stops
    toc

    % Save iamge
    imwrite(I,'/Users/rohitkharat/Downloads/CV/newimage_luminance_NL.jpg');

end
