#!/bin/bash
#$ -cwd
#$ -j y
#$ -N diploid_h75_s001
#$ -o diploid_h75_s001-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=0:30:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/diploid_h75_s001.slim
