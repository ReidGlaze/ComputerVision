%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 7
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function [ outImg ] = redFilter(inImg, redVal)

    % Condition to check if redVal is between 0 and 1
    if redVal >= 0 && redVal <= 1

        % Clock starts
        tic
       
        % Read image
        inputImage = imread(inImg);
        %disp(size(inputImage));
        
        [R, C, Ch] = size(inputImage);

        %outImg = uint8(zeros(R, C, Ch));
        outImg = inputImage;

    
        % Grayscale part------------------

        grayscale_part = inputImage(:, 1:floor(C/3), :);

        red_channel_g = grayscale_part(:, :, 1);
        green_channel_g = grayscale_part(:, :, 2);
        blue_channel_g = grayscale_part(:, :, 3);

        outImg(:, 1:floor(C/3)) = 0.299*red_channel_g + 0.587*green_channel_g + 0.114*blue_channel_g;
        %I_g = 0.299*red_channel_g + 0.587*green_channel_g + 0.114*blue_channel_g;
        o_g = zeros(size(grayscale_part));
        outImg(:, 1:floor(C/3),:) = uint8(o_g + double(outImg(:, 1:floor(C/3))));
        %I_g = uint8(o_g + double(I_g));
        %outImg(:, 1:(C/3)) = I_g;
        %disp(size(I_g));

        % Red value filter--------------
    
        red_filter_part = inputImage(:, 2*floor(C/3)+1 : C, :);
        %disp(size(red_filter_part));
    
        red_weight = redVal;
        green_weight = (1 - red_weight)/2;
        blue_weight = green_weight;
    
        red_channel_r = red_filter_part(:, :, 1);
        green_channel_r = red_filter_part(:, :, 2);
        blue_channel_r = red_filter_part(:, :, 3);
    
        outImg(:, 2*floor(C/3)+1:C) = red_weight*red_channel_r + green_weight*green_channel_r + blue_weight*blue_channel_r;
        %I_r = red_weight*red_channel_r + green_weight*green_channel_r + blue_weight*blue_channel_r;
        o_r = zeros(size(red_filter_part));
        outImg(:, 2*floor(C/3)+1:C, :) = uint8(o_r + double(outImg(:, 2*floor(C/3)+1:C)));
        %outImg(:, (2*C/3)+1:C) = I_r;
        %disp(size(I_r));
        
        %outImg = cat(2, I_g, I_o, I_r);
        %disp(size(outImg));
    
        subplot(1,2,1), imshow(inImg);
        subplot(1,2,2), imshow(outImg);
        
        % Save iamge
        imwrite(outImg,'/Users/rohitkharat/Downloads/CV/newimage_redFilter.jpg')

        % Clock stops
        toc

    else
        disp('Enter redVal between 0 and 1');

    end
    

end