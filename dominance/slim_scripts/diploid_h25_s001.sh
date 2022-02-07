#!/bin/bash
#$ -cwd
#$ -j y
#$ -N diploid_h25_s001
#$ -o diploid_h25_s001-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=1:0:0
#$ -t 1-200
#$ -tc 200

$HOME/2021-10-slim_dev/build/slim slim_scripts/diploid_h25_s001.slim
