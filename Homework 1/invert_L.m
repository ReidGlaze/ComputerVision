%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 3
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = invert_L( inImg )

    % Clock starts
    tic
    
    % Read image
    inputImage = imread(inImg);
    outImg = inputImage;
    
    [rows, columns, channels] = size(outImg);
    
    % Loop for inverting image, pixel-by-pixel
    for x = 1:columns
	    for y = 1:rows 
            for z = 1:channels
		        t = inputImage(y, x, z);
		        outImg(y, x, z) = 255 - t;
            end
        end
    end
   
    % Plots
    subplot(1,2,1), imshow(inputImage);
    subplot(1,2,2), imshow(outImg); 

    % Clock stops
    toc

    % Save image
    imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_invert_L.jpg')

end