#!/usr/bin/bash
# ==============================================================================
# SCRIPT INFORMATION:
# ==============================================================================
# SCRIPT: RUN FREESURFER TO CREATE A 3D BRAIN ON THE CLUSTER
# WRITTEN BY LENNART WITTKUHN, 2019 - 2020
# CONTACT: WITTKUHN AT MPIB HYPHEN BERLIN DOT MPG DOT DE
# MAX PLANCK RESEARCH GROUP NEUROCODE
# MAX PLANCK INSTITUTE FOR HUMAN DEVELOPMENT
# MAX PLANCK UCL CENTRE FOR COMPUTATIONAL PSYCHIATRY AND AGEING RESEARCH
# LENTZEALLEE 94, 14195 BERLIN, GERMANY
# ==============================================================================
# path to this directory (assuming you cloned to home)
PATH_ROOT="${HOME}/3d_brain"
# path to the input directory:
PATH_INPUT="${PATH_ROOT}/input"
# path to the output directory
PATH_OUTPUT="${PATH_ROOT}/output"
# path to the freesurfer import location
SUBJECTS_DIR="${PATH_ROOT}/output"
# path to the log directory:
PATH_LOG="${PATH_ROOT}/logs"
# get input of the current subject
INPUT_FILE=$1
# path to the input file:
PATH_FILE="${PATH_INPUT}/${INPUT_FILE}"
# ==============================================================================
# CREATE RELEVANT DIRECTORIES:
# ==============================================================================
# create output directory:
if [ ! -d ${PATH_OUTPUT} ]; then
	echo "created output directory: ${PATH_OUTPUT}"
	mkdir -p ${PATH_OUTPUT}
fi
# create directory for log files:
if [ ! -d ${PATH_LOG} ]; then
	echo "created logs directory: ${PATH_LOG}"
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
# create new job
echo "#!/bin/bash" > job
# name of the job
echo "#SBATCH --job-name freesurfer_recon_all_{$SUBJECT}" >> job
# set the slurm partition
echo "#SBATCH --partition short" >> job
# set the expected maximum running time for the job:
echo "#SBATCH --time 35:00:00" >> job
# determine how much RAM your operation needs:
echo "#SBATCH --mem ${MEM_GB}GB" >> job
# email notification on abort/end:
echo "#SBATCH --mail-type NONE" >> job
# write log to log folder
echo "#SBATCH --output ${PATH_LOG}/freesurfer-{$SUBJECT}-%j.out" >> job
# request multiple cpus
echo "#SBATCH --cpus-per-task ${N_CPUS}" >> job
# set working directory
echo "#SBATCH --workdir ." >> job
# load freesurfer:
echo "module load freesurfer" >> job
echo "export FREESURFER_HOME=/opt/freesurfer/5.3.0" >> job
echo "source \$FREESURFER_HOME/SetUpFreeSurfer.sh" >> job
echo "export SUBJECTS_DIR=$SUBJECTS_DIR" >> job
# define the freesurfer command:
echo "recon-all -all -i $PATH_FILE -subjid $SUBJECT" >> job
# submit job to cluster queue and remove it to avoid confusion:
sbatch job
rm -f job
