# --------------------------------------------%
# Rohit Kharat & Reid Glaze
# Course Code: CSCI 5722
# PROJECT TITLE: Using Real-Time Hand Segmentation to Detect Number of Fingers
# Capstone_Threshold: Evalauation of different Thresholding Methods and it's Parameters
# Instructor: Prof. Ioana Fleming
# --------------------------------------------%

# ---------- Description ----------

# This python file is used to test the effect of different threshold methods and
# assess the quality of detection of fingers with change in parameters.
# The parameters used for testing are the threshold value and number of neighbours.
# Our other objective was to determine the best threshold method and to determine the best and worst parameters for segmentation

# ---------- Instructions for running the file ----------

# If you do not want to use adaptive threshold
# python3 Capstone_Threshold.py --adaptive 0 --adaptiveMet '' --kNeigh 0 --thresh 25 --threshMet THRESH_MASK
# If you want to use adaptive threshold
# python3 Capstone_Threshold.py --adaptive 1 --adaptiveMet ADAPTIVE_THRESH_MEAN_C  --kNeigh 11 --thresh 0 --threshMet ''


#---------- Imports ----------

# Imports
import cv2
import numpy as np
import argparse

from sklearn.metrics import pairwise # Distance calculation

#---------- Variable declaration ----------

# Background declared as a global variable to update with the functions
background = None

# Starting with 0.5 as the accumulated weight
accumulated_weight = 0.5

# Setting up the Region of Interest (ROI) for showing hand on the web cam
roi_top = 20
roi_bottom = 300
roi_right = 300
roi_left = 600

#---------- Argument parser constructor ----------

# Construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()

# Argument for user to select adaptive threshold method
ap.add_argument("-a", "--adaptive", required=True,
	help="If want adaptive threshold enter 1 else 0")
# Argument for method to be used for adaptive threshold # ADAPTIVE_THRESH_MEAN_C, ADAPTIVE_THRESH_GAUSSIAN_C
ap.add_argument("-am", "--adaptiveMet", required=True,
	help="Input Adaptive method")
# Argument for number of neighbours # Input ddd number for number of neighbours
ap.add_argument("-kN", "--kNeigh", required=True,
	help="Input odd K Neighbours")
# Argument for threshold value
ap.add_argument("-t", "--thresh", required=True,
	help="Input Threshold")
# Argument for method of thresholding # THRESH_BINARY, THRESH_BINARY_INV, etc.
ap.add_argument("-tm", "--threshMet", required=True,
    help="Input Threshold Method")

# Getting the arguments into a variable
args = vars(ap.parse_args())

#---------- Function for calculating accumulated weight ----------

# This function calculates the weighted average of the next frame from the previous frame and the predefined accumulated weight
def calcWgtAvg(frame, accumulated_weight):

    # Declaring global variable 'backgroud'
    global background

	# Initially the background is created from the copy of the frame
    if background is None:
        background = frame.copy().astype("float")
        return None

	# Computation of accumulated average weight to update the background
    cv2.accumulateWeighted(frame, background, accumulated_weight)

#---------- Function for hand segementation and determination of threshold methods & parameters ----------

# This function segments the hand from the background in real-time
# We have used several threshold methods for determining successful and unsuccessful implementations

def handSegment(frame, threshold=127):

	# Declaring global variable 'backgrond'
    global background

	# Calculation of absolute difference between the background and the present frame
    diff = cv2.absdiff(background.astype("uint8"), frame)

	# Storing the arguments from the user to variables
    threshMet = args["threshMet"]
    adaptive = int(args["adaptive"])
    adaptiveMet = args["adaptiveMet"]
    kNeigh = int(args["kNeigh"])

	# Thresholding is done to get the foreground i.e. the hand from the background
	# The importance and function of each threshold method is extensively discussed in the report
    if adaptive == 1:
        if adaptiveMet == "ADAPTIVE_THRESH_MEAN_C":
            thresholded = cv2.adaptiveThreshold(diff, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY_INV, kNeigh, 8)
        elif adaptiveMet == "ADAPTIVE_THRESH_GAUSSIAN_C":
            thresholded = cv2.adaptiveThreshold(diff, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, kNeigh, 8)

    elif adaptive == 0:
        if threshMet == "THRESH_BINARY":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_BINARY)
        elif threshMet == "THRESH_BINARY_INV":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_BINARY_INV)
        elif threshMet == "THRESH_TRUNC":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_TRUNC)
        elif threshMet == "THRESH_TOZERO":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_TOZERO)
        elif threshMet == "THRESH_TOZERO_INV":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_TOZERO_INV)
        elif threshMet == "THRESH_MASK":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_MASK)
        elif threshMet == "THRESH_OTSU":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_OTSU)
        elif threshMet == "THRESH_TRIANGLE":
            _ , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_TRIANGLE)

	# Getting the external contours from the foreground for future use of counting fingers in the frame
    contours, hierarchy = cv2.findContours(thresholded.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

	# If no contour detected in the bounding box, return None
    if len(contours) == 0:
        return None

	# Getting the largest contour by area i.e. hand from the bounding box
    else:
        hand_segment = max(contours, key=cv2.contourArea)

		# Return both the hand segmentation and the thresholded hand
        return (thresholded, hand_segment)

#---------- Function for counting fingers ----------

def countFingers(thresholded, hand_segment):

	# Getting the polygon from the hand segment
    conv_hull = cv2.convexHull(hand_segment)

	# Convex hull function returns atleast 4 polygon points i.e top, bottom, left, and right

	# Getting those four points and storing as a tuple
    top = tuple(conv_hull[conv_hull[:, :, 1].argmin()][0])
    bottom = tuple(conv_hull[conv_hull[:, :, 1].argmax()][0])
    left = tuple(conv_hull[conv_hull[:, :, 0].argmin()][0])
    right = tuple(conv_hull[conv_hull[:, :, 0].argmax()][0])

	# Center of the hand in the frame can be found by the midpoint of the horizontal and vertical points
    cX = (left[0] + right[0]) // 2
    cY = (top[1] + bottom[1]) // 2

	# Computation of maximum euclidean distance between the center and the extreme points of the polygon i.e hand
	# We have a separate python file for determination of different distance measures
    distance = pairwise.euclidean_distances([(cX, cY)], Y=[left, right, top, bottom])[0]

    # Getting the largest distance
    max_distance = distance.max()

	# Computation of a circle with 80% radius of the largest distance
    radius = int(0.8 * max_distance)
    circumference = (2 * np.pi * radius)

    # Creating ROI of circle
    circular_roi = np.zeros(thresholded.shape[:2], dtype="uint8")

    # Drawing the circular ROI
    cv2.circle(circular_roi, (cX, cY), radius, 255, 10)

	# Bitwise AND along with the empty circular ROI as a mask is used to get the separate segment of the hand
    circular_roi = cv2.bitwise_and(thresholded, thresholded, mask=circular_roi)

	# Getting the external contours from the circular ROI
    contours, hierarchy = cv2.findContours(circular_roi.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)

    # Initially show the fist to get better counting of fingers # count set as zero
    count = 0

	# Loop for detecting more fingers from the bounding box
    for cnt in contours:

        # Bounding box of contour
        (x, y, w, h) = cv2.boundingRect(cnt)

		# Fingers are counted based on two conditions

		# 1) Contour region should be upper region of wrist to form good poygon
        out_of_wrist = ((cY + (cY * 0.25)) > (y + h))

		# 2) Limit number of points to avoid getting points outside of the hand segement
		# 25% of the circumference of the circular ROI is used as a limit
        limit_points = ((circumference * 0.25) > cnt.shape[0])

		# If both conditions satisfy, increment the count
        if  out_of_wrist and limit_points:
            count += 1

	# Return the number of counted fingers
    return count

#---------- Code for real-time hand detection from web cam ----------

# Getting the camera feed
cam = cv2.VideoCapture(0)

# Intialization of number of frames
num_frames = 0

# Keep looping until the user interrupts with a keyboard key
while True:

    # Current frame
    ret, frame = cam.read()

	# Flipping the camera frame to avoid the mirror view
    frame = cv2.flip(frame, 1)

    frame_copy = frame.copy()

	# Getting the ROI from the frame
    roi = frame[roi_top:roi_bottom, roi_right:roi_left]

	# Converting frame to grayscale and applying gaussian blurring for smoothing edges
    # A separate python file is present which tests the robustness of detection by blurring the image
    gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (7, 7), 0)

	# First few frames are used to calculate the weighted average of the background
    if num_frames < 60:
        calcWgtAvg(gray, accumulated_weight)
        if num_frames <= 59:
            cv2.putText(frame_copy, "PLEASE WAIT! CALCULATING BACKGROUND WEIGHTED AVERAGE!", (200, 400), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)
            cv2.imshow("Finger Count",frame_copy)

    else:
		# After computation of weighted average, calling the hand segment function
        hand = handSegment(gray, threshold=int(args["thresh"]))

        # Checking if hand is detected
        if hand is not None:

            # Unpacking returned objects
            thresholded, hand_segment = hand

            # Drawing contours aroung hand segment
            cv2.drawContours(frame_copy, [hand_segment + (roi_right, roi_top)], -1, (255, 0, 0),1)

            # Calling countFingers function to get the number of fingers detected
            fingers = countFingers(thresholded, hand_segment)

            # Display number of fingers detected
            cv2.putText(frame_copy, str(fingers), (70, 45), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)

			# Display image for hand segmented using threshold method
            cv2.imshow("Thesholded Hand Image: ", thresholded)

    # Drawing rectangle box on frame
    cv2.rectangle(frame_copy, (roi_left, roi_top), (roi_right, roi_bottom), (0,0,255), 5)

    # Tracking number of frames
    num_frames += 1

    # Display image for real-time finger count
    cv2.imshow("Finger Count", frame_copy)

    # Waitkey for closing the capturing of frame
    k = cv2.waitKey(1) & 0xFF
	# If user pressed escape key, break
    if k == 27:
        break

# Release the camera and destroy all the windows
cam.release()
cv2.destroyAllWindows()
