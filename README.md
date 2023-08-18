# Multi-DDM Analysis

This file provides a simple guide to running multi-DDM on a series of videos, using the enclosed MATLAB functions. While the code in this package has been developed to analyse videos of ciliated epithelia at ALI culture, multi-DDM is a far more general technique that can be employed in a variety of scenarios.

This code submission is part of the Supplementary Information to the following publication:

* Chioccioli, M.\*, Feriani, L.\*, Kotar, J., Bratcher, P. E.†, Cicuta, P.†,
"Phenotyping ciliary dynamics and coordination in response to CFTR-modulators in Cystic Fibrosis respiratory epithelial cells",
*Nature Communications* (2019).


The paper that first introduces multi-DDM is instead:

* [Feriani, L., et al.,
"Assessing the Collective Dynamics of Motile Cilia in Cultures of Human Airway Cells",
*Biohpysical Journal*, (2017).](https://doi.org/10.1016/j.bpj.2017.05.028)


## Installation

This code depends on a few MATLAB toolboxes. You will need:
* Image Processing Toolbox
* Parallel Computing Toolbox
* Curve Fitting Toolbox
* Signal Processing Toolbox

Once you've made sure the dependencies above are satisfied, download or clone this repository, then [add the repository's folder (and its subfolders) to your MATLAB path](https://uk.mathworks.com/help/matlab/ref/addpath.html).

## Multi-DDM on raw videos

In the first step in the analysis pipeline, multi-DDM is run on each of the (input) raw videos independently. At the end of this step there will be a MATLAB `.mat` file for each of the input video files, containing the results of multi-DDM.

To do this, run the function `Analyse_Epithelix_func`. This will open a GUI where you can set:
* The path to the data folder. This contains the raw videos
* A filtering string, so you can select only the files in the data folder that you intend to analyse. This filtering string is set by default to select files in the `.movie` video format, developed by Dr Jurij Kotar and widely used in Prof Pietro Cicuta's group at the Cavendish Laboratory. You will need to change it to select the format of your video files.
* The path to the analysis (output) folder. This is where the results `.mat` files will be saved to. The default analysis folder path is obtained by appending `_Analysis` to the data folder path.
* The type of analysis. This selects the size of the tiles that are used by multi-DDM. By selecting an analysis type you can preview in the panel on the right the size of the tiles (in pixels) that will be employed by the analysis algorithm. By selecting `custom`, you will be able to directly input an array of tile sizes for the analysis.

**Note:**
The software was developed, and mostly used, to analyse high speed
microscopy videos of Human Airway Epithelial Cells at the Air Liquid Interface.
While the software is tweaked to cope with `.movie` files, it has provisions for analysing other types of video files. In particular, it should work with files that can be opened with MATLAB's own `VideoReader`.  
**New:** Support for bioformat videos is being added. At the moment, only single-channel, greyscale videos are supported, but this can be improved if there is interest. Shout out to Dr. Elvis Pandzic from University of New South Wales for his help (and for sharing his code, that I've integrated here). 

**Note:**
The software automatically parses the file name looking for an indication of what magnification was used. 
In particular, the code looks for strings like `20X`, `40X` (in general, a number - decimals are allowed - followed by the letter `x`, or `X`).
This is used then to set the px->µm conversion. Out of the box, this value would only be correct on the setup described in the main text of the manuscript: Nikon Eclipse Ti-E inverted microscope (Nikon, Japan), Grasshopper®3 GS3-U3-23S6M-C CMOS camera (FLIR Integrated Imaging Solutions GmbH, Germany). 
To fix this, in the file `./parameters/calibrated_magnifications.json` you should modify the magnification -> µm/px values.


## Data aggregation

In the second step of the pipeline the results from the individual video files (contained in individual `.mat` files) are aggregated by the function `./multiddm_functions/populate_DDM_Sigmoids_struct.m` in an array of structures. This function allows to organise your experiments data by:
* sample type
* time point
* donor (subject)
* insert (for technical replicates)
* position (useful if the microscope returns to the same position in the sample cyclically over time)

An example of how to correctly invoke `./multiddm_functions/populate_DDM_Sigmoids_struct.m` is provided in the script `prepare_accumdata_for_sigmoids.m`. The script is well commented and explains how to set up correctly the input variables for the aggregating function. The script also shows how to save the array of structures containing the aggregated results in a single `.mat` file.


## Plotting

In the last step of the analysis we extract individual sets of results from the aggregated results' `.mat` file and plot a distribution of Ciliary Beat Frequency and the curve that, in ALI culture ciliated epithelia, shows how the degree of coordination amongst cilia decays as we assess larger tiles.

The example script `plot_data.m` shows how to select data from the aggregated results' `.mat` file and plot the CBF distribution and the sigmoidal curve that allows to calculate the length scale of coordination.

**Note:**
The two plotting functions uploaded in this package could be expanded in functionality in order to directly compare multiple sets of results (i.e., two different sample types, or timepoints).
An example of this is in the figures of the publication this code is supplementary information of.
However the code thus developed was quite specialised towards a particular
task, and possibly less flexible and adaptable to the needs of other users. For this reason we preferred to provide a simpler plotting interface that would be a useful starting point to any user of multi-DDM.

## Updates & Enhancements

The following are significant updates and changes added to the Multi-DDM Analysis project:

### Video Preprocessing:
- Introduced `RGB_to_Grayscale.m` and `RGB_to_Grayscale.py`, enabling users to convert RGB videos to grayscale, making it more conducive for analysis.

### Enhanced FFT Analysis:
- Updates in `multiddm_functions/DDM_Analysis.m` and `multiddm_functions/multiDDM_core.m` now include an output for `NonEvgIqtau`—the average FFT of all frame differences with lag time tau that hasn't been azimuthally averaged. This crucial enhancement retains the wave information of different video directions.

### Directional Plotting & Analysis:
- The new `plotting_files` directory encapsulates the following advancements:
  - `integrated_processing.mlx`: Automates the iteration through all DDM_analysis result `.mat` files in a directory, extracts `NonEvgIqtau` to produce a corresponding `*_NonEvgIqtau.mat` file, and then calculates the directioned `Iqtau` to generate a `*_NonEvgIqtau_angle_Iqtau.mat` file.
  - Use `create_angle_mask_list.m` and `create_distance_map.m` to generate directional masks pivotal for the creation of `*_NonEvgIqtau_angle_Iqtau.mat`. The resultant masks are visualized as `.jpg` files in the `plotting_files/mask_plot/` directory.
  - A modifiable fit function is provided in `fit_function.m` for tailored data fitting.
  - Dedicated plotting scripts (`cilia_plot_directioned_Iqtau.mlx`, `circle_plot_directioned_Iqtau.mlx`, etc.) are available for different video categories such as cilia, synthetic waves, wheat videos, and more.

### Technical Analysis:
- `technical_analysis/Copy_of_read_mat_file.m`: Extracts major information from the DDM analysis result of a collection of videos and summarizes the data into a `.csv` file. Attributes like Filename, Height, Width, and others are conveniently captured.
  - Summarized data for specific video categories like videos captured using a DJI drone, videos from Finland, and Nottingham are also available in `technical_analysis/DJI_videos.csv`, `technical_analysis/finn_videos.csv`, and `technical_analysis/nott_videos.csv` respectively.

## DDM Project Pseudo Code Overview
To aid in understanding the DDM project's structure and flow, we've provided a pseudo code blueprint. This gives a clear, high-level representation of the project's core logic, ideal for both new and existing contributors.

![multi_ddm_plot](https://github.com/zhangyuyi99/multi-DDM/assets/57507104/fcfa04b7-a949-4d99-8064-1884bb574c77)


## Common issues and troubleshooting

### Undefined function error
e.g.:
```
Undefined function 'cprintf' for input arguments of type 'char'.
```
### Solution
`cprintf` is the first non-standard function called by `Analyse_Epithelix_func.m`. It is defined in the `common_function` folder. [Make sure you've added *all the folders and subfolders* to the MATLAB path persistently](https://uk.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html).
