%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: Task 7: GrabCat
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

% Read the input images. 
objImg = imread('../imgs/black_kitten_star.jpg');
backgroundImg = imread('../imgs/backgrounds/grass.jpg');

% Parameters for clustering
k = 3;
clusteringMethod = 'kmeans';

% Function handle
featureHandle = @ComputeColorFeatures;

% Normalization
normFeat = true;

% Image resizing
resize = 0.8;

% Calling segmentation function
objSegment = ComputeSegmentation(objImg, k, clusteringMethod, featureHandle, ...
                               normFeat, resize);

% Calling ChooseSegments function
[~, outImg] = ChooseSegments(objSegment, backgroundImg);
imshow(outImg);

% Save the composite image.
folder='Output Images/';
imwrite(compositeImage, fullfile(folder,'grabcat_output.jpg'));