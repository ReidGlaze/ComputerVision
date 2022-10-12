#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: Function disparitySSD
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

import numpy as np
import cv2
import matplotlib.pyplot as plt

# Function definition disparitySSD
def disparitySSD(leftImg, rightImg, winSize, maxSearchBound):
    
    # Gaussian Blurring for winSize > 1
    if (winSize > 1):
        leftImg = cv2.GaussianBlur(leftImg, (winSize, winSize), 0)
        rightImg = cv2.GaussianBlur(rightImg, (winSize, winSize), 0)

    # Converting image type to double
    leftImg = np.double(leftImg)
    rightImg = np.double(rightImg)
    
    # Initialization of output image
    outImg = np.zeros(leftImg.shape)

    # Left Image pixel matching
    for row in range(leftImg.shape[0] - (winSize - 1)):
        for col in range(leftImg.shape[1] - (winSize - 1)):
            matLeft = leftImg[row:row + winSize, col:col + winSize]
            disparityList = []
            if col - maxSearchBound >= 0:
                # Right Image pixel matching with maxSearchBound at Epipolar Lines
                for disparityRange in range(maxSearchBound):
                    matRight = rightImg[row:row + (winSize), col - disparityRange:col - disparityRange + (winSize)]
                    SD = (matRight - matLeft) ** 2
                    SSD = np.sum(SD)
                    disparityList.append(SSD)
                minDispVal = min(disparityList)
                dispIndex = disparityList.index(minDispVal) # Storing index of minimum disparity value
                outImg[row, col] = dispIndex
            else:
                pass
            
    # Normalization of pixel values
    #outImg = 255 * outImg / maxSearchBound
    outImg = 255 * outImg / (np.max(outImg))
    outImg = np.uint8(outImg)
    return outImg
