# axon-disorganisation-from-rois
Fiji macro to tabulate axon lengths and disorganisation areas of disorganised axons from roi markings

The macro assumes that image files are accompanied by zip files containing rois. The zip files should have the same file name as the image file (technically the expected order is image file, corresponding zip file, next pair).
The order of roi markings is important: axon length marking via the Fiji/ImageJ line/segmented line tool should come first, then shapes (e.g. freehand, circle etc). If there are several areas of disorganisation along an axon, just add several area rois. The next axon in a roi list will be identified as starting with a line roi, all following shape rois will be interpreted as belonging to that axon.

The macro will create a results table and append columns in which it assigns areas to axons and calculates area/axon length ratios.

The results table will then be saved as a txt file with the same file name as the image.

This macro will go through all files in a folder.
