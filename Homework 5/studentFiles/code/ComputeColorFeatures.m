%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: ComputeColorFeatures Function
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function features = ComputeColorFeatures(img)
% Computes a feature vector of color values for all pixels in an image.
%
% INPUTS
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of size h x w x 3 where features(i, j, :) is the feature
%            vector for the pixel img(i, j, :). In the case of color
%            features this is simply the input image.

    features = double(img);
end