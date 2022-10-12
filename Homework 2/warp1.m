function [mos_img] = warp1(Img1, Img2)

% Loading the saved homography matrix
H_min = load("H_min.mat");


inputImage = imread(Img1);
refImage = imread(Img2);

row_ii = size(inputImage, 1);
col_ii = size(inputImage, 2);

row_ri = size(refImage, 1);
col_ri = size(refImage, 2);

corner_coords = [1 col_ri 1 col_ri; 1 1 row_ri row_ri; 1 1 1 1];

proj_corner_coords = H_min.H_min * corner_coords;



siz_corner = size(corner_coords);

% Dividing the 3rd value to get new coordinates
for i = 1:siz_corner(2)
    proj_corner_coords(:,i) = round(proj_corner_coords(:,i)/proj_corner_coords(3,i));
end

x_corner = cat(2, proj_corner_coords(1,:), corner_coords(1,:));
min_x = min(x_corner);
max_x = max(x_corner);
range_x = round(max_x - min_x);

y_corner = cat(2, proj_corner_coords(2,:), corner_coords(2,:));
min_y = min(y_corner);
max_y = max(y_corner);
range_y = round(max_y - min_y);




blank_img = -ones(range_y, range_x);
blank_img = uint8(blank_img)

% disp(range_x)
% disp(range_y)


blank_img(1+abs(min_y):row_ri+abs(min_y),1:col_ri,1:3) = uint8(inputImage);



imshow(refImage);



H_mat = inv(H_min.H_min);

new_coords = ones(3,row_ri);


for i=1:1:col_ri
    for j = 1:1:row_ri
        pixel_color(1:3,j) = refImage(j,i,1:3);
        coord1 = [i; j; 1];
        coord2 = H_mat*coord1;
        coord3 = round(coord2/coord2(3));
        
        new_coords(1,j) = coord3(1,1);
        new_coords(2,j) = coord3(2,1)+abs(min_y);
        if(new_coords(2,j) > 0 && new_coords(2,j) < range_y)
            if(new_coords(1,j) > 0 && new_coords(1,j) < range_x) 
                blank_img(new_coords(2,j),new_coords(1,j),1:3)= pixel_color(1:3,j);
            end
        end
    end
end
% imshow(blank_img)

% inputImage1 = inputImage(:,:,1)
% inputImage2 = inputImage(:,:,2)
% inputImage3 = inputImage(:,:,3)
% 
% blank_img1 = blank_img(:,:,1)
% blank_img2 = blank_img(:,:,2)
% blank_img3 = blank_img(:,:,3)

for iter = 1:3

    for c = 1:1:3
        for i=1:1:size(blank_img,1)
            for j = 1:1:(size(blank_img,2)-2)
                if blank_img(i,j,c) ~= 0
                    if blank_img(i,j+1,c) == 0
                        if blank_img(i,j+2,c) ~= 0
%                             disp('Interpolate here');
                            blank_img(i,j+1,:) = round((blank_img(i,j+1,:)+blank_img(i,j+2,:)));  
                        end
                    end
                end
            end
        end
    end

    for c = 1:1:3
        for i=1:1:(size(blank_img,1)-2)
            for j = 1:1:size(blank_img,2)
                if blank_img(i,j,c) ~= 0
                    if blank_img(i+1,j,c) == 0
                        if blank_img(i+2,j,c) ~= 0
%                             disp('Interpolate here');
                            blank_img(i+1,j,:) = round((blank_img(i+1,j,:)+blank_img(i+2,j,:)));  
                        end
                    end
                end
            end
        end
    end

end

    


% 
% inputImage1 = inputImage(:,:,1)
% inputImage2 = inputImage(:,:,2)
% inputImage3 = inputImage(:,:,3)
% 
% blank_img1 = blank_img(:,:,1)
% blank_img2 = blank_img(:,:,2)
% blank_img3 = blank_img(:,:,3)
imshow(blank_img)


end