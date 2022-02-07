#!/bin/bash
#$ -cwd
#$ -j y
#$ -N diploid_h0_s-010
#$ -o diploid_h0_s-010-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=1:0:0
#$ -t 1-200
#$ -tc 200

$HOME/2021-10-slim_dev/build/slim slim_scripts/diploid_h0_s-010.slim
