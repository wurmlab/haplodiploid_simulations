#!/bin/bash
#$ -cwd
#$ -j y
#$ -N diploid_h0_s000
#$ -o diploid_h0_s000-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=1:0:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/diploid_h0_s000.slim
