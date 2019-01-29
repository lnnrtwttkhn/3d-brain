#!/usr/bin/bash
# ==============================================================================
# SCRIPT INFORMATION:
# ==============================================================================
# SCRIPT: RUN FREESURFER TO CREATE A 3D BRAIN ON THE CLUSTER
# WRITTEN BY LENNART WITTKUHN, 2019
# CONTACT: WITTKUHN AT MPIB HYPHEN BERLIN DOT MPG DOT DE
# MAX PLANCK RESEARCH GROUP NEUROCODE
# MAX PLANCK INSTITUTE FOR HUMAN DEVELOPMENT
# MAX PLANCK UCL CENTRE FOR COMPUTATIONAL PSYCHIATRY AND AGEING RESEARCH
# LENTZEALLEE 94, 14195 BERLIN, GERMANY
# ==============================================================================
# path to the current shell script:
PATH_SCRIPT=$HOME/tools/3D_brain
# cd into the directory of the current script:
cd "${PATH_SCRIPT}"
# path to the input directory:
PATH_INPUT="$HOME/3D_brain/input"
# get input of the current subject
SUBJECT=$1
# path to the input file:
PATH_FILE="$PATH_INPUT/$SUBJECT.nii"
# path to the output directory
PATH_OUTPUT="$HOME/3D_brain/output"
# The freesurfer import location
SUBJECTS_DIR="$HOME/3D_brain/output" 
# path to the log directory:
PATH_LOG="$HOME/logs/3D_brain"
# ==============================================================================
# CREATE RELEVANT DIRECTORIES:
# ==============================================================================
# create output directory:
if [ ! -d ${PATH_OUT} ]; then
	mkdir -p ${PATH_OUT}
fi
# create working directory:
if [ ! -d ${PATH_WORK} ]; then
	mkdir -p ${PATH_WORK}
fi
# create directory for log files:
if [ ! -d ${PATH_LOG} ]; then
	mkdir -p ${PATH_LOG}
fi
# ==============================================================================
# DEFINE PARAMETERS:
# ==============================================================================
# maximum number of cpus per process:
N_CPUS=1
# memory demand in *GB*
MEM_GB=2
# memory demand in *MB*
MEM_MB="$((${MEM_GB} * 1000))"
# ==============================================================================
# RUN FREESURFER RECON ALL
# ==============================================================================
# name of the job
echo "#PBS -N freesurfer_recon_all_$SUBJECT" >> job
# set the expected maximum running time for the job:
echo "#PBS -l walltime=35:00:00" >> job
# determine how much RAM your operation needs:
echo "#PBS -l mem=${MEM_GB}GB" >> job
# email notification on abort/end, use 'n' for no notification:
echo "#PBS -m n" >> job
# write (output) log to log folder 
echo "#PBS -o ${PATH_LOG}" >> job
# write (error) log to log folder
echo "#PBS -e ${PATH_LOG}" >> job
# request multiple cpus
echo "#PBS -l nodes=1:ppn=${N_CPUS}" >> job
# load freesurfer:
echo "module load freesurfer" >> job
echo "export FREESURFER_HOME=/opt/freesurfer/5.3.0" >> job
echo "source \$FREESURFER_HOME/SetUpFreeSurfer.sh" >> job
echo "export SUBJECTS_DIR=$SUBJECTS_DIR" >> job
# define the freesurfer command:
echo "recon-all -all -i $PATH_FILE -subjid $SUBJECT" >> job
# submit job to cluster queue and remove it to avoid confusion:
qsub job
rm -f job
