#!/bin/bash
#$ -cwd
#$ -j y
#$ -N haplodiploid_h0_s-001
#$ -o haplodiploid_h0_s-001-output/
#$ -m s
#$ -pe smp 1
#$ -l h_vmem=500M
#$ -l h_rt=2:0:0
#$ -t 1-200
#$ -tc 200

module load slim

slim slim_scripts/haplodiploid_h0_s-001.slim
