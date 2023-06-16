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

Make sure the App file (defineCellROIs.mlapp) and the 2 Matlab functions (detectCells.m, registerSessions.m) in this repository are in the same folder as the 'exampleExperiment' folder.

<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/4f4e3973ee30459977e391201a5c09af57ed19ea/screenShots/exampleRegisteredProjection.png?format=1000w" height="500">
<img src="https://github.com/luismfranco/defineCellROIs/blob/4f4e3973ee30459977e391201a5c09af57ed19ea/screenShots/GUIimage.png?format=1000w" height="500">
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
<img src="https://github.com/luismfranco/defineCellROIs/blob/4f4e3973ee30459977e391201a5c09af57ed19ea/screenShots/exampleROIs.png?format=1000w" height="500">
</p>

## Refine Cell ROIs
***"This is the fun part of this app"***

Click on ``refine ROIs`` to either delete or add ROIs at will.
1. The program will automatically detect whether you draw an ROI completely enclosing an existing ROI. In which case, it will ***delete*** the existing ROI.
2. The program will also automatically detect that you draw an ROI in an area where there isn't any ROIs. In which case, it will ***add*** a new ROI.

***Important: if a new ROI is drawn partially over another ROI, then the program will keep both.
This is not ideal and must be avoided, so please be careful.***

### Adding a new ROI
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/definingNewROI.png?format=1000w" height="300">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/newROIcreated.png?format=1000w" height="300">
</p>

### Removing an existing ROI
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/removingROI.png?format=1000w" height="300">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/ROIremoved.png?format=1000w" height="300">
</p>

### Refining new ROIs after removing an existing one.
<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/refinedROI1.png?format=1000w" height="300">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/refinedROI2.png?format=1000w" height="300">
</p>

## Zoom in and Zoom out

The ``Zoom in`` and ``Zoom out`` will help you navigate the ROI map, and draw better ROIs with higher pression while zooming in.

***Warning: be careful while using Matlab's toolbar menu, it could interfere with this program's ``zoom in`` and ``zoom out`` functions.
From R2018b onwards, Matlab's toolbar menu appears when you hover over the top right part of your figure.
The most common error is that both Matlab's ``Restore View`` and this program's ``Zoom out`` stop working.***

<p align="center">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/zoomingIn1.png?format=1000w" height="500">
<img src="https://github.com/luismfranco/defineCellROIs/blob/bfc0ee3b149f5bb592735c867c9dc8542388141f/screenShots/zoomingIn2.png?format=1000w" height="500">
</p>

## Save cells
Once you are happy with your ROIs, click on ``save cells`` to save your refined ROIs.
ROI data will be saved on their original *.mat* files. If there are existing ROIs in these files, they will be overwritten.
You can save your work, close this app, and come back later to continue working on your ROIs as many times as you would like. Just make sure to load your existing ROIs after clicking on ``detect cells``.

# Example Experiment
## Data strcuture
Each file corresponds to a 15 min block --> 2 blocks per session (day) --> 5 sessions per experiment.

To visualize which fields are contained in each *.mat* file, here is an example from 'sLMF009_180911_1.mat':

     averageProjection: [750×750 double]
           activityMap: [750×750 double]
              cellROIs: {317×1 cell}
               cellDFF: [317×9050 double]
         cellResponses: [317×90×96 double]
           mazeContext: [96×1 double]
             decisions: [96×1 double]
         freeDecisions: [96×1 double]
         correctTrials: [96×1 double]
    decisionTrajectory: [119×96 double]
        trajectoryTime: [96×1 double]
      
      
