#!/bin/bash
#$ -cwd
#$ -j y
#$ -N haplodiploid_h0_s-010
#$ -o haplodiploid_h0_s-010-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=0:30:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/haplodiploid_h0_s-010.slim
