# How to print a brain in 3D

The instructions were prepared for the setup at the [Max Planck Institute for Human Development Berlin](https://www.mpib-berlin.mpg.de/en).

## Ingredients
To print a brain in 3D, you need:
* [x] A brain (obviously!), specifically: a structural / anatomical scan (T1)
* [x] A 3D printer (and someone who know how to use it)

**About the file-format of the T1:**
As you will see below, you will run Freesurfer's `recon-all` command on the T1.
Freesurfer can only process your T1, if it comes in `.nii` format.
If you still have the T1 zipped in a `nii.gz` format you need to unzip it first.
Usually, this can be most easily done by double-clicking on the file.

## Recipe

You need to run two Freesurfer commands on your T1 to get the brain in the right shape for 3D-printing:
1. `recon-all` which is [performs the FreeSurfer cortical reconstruction process](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all)
2. `mris_convert` which is a [general conversion program for converting between cortical surface file formats](https://surfer.nmr.mgh.harvard.edu/fswiki/mris_convert)


-----

### Step 1: Running Freesurfer's `recon-all`
#### Local:
* Open Terminal
	* `source /Applications/freesurfer/SetUpFreeSurfer.sh`
	* `recon -all -i <<DICOM file (any file, not folder)>> -subjid <<folder name you want to call folder for output files>> -all`
* Run analysis
	* `cd/ <<drag surf folder into terminal>>`
	* `pwd/ << surf folder>>`
	* `mris_convert lh.pial lh.pial.stl`
	* `mris_convert rh.pial rh.pial.stl`

#### Cluster:
Use the script in the `code` folder.

----

### Step 2: MeshLab

### Steps
* In the menu, go to `File` and click `Import Mesh...`
* Select both `.stl`-files created before (`lh.pial.stl` and `rh.pial.stl`)
* Click `OK`
* If window `Post-Open Processing` appears with the option `Unify Duplicated Vertices` > Click `OK`
* In the menu, go to `Filters` > `Mesh Layer` and click `Flatten Visible Layers`
* Click `Apply`
* Export as STL file: In the menu, go to `File` > `Export Mesh As` > select the `.stl`-format and save to your desired location

----

### Step 3: Print the brain

* Contact [Thomas Feg](mailto:thomas.feg@mpib-berlin.mpg.de) and ask if you can have a brain printed

## References
* https://nikkimarinsek.com/blog/how-to-3d-print-your-brain
* https://www.sculpteo.com/blog/2017/11/08/how-to-3d-print-your-own-brain-using-mri-or-ct-scans-free-software/



