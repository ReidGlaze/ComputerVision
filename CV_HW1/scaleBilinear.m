%--------------------------------------------%
% Homework Group 11: Rohit Kharat and Reid Glaze
% Course Code: CSCI 5722
% Homework 1: Task 12
% Instructor: Prof. Ioana Fleming
%--------------------------------------------%

function  [outImg]  = scaleBilinear(inImg,factor)

tic

inputImage=imread(inImg);
A1=inputImage(:,:,1);
A2=inputImage(:,:,2);
A3=inputImage(:,:,3);
%f=input('Enter the factor by which the image is to be zoomed:');
[numrows numcolumns numchannels]=size(inputImage);


for i= 1:numrows
   for j= 1:numcolumns
      outImg(round(factor*(i-1)+1), round(factor*(j-1)+1), : ) = inputImage(i, j, : );
   end
end
[numrowsscaled numcolumnsscaled numchannels]=size(outImg);

%for each channel
for k=1:1:numchannels
    for (i=1:1:numrows*factor-(factor-1))
        for (A=1:1:factor-1)
            for (j=(1+A):factor:numcolumns*factor-(factor-1))
                outImg(i,j,k)=outImg(i,j-A,k)*((factor-A)/factor)+outImg(i,j+(factor-A),k)*(A/factor);
            end
        end
    end
     for (j=1:1:numcolumns*factor-(factor-1))
        for (A=1:1:factor-1)
            for (i=(1+A):factor:numrows*factor-(factor-1))
                outImg(i,j,k)=outImg(i-A,j,k)*((factor-A)/factor)+outImg(i+(factor-A),j,k)*(A/factor);
            end
        end
    end

end
finalrgb1=outImg(:,:,1);
finalrgb2=outImg(:,:,2);
finalrgb3=outImg(:,:,3);

toc
           
% Plots
subplot(1,2,1), imshow(inputImage); axis on; 
subplot(1,2,2), imshow(uint8(outImg)); axis on; 

% Save iamge
imwrite(uint8(outImg),'/Users/rohitkharat/Downloads/CV/newimage_scaleBilinear.jpg')

end

