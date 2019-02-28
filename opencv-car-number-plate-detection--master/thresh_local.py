import cv2


dir = "4.jpg"
image = cv2.imread(dir)
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
binary = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 25, 10)

cv2.namedWindow("image")
cv2.imshow('binary', gray)
cv2.waitKey(0)
cv2.destroyAllWindows()