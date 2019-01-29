# 3d brain

## How to print a brain in 3D

### 1. Freesurfer `recon-all`
#### Running Freesurfer's `recon-all` locally:
* Open Terminal
	* `source /Applications/freesurfer/SetUpFreeSurfer.sh`
	* `recon -all -i <<DICOM file (any file, not folder)>> -subjid <<folder name you want to call folder for output files>> -all`
* Run analysis
	* `cd/ <<drag surf folder into terminal>>`
	* `pwd/ << surf folder>>`
	* `mris_convert lh.pial lh.pial.stl`
	* `mris_convert rh.pial rh.pial.stl`

### 2. MeshLab

#### Steps
* In the menu, go to `File` and click `Import Mesh...`
* Select both `.stl`-files created before (`lh.pial.stl` and `rh.pial.stl`)
* Click `OK`
* If window `Post-Open Processing` appears with the option `Unify Duplicated Vertices` > Click `OK`
* In the menu, go to `Filters` > `Mesh Layer` and click `Flatten Visible Layers`
* Click `Apply`
* Export as STL file: In the menu, go to `File` > `Export Mesh As` > select the `.stl`-format and save to your desired location

### 3. Print a brain

* Contact [Thomas Feg](mailto:thomas.feg@mpib-berlin.mpg.de) and ask if you can have a brain printed

## References
* https://nikkimarinsek.com/blog/how-to-3d-print-your-brain
* https://www.sculpteo.com/blog/2017/11/08/how-to-3d-print-your-own-brain-using-mri-or-ct-scans-free-software/

