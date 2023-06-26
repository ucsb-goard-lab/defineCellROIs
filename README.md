# defineCellROIs
GUI for automated detection of cell ROIs from calcium imaging data (with manual refinement)

Example two-photon calcium imaging data can be downloaded from here: https://www.mediafire.com/folder/dtoudmlkj7y43/exampleExperiment

This code was developed to analyze two-photon calcium imaging data sampled from the same field of view across experimental sessions.
If you find this code helpful, please cite this publication: https://www.biorxiv.org/content/10.1101/2022.10.19.512933v1

# How to use

On the Command Window, in Matlab type:
``defineCellROIs(mouseName,dates,blocks)``

Example: 
``defineCellROIs('sLMF009',180911:180915,1:2)``

Make sure the app file (***defineCellROIs.mlapp***) and the two other Matlab functions (***detectCells.m***, ***registerSessions.m***) in this repository are in the same folder as the ***exampleExperiment*** folder.

<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/exampleRegisteredProjection.png?format=1000w" height="400">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/GUIimage.png?format=1000w" height="400">
</p>

## Image
The 3 sliders at the top control the color intensity displayed on the window for each data type:
1. activity --> pixel-wise kurtosis of fluorescence data.
2. projection --> registered average projection across all blocks and all sessions.
3. cells --> once they have been detected, you can adjust the intensity of ROIs. 
    
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
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/exampleROIs.png?format=1000w" height="400">
</p>

## Refine Cell ROIs
***"This is the fun part of this app"***

Click on ``refine ROIs`` to either delete or add ROIs at will.
1. The app will automatically detect that you draw an ROI completely enclosing an existing ROI. In which case, it will ***delete*** the existing ROI.
2. The app will also automatically detect that you draw an ROI in an area where there isn't any ROIs. In which case, it will ***add*** a new ROI.

***Important: if a new ROI is partially drawn over another ROI, then the app will keep both.
This is not ideal and must be avoided, so please be careful.***

### Adding a new ROI
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/definingNewROI.png?format=1000w" height="200">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/newROIcreated.png?format=1000w" height="200">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/refineCellROI.png?format=1000w" height="200">
</p>

### Removing an existing ROI
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/removingROI.png?format=1000w" height="200">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/ROIremoved.png?format=1000w" height="200">
</p>

### Refining new ROIs after removing an existing one.
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/refinedROI1.png?format=1000w" height="200">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/refinedROI2.png?format=1000w" height="200">
</p>

## Zoom in and Zoom out

The ``Zoom in`` and ``Zoom out`` will help you navigate the ROI map, and draw better ROIs with higher pression while zooming in.

***Warning: be careful while using Matlab's toolbar menu, it could interfere with this app's ``zoom in`` and ``zoom out`` functions.
From R2018b onwards, Matlab's toolbar menu appears when you hover over the top right part of your figure.
The most common error is that both Matlab's ``Restore View`` and this app's ``Zoom out`` stop working.***

<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/zoomingIn1.png?format=1000w" height="400">
<img src="https://github.com/luismfranco/defineCellROIs/blob/6d6705e414a70324ed548f7a2fb5eafc09c5f90e/screenShots/zoomingIn2.png?format=1000w" height="400">
</p>

## Save cells
Once you are happy with your ROIs, click on ``save cells`` to save your refined ROIs.
ROI data will be saved on their original *.mat* files. If there are existing ROIs in these files, they will be overwritten.
You can save your work, close this app, and come back later to continue working on your ROIs as many times as you would like. Just make sure to load your existing ROIs after clicking on ``detect cells``.

# Paths
The current version of this app is designed to work with the example experiment data. You can, however, adapt it for your own data, just make sure to update the corresponding path in ***defineCellROIs.mlapp***:

``line 89: app.rootDir = [pwd,'\exampleExperiment\'];``

# Example Experiment
## Data strcuture
Each file corresponds to a 15 min block --> 2 blocks per session (day) --> 5 sessions per experiment.

To visualize which fields are contained in each *.mat* file, here is an example from 'sLMF009_180911_1.mat':

     averageProjection: [750×750 double]
           activityMap: [750×750 double]
              cellROIs: {317×1 cell}
      
      
