#!/bin/bash
#SBATCH -J GPUVersion
#SBATCH -A uoa00243         # Project Account
#SBATCH --time=00:05:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu 
#SBATCH --gres=gpu:1        # Number of GPUs
ml Python/2.7.9-intel-2015a
srun LD_PRELOAD=/share/easybuild/RHEL6.3/sandybridge/software/CUDA/6.5.14/lib64/libnvblas.so python matmulti2.py
