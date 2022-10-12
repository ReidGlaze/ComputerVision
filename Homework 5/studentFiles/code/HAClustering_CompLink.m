%--------------------------------------------%
% Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 5: Task 3: Complete Link HAC
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function idx = HAClustering_CompLink(x, k, visualize2D)

if nargin < 3
    visualize2D = false;
end

if ~isa(x, 'double')
    x = double(x);
end

% The number of points to cluster.
numPoints = size(x, 1);

% The dimension of each point.
shape = size(x, 2);

% The number of clusters that we currently have.
numCluster = numPoints;

% The assignment of points to clusters. If idx(i) = c then X(i, :) is
% assigned to cluster c. Since each point is initally assigned to its
% own cluster, we initialize idx to the column vector [1; 2; ...; m].
idx = (1:numPoints)';

% The centroids of all clusters. The row centroids(c, :) is the
% centroid of the cth cluster. Since each point starts in its own
% cluster, the centroids are initially the same as the data matrix.
centroids = x;

% The number of points in each cluster. If cluster_sizes(c) = n then
% cluster c contains n points. Since each point is initially assigned
% to its own cluster, each cluster size is initialized to 1.
sizeCluster = ones(numPoints, 1);

% The distances between the centroids of the clusters. For ci != cj,
% dists(ci, cj) = d means that the Euclidean distance between
% centroids(ci, :) and centroids(cj, :) is d. We will choose the pair
% of clusters to merge at each step by finding the smallest element of
% the dists matrix. We never want to merge a cluster with itself;
% therefore we set the diagonal elements of dists to be +Inf.
dists = squareform(pdist(x));
dists = dists + diag(Inf(numPoints, 1));

% If we are going to display the clusters graphically then create a
% figure in which to draw the visualization.
figHandle = [];
if shape == 2 && visualize2D
    figHandle = figure;
end


% In the 2D case we can easily visualize the starting points.
if shape == 2 && visualize2D
    VisualizeClusters2D(x, idx, centroids, figHandle);
    pause;
end

while numCluster > k

    % Find the pair of clusters that are closest together.
    % Set i and j to be the indices of the nearest pair of clusters.


    [point, ~] = find(min(dists,[],'all')==dists);

    i = point(1);
    j = point(2);
    
    % Make sure that i < j
    if i > j
        t = i;
        i = j;
        j = t;
    end

    idx(idx==j) = i;

    for index = 1:numPoints
        if index~=j && dists(index,i) ~= Inf
            point1 = x(idx==i,:);
            point2 = x(idx==idx(index),:);
            [Dist,~] = pdist2(point1,point2,'euclidean','Largest',1);
            dists(index,i) = Dist(1);
            dists(i,index) = Dist(1);
        end
        dists(j,:) = Inf(1,numPoints);
        dists(:,j) = Inf(numPoints,1);   
    end
        
    % If everything worked correctly then we have one less cluster.
    numCluster = numCluster - 1;

    % In the 2D case we can easily visualize the clusters.
    if shape == 2 && visualize2D
        VisualizeClusters2D(x, idx, centroids, figHandle);
        pause;
    end

end
% Now we need to reindex the clusters from 1 to k
idx = ReindexClusters(idx);
end