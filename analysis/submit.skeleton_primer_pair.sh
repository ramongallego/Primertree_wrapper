#!/usr/bin/env bash

#SBATCH --job-name=primerTree
#SBATCH --output=primerTree.log

#SBATCH --mail-user=ramon.gallegosimon@noaa.gov
# See manual for other options for --mail-type
#SBATCH --mail-type=ALL


#SBATCH -c 20
#SBATCH -t 6000
echo this works


# Load R from modules
module load R
module load clustalo

# Move to the correct folders
#cd /home/rgallegosimon/

# Run R Script
# R CMD BATCH pipeline/Nextera_Dada2/scripts/skeleton_dada2.r "${1}"
Rscript --vanilla /home/rgallegosimon/pipeline/Primertree_wrapper/analysis/skeleton_primer_pair.R  "${1}" "${2}"
 
