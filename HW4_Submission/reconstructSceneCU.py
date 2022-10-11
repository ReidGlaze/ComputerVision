#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: function reconstructSceneCU 
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

def reconstructSceneCU(disparityImg):
    siz = np.shape(disparityImg)
    
    # Computation of Baseline using geometric relation for disparity
    depthValueMat = np.zeros([siz[0], siz[1]])
    pp1 = [316.8934, 234.5534] # stereo_params.CameraParameters1.PrincipalPoint
    pp2 = [325.7300, 237.7642] # stereo_params.CameraParameters2.PrincipalPoint
    focalLength = [530.3463,  528.7529] # stereo_params.CameraParameters1.FocalLength
    focalAvg = (focalLength[0] + focalLength[1]) / 2
    
    baseline = np.sqrt((pp2[0]-pp1[0])**2 + (pp2[1]-pp1[1])**2)
    
    for row in range(0,siz[0]):
        for col in range(0, siz[1]):
            depthValueMat[row, col] = ((focalAvg * baseline) / disparityImg[row,col])
    return depthValueMat
        
depthValueMat = reconstructSceneCU(disparityImg)
