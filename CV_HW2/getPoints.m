function [coord_mat] = getPoints(Img1, Img2)

% Reading and storing coordinates from Image 1
Image1 = imread(Img1);
axis on;
imshow(Image1);
%[x1_t, y1_t] = ginput(10);
%[x1, y1] = [x1_t, y1_t]';
[x1, y1] = ginput(10);
coord1 = cat(2, x1, y1);

hold on;

% Reading and storing coordinates from Image 2
Image2 = imread(Img2);
axis on;
imshow(Image2);
[x2, y2] = ginput(10);
coord2 = cat(2, x2, y2);

% Creating the 10*4 matrix
coord_mat = cat(2, coord1, coord2);

% Saving the matrix variable for future use
filename = 'coord.mat';
save(filename, 'coord_mat');

end