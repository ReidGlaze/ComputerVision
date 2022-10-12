%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: ComputeGradientFeatures Function
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function featImage = ComputeGradientFeatures(image)
    
    % Converting to rgb to gray 
    grayImage = rgb2gray(image);
    
    % Calculating the height & width of the image
    hgtImage = size(image,1);
    wdtImage = size(image,2);
    
    % Initialization of feature space
    featImage = zeros([hgtImage,wdtImage,1]);

    % Gradient function
    [Gmag, Gdir] = imgradient(grayImage);

    featImage(:,:,1) = Gmag;
    featImage(:,:,2) = Gdir;

    imshow(Gmag);
    imshow(Gdir);

end