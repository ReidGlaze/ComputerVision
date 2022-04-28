%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: HAClustering_CompLink_Test Function
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function HAClustering_CompLink_Test(visualize)
% Tests your implementation of HAClustering.m by comparing its output on a
% test dataset with the output of our reference implementation on the same
% dataset.
%
% INPUT
% visualize - Whether or not to visualize each step of the clustering
%             algorithm. Optional; default is true.

    if nargin < 1
        visualize = true;
    end
    load('../test_data/HAClusteringTest.mat');
    my_idx = HAClustering_CompLink(X, k, visualize);
    if all(my_idx == idx)
        disp(['Congrats! Your HAClustering algorithm produces the same ' ...
             'output as ours.']);
    else
        disp(['Uh oh - Your HAClustring algorithm produces a different ' ...
              ' output from ours.']);
    end
end