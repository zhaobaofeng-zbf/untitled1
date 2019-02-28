#
import math
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt

dir = "2.png"

image = cv.imread(dir)

class Config:
    def __init__(self):
        pass

    min_area = 1000
    min_contours = 8
    threshold_thresh = 50
    epsilon_start = 50
    epsilon_step = 10

#局部阈值
def local_threshold(image):
    gray = cv.cvtColor(image, cv.COLOR_RGB2GRAY)  #把输入图像灰度化
    #自适应阈值化能够根据图像不同区域亮度分布，改变阈值
    binary = cv.adaptiveThreshold(gray, 255, cv.ADAPTIVE_THRESH_GAUSSIAN_C,cv.THRESH_BINARY, 25, 10)
    return binary

binary = local_threshold(image)
binary = cv.medianBlur(binary, 1)
cv.imwrite("gray.png", binary, [int(cv.IMWRITE_PNG_COMPRESSION), 9])
edges = binary
# edges = cv.Canny(binary,50,200)
plt.subplot(121),plt.imshow(edges,'gray')
plt.xticks([]),plt.yticks([])
#hough transform
lines = cv.HoughLinesP(edges,1,np.pi/180,30,minLineLength=60,maxLineGap=10)
lines1 = lines[:,0,:]#提取为二维
for x1,y1,x2,y2 in lines1[:]:
    cv.line(image,(x1,y1),(x2,y2),(255,0,0),1)

plt.subplot(122),plt.imshow(image,)
plt.xticks([]),plt.yticks([])