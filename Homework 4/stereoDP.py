#--------------------------------------------%
# Rohit Kharat and Reid Glaze
# Course Code: CSCI 5722
# Homework 4: function stereoDP 
# Instructor: Prof. Ioana Fleming
#--------------------------------------------%

def stereoDP(e1, e2, maxDisp, occ):
    e1Row = e1.shape[0]
    e2Row = e2.shape[0]
    D = np.zeros([e1Row+1, e2Row+1]) + float('inf')
    backTrackMat = np.zeros(D.shape)

    # Part A: Disparity matching along each epipolar lines %%%%%%%%%%%%%%%%%%%
    
    # Penalty for matching two pixels
    D[1, 1] = (e1[1] - e2[1]) ** 2
    
    for i in range(1, e1Row):
        for j in range(1, e2Row):
            if (j-maxDisp) < i < (j+maxDisp) and (i-maxDisp) < j < (i+maxDisp):
                D[0, j] = j * occ
                D[i, 0] = i * occ

                cost = (e1[i] - e2[j])**2 # Penalty

                D[i, j] = min(D[i-1, j-1] + cost, D[i-1, j] + occ, D[i, j-1] + occ)
                if D[i, j] == D[i-1, j-1] + cost:
                    backTrackMat[i, j] = 2
                elif D[i, j] == D[i-1, j] + occ:
                    backTrackMat[i, j] = 0
                else:
                    backTrackMat[i, j] = 1
            else:
                pass

    # Part B: Backtracking %%%%%%%%%%%%%%%%%%
    
    disparityMat = np.zeros(e1Row)
    i = e1Row - 5
    j = e1Row - 5
    while i > 0 and j > 0:
        if backTrackMat[i, j] == 2:
            disparityMat[i] = abs(i - j)
            i = i-1
            j = j-1
        elif backTrackMat[i, j] == 1:
            j = j-1
        else:
            i = i-1
    return disparityMat