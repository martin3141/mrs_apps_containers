# Build files and instructions for "containerised" MRS analysis tools

## Apptainer

`mrs_apps.def` contains the build instructions for R, spant and select components of FSL to perform basic brain segmentation.

To build on UOB BEAR :

`sbatch build_mrs_apps_bear.sh`

takes around 40 minutes due to need to compile R libraries on Linux.

Once built with the above method, R package versions are fixed within the container. R packages can be updated after the build process, but will be installed into the R user library on the host. The user library path is set to $HOME/R/apptainer/PLATFORM_R-VERSION and will take precedence over the containerised versions.

To update to the latest stable spant version :

`apptainer exec mrs_apps.sif Rscript -e "install.packages('spant', dependencies = TRUE)"`

To update to the latest development version :

`apptainer exec mrs_apps.sif Rscript -e "remotes::install_github('martin3141/spant', ref = 'devel', dependencies = TRUE)"`
