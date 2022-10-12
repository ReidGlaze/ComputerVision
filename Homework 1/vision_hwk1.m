% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% your information
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Bright_Loop', 'Bright_NoLoop',...
    'Invert', 'Invert_NoLoop', 'Add_Random_Noise', 'Luminance_NoLoop',...
    'Red Filter', 'Binary Mask', 'Mean Filter','Frost Filter',...
    'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here

% Choice 1 is to exit the program
while choice ~= 1
    switch choice
        %         case 0
        %             disp('Error - please choose one of the options.')
        %             % Display a menu and get a choice
        %             choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
        %                 'Display Image', 'Bright_Loop', 'Bright_NoLoop',...
        %                 'Invert', 'Invert_NoLoop', 'Add_Random_Noise', 'Luminance_NoLoop',...
        %                 'Red Filter', 'Binary Mask', 'Mean Filter','Frost Filter',...
        %                 'Scale Nearest');
        % as you develop functions, add buttons for them here

        %         case 2
        %             % Load an image
        %             image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'redBaloon');
        %             switch image_choice
        %                 case 1
        %                     filename = 'lena1_small.jpeg';
        %                 case 4
        %                     filename = 'yoda.bmp';
        %                     % fill in cases for all the images you plan to use
        %             end
        %             current_img = imread(filename);

        %         case 3
        %             % Display image
        %             figure
        %             imagesc(current_img);
        %             if size(current_img,3) == 1
        %                 colormap gray
        %             end

        %case 4
        % Mean Filter

        % 1. Ask the user for size of kernel

        % 2. Call the appropriate function
        %newImage = meanFilter(current_img, k_size); % create your own function for the mean filter

        % 3. Display the old and the new image using subplot
        % ....
        %subplot(...)
        %imagesc(current_img)

        % subplot(...)
        %imagesc(newImage)


        % 4. Save the newImage to a file


        case 2
            % Brightness with Loop
            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    brightness = input('Brightness: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    brightness = input('Brightness: ');

                case 3
                    filename = 'sully.bmp';
                    brightness = input('Brightness: ');

                case 4
                    filename = 'yoda_small.bmp';
                    brightness = input('Brightness: ');

                case 5
                    filename = 'shrek.bmp';
                    brightness = input('Brightness: ');

                case 6
                    filename = 'wrench1.jpeg';
                    brightness = input('Brightness: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    brightness = input('Brightness: ');

                    %brightness = input('Brightness: ');

                    % fill in cases for all the images you plan to use
            end

            newImage = makeBright_L(filename, brightness);

        case 3
            % Brightness with No Loop
            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    brightness = input('Brightness: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    brightness = input('Brightness: ');

                case 3
                    filename = 'sully.bmp';
                    brightness = input('Brightness: ');

                case 4
                    filename = 'yoda_small.bmp';
                    brightness = input('Brightness: ');

                case 5
                    filename = 'shrek.bmp';
                    brightness = input('Brightness: ');

                case 6
                    filename = 'wrench1.jpeg';
                    brightness = input('Brightness: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    brightness = input('Brightness: ');


                    %brightness = input('Brightness: ');


                    % fill in cases for all the images you plan to use
            end

            newImage = makeBright_NL(filename, brightness);


        case 4
            % Invert with Loops
            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';

                case 2
                    filename = 'mandrill1.jpeg';

                case 3
                    filename = 'sully.bmp';

                case 4
                    filename = 'yoda_small.bmp';

                case 5
                    filename = 'shrek.bmp';

                case 6
                    filename = 'wrench1.jpeg';

                case 7
                    filename = 'redBaloon.jpeg';

                    % fill in cases for all the images you plan to use
            end

            newImage = invert_L(filename);

        case 5
            % Invert with No Loops
            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';

                case 2
                    filename = 'mandrill1.jpeg';

                case 3
                    filename = 'sully.bmp';

                case 4
                    filename = 'yoda_small.bmp';

                case 5
                    filename = 'shrek.bmp';

                case 6
                    filename = 'wrench1.jpeg';

                case 7
                    filename = 'redBaloon.jpeg';

                    % fill in cases for all the images you plan to use
            end

            newImage = invert_NL(filename);

        case 6
            % Add Random Noise
            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';

                case 2
                    filename = 'mandrill1.jpeg';

                case 3
                    filename = 'sully.bmp';

                case 4
                    filename = 'yoda_small.bmp';

                case 5
                    filename = 'shrek.bmp';

                case 6
                    filename = 'wrench1.jpeg';

                case 7
                    filename = 'redBaloon.jpeg';

                    % fill in cases for all the images you plan to use
            end

            newImage = addRandomNoise_NL(filename);

        case 7
            % Luminance

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';

                case 2
                    filename = 'mandrill1.jpeg';

                case 3
                    filename = 'sully.bmp';

                case 4
                    filename = 'yoda_small.bmp';

                case 5
                    filename = 'shrek.bmp';

                case 6
                    filename = 'wrench1.jpeg';

                case 7
                    filename = 'redBaloon.jpeg';

                    % fill in cases for all the images you plan to use
            end

            newImage = luminance_NL(filename);

        case 8
            % Red Filter

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    redVal = input('Red filter value: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    redVal = input('Red filter value: ');

                case 3
                    filename = 'sully.bmp';
                    redVal = input('Red filter value: ');

                case 4
                    filename = 'yoda_small.bmp';
                    redVal = input('Red filter value: ');

                case 5
                    filename = 'shrek.bmp';
                    redVal = input('Red filter value: ');

                case 6
                    filename = 'redBaloon.jpeg';
                    redVal = input('Red filter value: ');

                    % fill in cases for all the images you plan to use
            end

            newImage = redFilter(filename, redVal);

        case 9
            % Binary mask

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';

                case 2
                    filename = 'mandrill1.jpeg';

                case 3
                    filename = 'sully.bmp';

                case 4
                    filename = 'yoda_small.bmp';

                case 5
                    filename = 'shrek.bmp';

                case 6
                    filename = 'wrench1.jpeg';

                case 7
                    filename = 'redBaloon.jpeg';

            end

            newImage = binaryMask(filename);

        case 10
            % Mean filter

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    n = input('Kernel size: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    n = input('Kernel size: ');

                case 3
                    filename = 'sully.bmp';
                    n = input('Kernel size: ');

                case 4
                    filename = 'yoda_small.bmp';
                    n = input('Kernel size: ');

                case 5
                    filename = 'shrek.bmp';
                    n = input('Kernel size: ');

                case 6
                    filename = 'wrench1.jpeg';
                    n = input('Kernel size: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    n = input('Kernel size: ');

            end

            a = true;
            while a==true
                if mod(n,2) == 1
                    newImage = meanFilter(filename, n);
                    a = false;
                else
                    disp('Enter an odd number for kernel');
                    n = input('Kernel size: ');
                end
            end

        case 11
            % Frost filter

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    n = input('n: ');
                    m = input('m: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    n = input('n: ');
                    m = input('m: ');

                case 3
                    filename = 'sully.bmp';
                    n = input('n: ');
                    m = input('m: ');

                case 4
                    filename = 'yoda_small.bmp';
                    n = input('n: ');
                    m = input('m: ');

                case 5
                    filename = 'shrek.bmp';
                    n = input('n: ');
                    m = input('m: ');

                case 6
                    filename = 'wrench1.jpeg';
                    n = input('n: ');
                    m = input('m: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    n = input('n: ');
                    m = input('m: ');

            end

            a = true;
            while a==true
                img = imread(filename);
                [r, c, ~] = size(img);
                if n<=r && m<=c
                    newImage = frosty(filename, n, m);
                    a = false;
                else
                    disp('Enter n and m bound to image size');
                    n = input('n: ');
                    m = input('m: ');
                end
            end



        case 12
            % Scale Nearest Neighbour

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    factor = input('Enter a value for factor: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    factor = input('Enter a value for factor: ');

                case 3
                    filename = 'sully.bmp';
                    factor = input('Enter a value for factor: ');

                case 4
                    filename = 'yoda_small.bmp';
                    factor = input('Enter a value for factor: ');

                case 5
                    filename = 'shrek.bmp';
                    factor = input('Enter a value for factor: ');

                case 6
                    filename = 'wrench1.jpeg';
                    factor = input('Enter a value for factor: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    factor = input('Enter a value for factor: ');

            end



            a = true;
            while a==true
                if factor >= 0
                    newImage = scaleNearest(filename, factor);
                    a = false;
                else
                    disp('Enter a positive value for factor');
                    factor = input('Enter a value for factor: ');
                end
            end

        case 13
            % Scale Bilinear

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    factor = input('Enter a value for factor: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    factor = input('Enter a value for factor: ');

                case 3
                    filename = 'sully.bmp';
                    factor = input('Enter a value for factor: ');

                case 4
                    filename = 'yoda_small.bmp';
                    factor = input('Enter a value for factor: ');

                case 5
                    filename = 'shrek.bmp';
                    factor = input('Enter a value for factor: ');

                case 6
                    filename = 'wrench1.jpeg';
                    factor = input('Enter a value for factor: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    factor = input('Enter a value for factor: ');

            end



            a = true;
            while a==true
                if factor >= 0
                    newImage = scaleBilinear(filename, factor);
                    a = false;
                else
                    disp('Enter a positive value for factor');
                    factor = input('Enter a value for factor: ');
                end
            end

        case 14
            % Swirl Filter

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    filename = 'lena1_small.jpeg';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 2
                    filename = 'mandrill1.jpeg';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 3
                    filename = 'sully.bmp';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 4
                    filename = 'yoda_small.bmp';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 5
                    filename = 'shrek.bmp';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 6
                    filename = 'wrench1.jpeg';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

                case 7
                    filename = 'redBaloon.jpeg';
                    factor = input('Enter a value for factor: ');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');

            end



            a = true;
            while a==true
                if ox>0 && oy>0
                    newImage = swirlFilter(filename, factor, ox, oy);
                    a = false;
                else
                    disp('Enter positive values for ox and oy');
                    ox = input('Enter a value for ox: ');
                    oy = input('Enter a value for oy: ');
                end
            end

        case 15
            % Famous Me

            image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek', 'wrench', 'redBaloon');
            switch image_choice
                case 1
                    targetImage = 'lena1_small.jpeg';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 2
                    targetImage = 'mandrill1.jpeg';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 3
                    targetImage = 'sully.bmp';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 4
                    targetImage = 'yoda_small.bmp';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 5
                    targetImage = 'shrek.bmp';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 6
                    targetImage = 'wrench1.jpeg';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

                case 7
                    targetImage = 'redBaloon.jpeg';
                    myImage = 'my_image.jpeg';
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');

            end



            a = true;
            while a==true
                if x_pos>0 && y_pos>0 && factor > 0
                    newImage = famousMe(myImage, targetImage, x_pos, y_pos, res_hgt, res_wid);
                    a = false;
                else
                    disp('Enter positive values for position and resize window');
                    x_pos = input('Enter a value for horz position: ');
                    y_pos = input('Enter a value for vert position: ');
                    factor = input('Enter a value for factor: ');
                end
            end

    end
    % Display menu again and get user's choice
    choice = menu('Choose an option', 'Exit Program', 'Bright_Loop', 'Bright_NoLoop',...
        'Invert_Loop', 'Invert_NoLoop', 'Add_Random_Noise', 'Luminance_NoLoop',...
        'Red Filter', 'Binary Mask', 'Mean Filter', 'Frost Filter',...
        'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
end
