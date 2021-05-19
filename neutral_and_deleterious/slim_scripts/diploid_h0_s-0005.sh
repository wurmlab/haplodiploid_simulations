#!/bin/bash
#$ -cwd
#$ -j y
#$ -N diploid_h0_s-0005
#$ -o diploid_h0_s-0005-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=0:30:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/diploid_h0_s-0005.slim
