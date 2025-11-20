#!/bin/bash

#SBATCH --qos bbdefault
#SBATCH --time 02:00:00 # HH:MM:SS
#SBATCH --nodes 1       # ensure the job runs on a single node
#SBATCH --ntasks 10     # this will give you circa 40G RAM and will ensure faster conversion to the .sif format
#SBATCH --constraint icelake

set -e

unset APPTAINER_BIND
apptainer build mrs_apps.sif mrs_apps.def

