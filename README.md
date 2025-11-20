# Build files and instructions for "containerised" MRS analysis tools

## Apptainer

`mrs_apps.def` contains a build recipe for [R](https://www.r-project.org/), [spant](https://martin3141.github.io/spant/index.html) and select components of [FSL](https://fsl.fmrib.ox.ac.uk/fsl/docs/) ([BET](https://fsl.fmrib.ox.ac.uk/fsl/docs/structural/bet.html) and [FAST](https://fsl.fmrib.ox.ac.uk/fsl/docs/structural/fast.html)) to perform standard brain tissue segmentation. The base OS is Ubuntu 24.04.

To build on UOB HPC facilities [BlueBEAR](https://www.birmingham.ac.uk/research/arc/bear/bluebear) :

```
wget https://github.com/martin3141/mrs_apps_containers/raw/refs/heads/main/mrs_apps.def
wget https://github.com/martin3141/mrs_apps_containers/raw/refs/heads/main/build_mrs_apps_bear.sh
sbatch build_mrs_apps_bear.sh
```

The build process takes around 40 minutes (mainly due to need to compile R libraries on Linux) and generates the Apptainer container file `mrs_apps.sif`. Common usage involves running an R script within the container environment :

```
apptainer exec mrs_apps.sif Rscript MY_RSCRIPT.R
```

For non-trival tasks, this command should be embedded in a Slurm job script and submitted to the cluster in the usual way with the `sbatch` command. See below for an example job script :

```
#!/bin/bash

#SBATCH --ntasks 4
#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#
#              d-hh:mm:ss
#SBATCH --time 0-01:00:00
#
#SBATCH --account MY_ACCOUNT
#SBATCH --qos bbdefault

set -e

module purge; module load bluebear

apptainer exec mrs_apps.sif Rscript MY_RSCRIPT.R
```

Once built with the above method, R package versions are fixed within the container. R packages may be updated after the build process, but will be installed into the R user library on the host. The user library path is set to $HOME/R/apptainer/PLATFORM_R-VERSION and will take precedence over the containerised versions.

To update to the latest stable spant version :

`apptainer exec mrs_apps.sif Rscript -e "install.packages('spant', dependencies = TRUE)"`

To update to the latest development version :

`apptainer exec mrs_apps.sif Rscript -e "remotes::install_github('martin3141/spant', ref = 'devel', dependencies = TRUE)"`






