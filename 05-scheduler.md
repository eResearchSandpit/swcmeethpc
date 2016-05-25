# Using the SLURM scheduler

Large high-performance computers consist of many nodes with many processors, and they can (and should) be used by many people at the same time. If everyone had to use the same computer interactively as we just did, performance would be very poor - it could happen that another user takes over the machine by launching a job that uses all available processors and memory. This problem is solved by using so-called schedulers.

Schedulers, such as `SLURM`, know how many computers, how many processors, and how much memory is avaible on a large HPC system, and how many users want to run jobs. They take into account resource requirements for each of these jobs and try to optimise utilisation of the machine by running many small jobs in parallel, and by reserving resources for large jobs.

We need to tell `SLURM` what our resource requirements are, and how it can launch our program. This is usually done using a so-called "submission script". Let's look at an example:
```
[user@build-sb swcmeethpc]$ cat example-01.sl
```
~~~ {.output}
#!/bin/bash
#SBATCH -J DefaultSystemVersion
#SBATCH -A uoa00243         # Project Account
#SBATCH --time=00:05:00     # Walltime
#SBATCH --mem-per-cpu=1G    # memory/cpu
srun python matmulti1.py
~~~
This is simply a shell script with a few extra instructions that we call "directives". The first line tells `SLURM` that it should use the `bash` shell when interpreting this script. The following lines that start with `#SBATCH` set a job name, a project account against which the consumed computer time will be charged, the maximum runtime that we expect, and our memory requirements. The last line tells `SLURM` how to run our job; `srun` is needed to clarify that the command should be executed on the compute node that was allocated by `SLURM`.

We can now submit the job using the following command:
```
[user@build-sb swcmeethpc]$ sbatch --reservation=edu example-01.sl
```
~~~ {.output}

~~~


squeue