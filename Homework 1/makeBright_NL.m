%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 2
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = makeBright_NL( inImg, brightness )
    
    % Clock starts
    tic;

    % Read image
    inImg = imread(inImg);
    outImg = uint8(brightness + inImg);

    % Check if brightness has applied
    isequal(outImg,inImg+brightness);

    % Plots
    subplot(1,2,1), imshow(inImg);
    subplot(1,2,2), imshow(outImg);

    % Clock stops
    toc;

    % Save image
    imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_bright_NL.jpg');

end