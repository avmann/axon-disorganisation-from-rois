# axon-disorganisation-from-rois
Fiji macro to tabulate axon lengths and disorganisation areas of disorganised axons from roi markings

Assumptions:
- all image files are accompanied by zip files containing rois
- zip files should have the same file name as the image file (technically the expected order is image file, corresponding zip file, next pair)
- the order of roi markings is important: axon length marking via the Fiji/ImageJ line/segmented line tool should come first, then shapes (e.g. freehand, circle etc). If there are several areas of disorganisation along an axon, just add several area rois. The next axon in a roi list will be identified as starting with a line roi, all following shape rois will be interpreted as belonging to that axon.

Workflow:
- The macro will ask for input and output folders
- The macro will measure the rois
- The macro will append columns to the results table in which it assigns areas to axons and calculates area/axon length ratios.
- The results table will then be saved as a txt file with the same file name as the image.
- The macro will then move on to the next image/zip pair in the input folder
- This macro will go through all files in a folder.
