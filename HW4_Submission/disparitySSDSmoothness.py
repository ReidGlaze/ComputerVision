#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: function disparitySSDSmoothness
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

# Imports
import numpy as np
import cv2
import matplotlib.pyplot as plt

# Function definition disparitySSDSmoothness
def disparitySSDSmoothness(leftImg, rightImg, maxSearchBound, winSize, smoothThresh):
    
    # Gaussian Blurring for winSize > 1
    if (winSize > 1):
        leftImg = cv2.GaussianBlur(leftImg, (winSize, winSize), 0)
        rightImg = cv2.GaussianBlur(rightImg, (winSize, winSize), 0)

    # Converting image type to double
    leftImg = np.double(leftImg)
    rightImg = np.double(rightImg)
    
    # Initialization of output image and energy matrices
    outImg = np.zeros(leftImg.shape)
    energies = np.zeros(leftImg.shape)
    energies_thresh = np.zeros(leftImg.shape)

    disparityCost = []
    
    # Left Image pixel matching
    for row in range(leftImg.shape[0] - (winSize - 1)):
        for col in range(leftImg.shape[1] - (winSize - 1)):
            
            matLeft = leftImg[row:row + winSize, col:col + winSize]

            if col - maxSearchBound >= 0:
                disparityList = []
                diff = []
                # Right Image pixel matching with maxSearchBound at Epipolar Lines
                for disparityRange in range(maxSearchBound):
                    
                    matRight = rightImg[row:row + (winSize), col - disparityRange:col - disparityRange + (winSize)]
                    SD = (matRight - matLeft) ** 2
                    SSD = np.sum(SD)
                    disparityList.append(SSD)
                
                # Loop for energy minimization
                for i in range(0,maxSearchBound-1):
                    diff.append(np.abs(disparityList[i]-disparityList[i+1]))
                smoothnessCost = np.sum(diff)
                
                # Energy computation for indexed pixel
                energy = min(disparityList) + smoothnessCost
                
                # Energy computation with respect to user-defined smoothness threshold
                energyThresh = min(disparityList) + smoothThresh
                
                # Comparison of neighbouring pixels for similar disparities using energy minimization
                if energy < energyThresh:
                    dispIndex = disparityList.index(min(disparityList))
                    outImg[row, col] = dispIndex
            else:
                pass
            
    # Normalization of pixel values
    #outImg = 255 * outImg / maxSearchBound
    outImg = 255 * outImg / (np.max(outImg))
    outImg = np.uint8(outImg)
    return outImg