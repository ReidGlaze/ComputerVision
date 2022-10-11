#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: Task 6: Synthetic stereo sequences 
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

# Imports
import numpy as np
import cv2
import matplotlib.pyplot as plt
from disparitySSD import disparitySSD
from disparitySSDUniq import disparitySSDUniq
from disparitySSDSmoothness import disparitySSDSmoothness

# Reading images
leftImg = cv2.imread('teddy/im2.png', 0)
rightImg = cv2.imread('teddy/im6.png', 0)
groundTruthImg = cv2.imread('teddy/disp2.png', 0)

# Initialize Window Size and Maximum Search Bound
winSize = 3
maxSearchBound = 15
smoothThresh = 5000

# Gaussian Blurring for Window Size > 1
if (winSize > 1):
    leftImg = cv2.GaussianBlur(leftImg, (winSize, winSize), 0)
    rightImg = cv2.GaussianBlur(rightImg, (winSize, winSize), 0)
    
# Converting images to datatype double
leftImg = np.double(leftImg)
rightImg = np.double(rightImg)

# Calling disparity functions
outImgSim = disparitySSD(leftImg, rightImg, winSize, maxSearchBound)
outImgUniq = disparitySSDUniq(leftImg, rightImg, winSize, maxSearchBound)
outImgSmooth = disparitySSDSmoothness(leftImg, rightImg, winSize, maxSearchBound, smoothThresh)

# Subplots for Constraint Images vs Ground Truth Images
fig = plt.figure(figsize=(14,10))

plt.subplot(3, 2, 1)
plt.title('Similarity Constraint Image')
plt.imshow(outImgSim, cmap='gray')
plt.subplot(3, 2, 2)
plt.title('Ground Truth Image')
plt.imshow(groundTruthImg, cmap='gray')

plt.subplot(3, 2, 3)
plt.title('Uniqueness Constraint Image')
plt.imshow(outImgUniq, cmap='gray')
plt.subplot(3, 2, 4)
plt.title('Ground Truth Image')
plt.imshow(groundTruthImg, cmap='gray')

plt.subplot(3, 2, 5)
plt.title('Smoothing Constraint Image')
plt.imshow(outImgSmooth, cmap='gray')
plt.subplot(3, 2, 6)
plt.title('Ground Truth Image')
plt.imshow(groundTruthImg, cmap='gray')

plt.savefig('Constraint_Images_vs_Ground_Truth_Images.png')
plt.show()

# Converting output images to datatype double
outImgSim = np.double(outImgSim)
outImgUniq = np.double(outImgUniq)
outImgSmooth = np.double(outImgSmooth)
groundTruthImg = np.double(groundTruthImg)

# Error Computation
error1 = abs(outImgSim - groundTruthImg)
error2 = abs(outImgUniq - groundTruthImg)
error3 = abs(outImgSmooth - groundTruthImg)

error1 = np.uint8(error1)
error2 = np.uint8(error2)
error3 = np.uint8(error3)

# Subplots for Error in Constraint Images vs Ground Truth Images
fig = plt.figure(figsize=(14,10))

plt.subplot(2, 2, 1)
plt.title('Error: Similarity Constraint vs Ground Truth')
plt.imshow(outImgSim, cmap='gray')
plt.subplot(2, 2, 2)
plt.title('Error: Uniqueness Constraint vs Ground Truth')
plt.imshow(outImgUniq, cmap='gray')
plt.subplot(2, 2, 3)
plt.title('Error: Smoothness Constraint vs Ground Truth')
plt.imshow(outImgSmooth, cmap='gray')

plt.savefig('Error_in_Constraint_Images_vs_Ground_Truth_Images.png')
plt.show()

# Flattening error arrays for plotting
error1Hist = error1.flatten()
error2Hist = error2.flatten()
error3Hist = error3.flatten()

# Subplots for Histgram of Errors 
fig = plt.figure(figsize=(14,10))

plt.subplot(2, 2, 1)
plt.hist(error1Hist, bins = 30)
plt.title("Histogram: Similarity Constraint Error")
plt.subplot(2, 2, 2)
plt.hist(error2Hist, bins = 30)
plt.title("Histogram: Uniqueness Constraint Error")
plt.subplot(2, 2, 3)
plt.hist(error3Hist, bins = 30)
plt.title("Histogram: Smoothness Constraint Error")

plt.savefig('Histograms_of_Errors.png')
plt.show()