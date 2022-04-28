%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: RunComputeSegmentation Script
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

% Simple script to run ComputeSegmentation.

% Read the input image.
img = imread('../imgs/kitten9.jpg');

% Choose the number of clusters and 
% the clustering method.
k = 5;
clusteringMethod = 'kmeans';

% Choose the feature function that will be used. The @ syntax creates a
% function handle; this allows us to pass a function as an argument to
% another function.
featureFn = @ComputeColorFeatures;

% Whether or not to normalize features before clustering.
normalizeFeatures = true;

% Whether or not to resize the image before clustering. If this script
% runs too slowly then you should set resize to a value less than 1.
resize = 0.7;

% Use all of the above parameters to actually compute a segmentation.
segments = ComputeSegmentation(img, k, clusteringMethod, featureFn,normalizeFeatures, resize);
                           
% Show the computed segments in two different ways.
ShowSegments(img, segments);
ShowMeanColorImage(img, segments);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

% Use all of the above parameters to actually compute a segmentation.

clusteringMethod = 'kmeans';
featureFn = @ComputeColorFeatures;
normalizeFeatures = false;
resize = 0.7;

segments2 = ComputeSegmentation(img, 3, clusteringMethod, featureFn, normalizeFeatures, resize);

                           
% Show the computed segments in two different ways.
ShowSegments(img, segments2);
ShowMeanColorImage(img, segments2);

%%
img = imread('../imgs/kitten16.jpg');
% Use all of the above parameters to actually compute a segmentation.

clusteringMethod = 'kmeans';
featureFn = @ComputePositionColorFeatures;
normalizeFeatures = true;
resize = 1;

segments3 = ComputeSegmentation(img, 5, clusteringMethod, featureFn, normalizeFeatures, resize);

% Show the computed segments in two different ways.
ShowSegments(img, segments3);
ShowMeanColorImage(img, segments3);
%% 

% Use all of the above parameters to actually compute a segmentation.

clusteringMethod = 'kmeans';
featureFn = @ComputePositionColorFeatures;
normalizeFeatures = false;
resize = 1;

segments4 = ComputeSegmentation(img, 5, clusteringMethod, featureFn, normalizeFeatures, resize);

% Show the computed segments in two different ways.
ShowSegments(img, segments4);
ShowMeanColorImage(img, segments4);