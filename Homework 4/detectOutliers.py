#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: Function detectOutliers
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

def detectOutliers(disparityLeft2Right, disparityRight2Left, userThresh):

    siz = np.shape(disparityLeft2Right)
    outliersImg = np.zeros(siz)
    
    for row in range(0, siz[0]):
        for col in range(0, siz[1]):
            
            # Inliers
            if (disparityLeft2Right[row, col] - disparityRight2Left[row, col]) <= userThresh:
                outliersImg[row,col] = 0
            # Outliers
            else:
                outliersImg[row,col] = 1
                
    return outliersImg