# 灰度直方统计图，尝试利用灰度区分，配合MATLAB代码进行测试
import cv2
import math
from matplotlib import pyplot as plt

dir = "transfer10.png"

image = cv2.imread(dir)

def plot_demo(image):
    plt.hist(image.ravel(), 256, [0, 256])
    plt.show()

def image_hist(image):     #画三通道图像的直方图
    color = ('b', 'g', 'r')   #这里画笔颜色的值可以为大写或小写或只写首字母或大小写混合
    for i , color in enumerate(color):
        hist = cv2.calcHist([image], [i], None, [256], [0, 256])  #计算直方图
        plt.plot(hist, color)
        plt.xlim([0, 256])
    plt.show()

src = image

cv2.namedWindow('input_image', cv2.WINDOW_NORMAL)
cv2.imshow('input_image', src)

plot_demo(src)
image_hist(src)

cv2.waitKey(0)
cv2.destroyAllWindows()