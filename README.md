# defineCellROIs
GUI for automated detection of cell ROIs from calcium imaging data (with manual refinement).

This GUI was developed to analyze two-photon calcium imaging data sampled from the same field of view across experimental sessions.
The GUI also includes code for calculating the stability of ROIs across experimental sessions.

If you find this code helpful, please cite this publication: https://www.nature.com/articles/s41467-024-51227-7

Example two-photon calcium imaging data can be downloaded from here: https://datadryad.org/stash/dataset/doi:10.5061/dryad.7pvmcvf2z

***Important: this app requires Matlab's Image Processing Toolbox.***

<br />

# How to use

On the Command Window, in Matlab, type:
``defineCellROIs(mouseName,dates,blocks)``

Example: 
``defineCellROIs('sLMF009',180911:180915,1:2)``

Just make sure:
1. the app file: ***defineCellROIs.mlapp***
2. the accompanying Matlab functions: ***registerSessions.m***, ***detectCells.m***, ***calculateROIStability.m***
3. and the ***exampleExperiment*** folder containing the sample calcium imaging data

are all in the same folder.

<p align="center">
<img width="400" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/exampleRegisteredProjection.png">
<img width="200" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/GUIimage.png">
</p>

***Warning: closing the field of view window by clicking on the 'x' at the top right corner results in a number of errors on Matlab's Command Window.***

This happens because several functions in this app require that field of view window to work properly. The app might still retain limited functionality. For instance, you might still be able to save your ROIs, or calculate ROI stability, but this is not desirable and should be avoided. So, if you close the field of view by mistake, please close the app, and run it again using:*** ``defineCellROIs(mouseName,dates,blocks)``

To properly close this app, please click on the 'x' at the top right corner of the GUI. This will close both, the GUI and the field of view window.

<br />

## Field of View
The 3 sliders at the top control the color intensity displayed on the window for each data type:
1. activity --> pixel-wise kurtosis of fluorescence data.
2. projection --> registered average projection across all blocks and all sessions.
3. cells --> once they have been detected, you can adjust the intensity of ROIs.

<br />
    
## Automated Cell Detection 

Adjust parameters for automated cell detection. For details, please read: ***detectCells.m***.

Some parameters are related to window size and disk radius for filtering the activity map. Other are related to activity threshold and offset,
which probably don't require optimization for many different two-photon calcium imaging experiments.

However, the minimum and maximum size for ROIs (***minPixels***, ***maxPixels***) are more important.
These parameters must be updated to match the expected size of your cells (in pixels).
Different optical/digital zoom and different cell types will affect this parameters.

The ``detect cells`` button will do just that --> automatically detect cells based on the activity (kurtosis) map.
The data in the exampleExperiment has been analyzed already. Thus, it contanins refined ROI data.
``detect cells`` will recognized this and ask whether you would like to load those refined ROIs.

Please try both options:
1. *Yes* --> load refined ROIs.
2. *No* --> detect ROIs from scratch. 

You can quickly jump between the 2 options by clicking on the ``reset`` button at the bottom left of the GUI.

<p align="center">
<img width="400" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/exampleROIs.png">
<img width="200" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/GUIimage.png">
</p>

<br />

## Refine Cell ROIs

***"This is the fun part of this app"***

Click on ``refine ROIs`` to either delete or add ROIs at will.
1. The app will automatically detect that you draw an ROI completely enclosing an existing ROI. In which case, it will ***delete*** the existing ROI.
2. The app will also automatically detect that you draw an ROI in an area where there isn't any ROIs. In which case, it will ***add*** a new ROI.

***Important: if a new ROI is partially drawn over another ROI, then the app will keep both.
This is not ideal and must be avoided, so please be careful.***

<p align="center">
<img width="200" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/refineCellROI.png">
</p>

### Adding a new ROI

<p align="center">
<img width="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/definingNewROI.png">
<img width="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/newROIcreated.png">
</p>

### Removing an existing ROI

<p align="center">
<img awidth="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/removingROI.png">
<img width="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/ROIremoved.png">
</p>

### Refining new ROIs after removing an existing one

<p align="center">
<img width="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/refinedROI1.png">
<img width="200" height="200" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/refinedROI2.png">
</p>

<br />

## Zoom in and Zoom out

The ``Zoom in`` and ``Zoom out`` will help you navigate the ROI map, and draw better ROIs with higher pression while zooming in.

***Warning: be careful while using Matlab's toolbar menu, it could interfere with this app's ``zoom in`` and ``zoom out`` functions.
From R2018b onwards, Matlab's toolbar menu appears when you hover over the top right part of your figure.
The most common error is that both Matlab's ``Restore View`` and this app's ``Zoom out`` stop working.***

<p align="center">
<img width="400" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/87930b312e99a27c96d4142e951496c790b7f078/screenShots/zoomingIn1.png">
<img width="200" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/zoomingIn2.png">
</p>

<br />

## Save Cell Data
Once you are happy with your ROIs, click on ``save`` to save your refined ROIs.
ROI data will be saved on their original *.mat* files. If there are existing ROIs in these files, they will be overwritten.
You can save your work, close this app, and come back later to continue working on your ROIs as many times as you would like. Just make sure to load your existing ROIs after clicking on ``detect cells``.

<br />

## ROI Stability

If you want to know how stable your ROIs are across experimental sessions, you can do that by clicking on ``calculate``.
This function will calculate the structural similarity index and the 2-D correlation coefficient for each ROI, using the first experimental session as reference, and comparing it to its ROI in all other experimental sessions. It will also generate a random distribution for each metric by comparing the original ROI in the first experimental session to a random ROI in the other experimental sessions within the same field of view. 

<p align="center">
<img width="200" height="400" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/calculateROIStability.png">
</p>

***Warning: this process takes approximately 3 s for each ROI comparison between two experimental sessions. For instance, if you have 300 ROIs imaged across 5 experimental sessions, this code will take 3 s x 300 x 4 sessions = 60 min (considering the first session as reference). Thus, we strongly recommend that you save your ROIs before calculating their stability.***

<p align="center">
<img width="400" height="170" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/fb96255e84074e7b3171b2096f37065a1df15163/screenShots/calculateROIStabilityWarning.png">
</p>

<br />

Once it's done, data are automatically saved in ***cellROIData.m***:
1. cellROIError --> ROIs x other experimental sessions x similarity metrics.
2. cellROIRandomizedError --> ROIs x random distribution x other experimental sessions x similarity metrics.

With these data you can later choose any desirable confidence level to label an ROI as *stable*. For instance, ROIs whose true structural similarity index is higher than the 95 percentile of its random distrubition can be consider stable for a specific session-to-session comparison. This is, in fact, the criteria used by this app to display the number of stable ROIs across sessions:

<p align="center">
<img width="400" height="210" src="https://github.com/ucsb-goard-lab/defineCellROIs/blob/c62eefd47c15b784f9ffec9bb91ad03be4369bc8/screenShots/ROIStabilityFinishedMessage.png">
</p>

You are, of course, free to choose a different metric or threshold to label ROIs with enough session-to-session stability using the data saved in ***cellROIData.m***.

<br />

# Paths
The current version of this app is designed to work with the example experiment data. You can, however, adapt it for your own data, just make sure to update the corresponding path in ***defineCellROIs.mlapp***:

``line 98: app.rootDir = [pwd,'\exampleExperiment\'];``

<br />

# Example Experiment
## Data structure
Each file corresponds to a 15 min block --> 2 blocks per session (day) --> 5 sessions per experiment.

To visualize which fields are contained in each *.mat* file, here is an example from 'sLMF009_180911_1.mat':

     averageProjection: [750×750 double]
           activityMap: [750×750 double]
              cellROIs: {317×1 cell}
      
      
