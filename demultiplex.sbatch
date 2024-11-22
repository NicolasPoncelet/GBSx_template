#!/bin/bash
#SBATCH --job-name demultiplex
#SBATCH --output slurm-%x_%j.log
#SBATCH --error slurm-%x_%j.log
#SBATCH --partition=long
#SBATCH --mem-per-cpu=10G
#SBATCH --cpus-per-task=10

# Setting up variables

ANALYSIS_DIR=path/to/my/dir 
GBSX_PATH=${ANALYSIS_DIR}/GBSX_v1.3.jar
BARCODE_FILE_PATH=${ANALYSIS_DIR}/barcode_template.txt
INPUT_DIR=${ANALYSIS_DIR}/01_Raw_data
OUTPUT_DIR=${ANALYSIS_DIR}/02_Fastq
FASTQ_R1=${INPUT_DIR}/librairie_R1.fastq.gz
FASTQ_R2=${INPUT_DIR}/librairie_R2.fastq.gz

# Setting up env

module load java-jdk/8.0.112

mkdir -p $OUTPUT_DIR

java -XX:ParallelGCThreads=10 -Xmx10G -jar $GBSX_PATH \
--Demultiplexer -f1 $FASTQ_R1 -f2 $FASTQ_R2 \
-i $BARCODE_FILE_PATH -gzip true -o $OUTPUT_DIR
