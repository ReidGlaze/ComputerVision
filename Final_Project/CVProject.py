# --------------------------------------------%
# Rohit Kharat & Reid Glaze
# Course Code: CSCI 5722
# PROJECT TITLE: Using Real-Time Hand Segmentation to Detect Number of Fingers
# Capstone_Threshold: Evalauation of different Thresholding Methods and it's Parameters
# Instructor: Prof. Ioana Fleming
# --------------------------------------------%

import time
import cv2
import os
import numpy as np

# Used for distance calculation later o  n
from sklearn.metrics import pairwise

# This background will be a global variable that we update through a few functions
background = None

# Start with a halfway point between 0 and 1 of accumulated weight
accumulated_weight = 0.5


#These represent the ROI (Region of Interest) or the Red Box
roi_top = 0
roi_bottom = 300
roi_right = 300
roi_left = 600




def calc_accum_avg(frame, accumulated_weight):
    '''
    Given a frame and a previous accumulated weight, computed the weighted average of the image passed in.
    '''
    
    # Grab the background
    global background
    
    #create the background from a copy of the frame.
    if background is None:
        background = frame.copy().astype("float")
        return None

    # compute weighted average for the background
    cv2.accumulateWeighted(frame, background, accumulated_weight)





def segment(frame, threshold=30):
    global background
    
    # Calculates the Absolute Differentce between the backgroud and the passed in frame
    diff = cv2.absdiff(background.astype("uint8"), frame)
    #Does not start binary thresholding until there exists a value in the diff matrix that is greater than 30 (hand enters frame)
    count = np.count_nonzero(diff > 30)
    if count > 1:
        #OTSU technique for binary thresholding sets a different threshold for each gaussian
        blur = cv2.GaussianBlur(diff,(11,11),0)
        ret , thresholded = cv2.threshold(blur,0,255,cv2.THRESH_BINARY+cv2.THRESH_OTSU)
    else:
        ret , thresholded = cv2.threshold(diff, threshold, 255, cv2.THRESH_BINARY)
    # Grab the external contours form the image
    contours, hierarchy = cv2.findContours(thresholded.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    

    # If length of contours list is 0, then we didn't grab any contours!
    if len(contours) == 0:
        return None
    else:
        # Given the way we are using the program, the largest external contour should be the hand (largest by area)
        # This will be our segment

        hand_segment = max(contours, key=cv2.contourArea)
        
        # Return both the hand segment and the thresholded hand image
        return (thresholded, hand_segment)


# In[5]:



def count_fingers(thresholded, hand_segment):
    
    
    # Calculated the convex hull of the hand segment
    conv_hull = cv2.convexHull(hand_segment)
    
    # Now the convex hull will have at least 4 most outward points, on the top, bottom, left, and right.
    # Let's grab those points by using argmin and argmax. Keep in mind, this would require reading the documentation
    # And understanding the general array shape returned by the conv hull.

    # Find the top, bottom, left , and right.
    # Then make sure they are in tuple format
    top    = tuple(conv_hull[conv_hull[:, :, 1].argmin()][0])
    bottom = tuple(conv_hull[conv_hull[:, :, 1].argmax()][0])
    left   = tuple(conv_hull[conv_hull[:, :, 0].argmin()][0])
    right  = tuple(conv_hull[conv_hull[:, :, 0].argmax()][0])

    # In theory, the center of the hand is half way between the top and bottom and halfway between left and right
    cX = (left[0] + right[0]) // 2
    cY = (top[1] + bottom[1]) // 2

    # find the maximum euclidean distance between the center of the palm
    # and the most extreme points of the convex hull
    
    # Calculate the Euclidean Distance between the center of the hand and the left, right, top, and bottom.
    distance = pairwise.euclidean_distances([(cX, cY)], Y=[left, right, top, bottom])[0]
    
    # Grab the largest distance
    max_distance = distance.max()
    
    # Create a circle with 80% radius of the max euclidean distance
    radius = int(0.85 * max_distance)
    circumference = (2 * np.pi * radius)

    # Not grab an ROI of only that circle
    circular_roi = np.zeros(thresholded.shape[:2], dtype="uint8")
    
    # draw the circular ROI
    cv2.circle(circular_roi, (cX, cY), radius, 255, 10)
    
    # draw circle on frame_copy inside original ROI
    cv2.circle(frame_copy, (cX+300, cY), radius,  (0,255,0), 5)
    
    # draw circle midpoiint on frame_copy inside original ROI
    cv2.circle(frame_copy, (cX+300, cY), 0,  (0,255,0), 5)
    
    # draw
    
    
    # Using bit-wise AND with the cirle ROI as a mask.
    # This then returns the cut out obtained using the mask on the thresholded hand image.
    circular_roi = cv2.bitwise_and(thresholded, thresholded, mask=circular_roi)

    # Grab contours in circle ROI
    contours, hierarchy = cv2.findContours(circular_roi.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Finger count starts at 0
    count = 0

    # loop through the contours to see if we count any more fingers.
    for cnt in contours:
        
        # Bounding box of countour
        (x, y, w, h) = cv2.boundingRect(cnt)
        
        cv2.rectangle(frame_copy, (x+300, y), (x+w+300,y+h), (255,0,0), 3)
        # Increment count of fingers based on two conditions:
        
        # 1. Contour region is not the very bottom of hand area (the wrist)
        out_of_wrist = ((cY + (cY * 0.4)) > (y + h))
        
        # 2. Number of points along the contour does not exceed 15% of the circumference of the circular ROI (otherwise we're counting points off the hand)
        limit_points = ((circumference * 0.15) > cnt.shape[0])
        
        
        if  out_of_wrist and limit_points:
            count += 1

    return count






def timestamp():
    return int(round(time.time() * 1000))

def check_path(path):
    if not os.path.exists(path):
        os.makedirs(path)
        print(path, " has been created.")

def timestamped_filename(file_format):
    return str(timestamp())+"."+file_format


# In[12]:


dataset_folder = './gestures'
class_name = 'Strong'
file_format = 'png'
dataset_path = os.path.join(dataset_folder, class_name)

    # create path if not exists
check_path(dataset_path)


# In[13]:


cam = cv2.VideoCapture(0)
# capture settings
time_between_capture_ms = 1000
last_capture = timestamp()

# Intialize a frame count
num_frames = 0

# keep looping, until interrupted
while True:
    # get the current frame
    ret, frame = cam.read()

    # flip the frame so that it is not the mirror view
    frame = cv2.flip(frame, 1)

    # clone the frame
    frame_copy = frame.copy()

    # Grab the ROI from the frame
    roi = frame[roi_top:roi_bottom, roi_right:roi_left]
    
    
    # add random nosie within ROI
    im = np.zeros(roi.shape, np.uint8)
    mean = 0
    sigma = 5 
    cv2.randn(im,mean,sigma) 
    roi = cv2.add(roi, im) 
    
    #median blur
    cv2.medianBlur(roi, 5)

    #gaussian blur
    roi = cv2.GaussianBlur(roi,(5,5),0)
    #roi = cv2.GaussianBlur(roi,(7,7),0)

    
    # add bilateral filter
    roi = cv2.bilateralFilter(roi,35,75,75)
    
    # adjust contrast and brightness for roi
    alpha = 1.1 #contrast in between 1.0 and 3.0
    beta = 0 #brightness in between 0 and 100
    roi = cv2.convertScaleAbs(roi, alpha=alpha, beta=beta)
    

    #Gaussian blur
    roi = cv2.GaussianBlur(roi,(5,5),0)
    
    #bilateral filter
    roi = cv2.bilateralFilter(roi,20,75,75)
    
    #gaussian blur
    roi = cv2.GaussianBlur(roi,(5,5),0)
    
    # adjust contrast and brightness for roi
    alpha = 1.1 #contrast in between 1.0 and 3.0
    beta = 0 #brightness in between 0 and 100
    roi = cv2.convertScaleAbs(roi, alpha=alpha, beta=beta)
    
    #bilateral filter
    roi = cv2.bilateralFilter(roi,15,75,75)
    
    
    
    
    # Apply grayscale to ROI
    gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
    
    #grayscale blur
    gray = cv2.GaussianBlur(gray,(9,9),0)
    gray = cv2.GaussianBlur(gray,(9,9),0)
    gray = cv2.GaussianBlur(gray,(9,9),0)
    
    
    # smooth edges
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (3, 3))
    (thresh, binRed) = cv2.threshold(gray, 128, 255, cv2.THRESH_BINARY)
    gray = cv2.morphologyEx(gray, cv2.MORPH_OPEN, kernel, iterations=3)


    

    
    # Calculate average background in the beggining
    
    if num_frames < 60:
        calc_accum_avg(gray, accumulated_weight)
        if num_frames <= 59:
            cv2.putText(frame_copy, "WAIT! GETTING BACKGROUND AVG.", (200, 400), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)
            cv2.imshow("Finger Count",frame_copy)
            
    else:
        
        
        # segment the hand region
        hand = segment(gray)
        


        # Check if hand can be detected
        if hand is not None:
            
            # unpack
            thresholded, hand_segment = hand

            # Draw hand contours
            cv2.drawContours(frame_copy, [hand_segment + (roi_right, roi_top)], -1, (255, 0, 0),1)

            # Count the fingers
            fingers = count_fingers(thresholded, hand_segment)

            # Display count
            cv2.putText(frame_copy, str(fingers), (650, 45), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)

            # Display the thresholded image
            cv2.imshow("Thesholded", thresholded)
            if timestamp()-last_capture>time_between_capture_ms:
                filename = timestamped_filename(file_format)

                cv2.imwrite(os.path.join(dataset_path, filename), thresholded)
                last_capture = timestamp()
            
            
            cv2.namedWindow("Noise, Blur, Brightness and Contrast")
            cv2.moveWindow("Noise, Blur, Brightness and Contrast", 0,300)
            cv2.imshow("Noise, Blur, Brightness and Contrast", roi)
            

    # Draw ROI Rectangle on frame copy
    cv2.rectangle(frame_copy, (roi_left, roi_top), (roi_right, roi_bottom), (0,0,255), 5)
    
    
    
    # increment the number of frames for tracking
    num_frames += 1

    # Display the frame with segmented hand
    cv2.imshow("Finger Count", frame_copy)


    # Close windows with Esc
    k = cv2.waitKey(1) & 0xFF

    if k == 27:
        break

# Release the camera and destroy all the windows
cam.release()
cv2.destroyAllWindows()