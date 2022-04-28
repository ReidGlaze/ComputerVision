%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 4
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%


function [ outImg ] = invert_NL( inImg )

    % Clock starts
    tic;

    % Read image
    inImg = imread(inImg);

    % Inverting image
    outImg = uint8(255 - inImg);

    % Plots
    subplot(1,2,1), imshow(inImg);
    subplot(1,2,2), imshow(outImg);

    % Clock stops
    toc;

    % Save image
    imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_invert_NL.jpg')
end