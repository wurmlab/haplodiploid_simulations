#!/bin/bash
#$ -cwd
#$ -j y
#$ -N haplodiploid_h75_s001
#$ -o haplodiploid_h75_s001-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=6:0:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/haplodiploid_h75_s001.slim
