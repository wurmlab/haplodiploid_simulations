#!/bin/bash
#$ -cwd
#$ -j y
#$ -N haplodiploid_h0_s010
#$ -o haplodiploid_h0_s010-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=6:0:0
#$ -t 1-200
#$ -tc 200

$HOME/2021-10-slim_dev/build/slim slim_scripts/haplodiploid_h0_s010.slim
