# importing the module
import cv2
from os import listdir
from os.path import isfile, join

# reading the vedio
readfilepath = 'C:/Users/46596/Desktop/Multi DDM/data/rgb_video/'
onlyfiles = [f for f in listdir(readfilepath) if isfile(join(readfilepath, f))]

writefilepath = 'C:/Users/46596/Desktop/Multi DDM/data/grayscale_video/'

for f in onlyfiles:
    source = cv2.VideoCapture(readfilepath+f)

    # We need to set resolutions.
    # so, convert them from float to integer.
    frame_width = int(source.get(3))
    frame_height = int(source.get(4))
    fps = source.get(cv2.CAP_PROP_FPS)

    size = (frame_width, frame_height)


    result = cv2.VideoWriter(writefilepath+f[:-4]+'.avi',
                             fourcc=cv2.VideoWriter_fourcc(*'XVID'),
                            # fourcc=40,
                             fps=fps, frameSize=size, isColor=0)

    # running the loop

    ret, img = source.read()
    while img is not None:

        # converting to gray-scale
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # write to gray-scale
        result.write(gray)

        # displaying the video
        cv2.imshow("Live", gray)

        # extracting the frames
        ret, img = source.read()

        # exiting the loop
        key = cv2.waitKey(1)
        if key == ord("q"):
            break

    # closing the window
    cv2.destroyAllWindows()
    source.release()

