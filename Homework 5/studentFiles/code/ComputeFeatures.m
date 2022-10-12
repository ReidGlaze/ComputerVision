%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: ComputeFeatures Function
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function features = ComputeFeatures(img)
% Compute a feature vector for all pixels of an image. You can use this
% function as a starting point to implement your own custom feature
% vectors.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features for all pixels of size h x w x f
%            such that features(i, j, :) is the feature vector (of
%            dimension f) for the pixel img(i, j, :).

    img = double(img);
    height = size(img, 1);
    width = size(img, 2);
    features = zeros([height, width, 1]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                         %
    %                              YOUR CODE HERE                             %
    %                                                                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Color features
    features(:,:,1:3) = double(img);

    % Position Color features
    features(:,:,4) = repmat(1:width,height,1);
    features(:,:,5) = repmat((1:height)',1,width);

    % Different Feature Transforms
    features(:, :, 1:5) = ComputePositionColorFeatures(img);
    features(:, :, 6:7) = ComputeGradientFeatures(img);
    features(:, :, 8) = ComputeEdgeFeatures(img); 
    
end