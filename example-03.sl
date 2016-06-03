#!/bin/bash
#SBATCH -J TunedVersion
#SBATCH -A uoa00243         # Project Account
#SBATCH --time=00:05:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu
#SBATCH -C avx              # Require a processor with AVX for MKL
ml Python/2.7.9-intel-2015a
srun python matmulti2.py
