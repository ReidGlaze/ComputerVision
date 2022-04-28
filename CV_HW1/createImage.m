function [ image ] = createImage() 

    image=ones(7,7,3); %initialize

    [r c ch] = size(image);

    image(:,1:r-1,1)=50;  
    image(1:r-2,r-3:r,2)=0;   
    %image(1:end,1:r-1,1)=10;  
    image(1:end,1:r-1,3)=50;  

    imshow(image);

    imwrite(image,'/Users/rohitkharat/Downloads/CV/created.jpg');
end