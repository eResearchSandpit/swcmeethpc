#!/bin/bash
#SBATCH -J DefaultSystemVersion
#SBATCH -A uoa00243         # Project Account
#SBATCH --time=00:05:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu 
srun python matmulti1.py
