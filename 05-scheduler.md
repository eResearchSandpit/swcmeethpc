# Using the SLURM scheduler

Large high-performance computers consist of many individual computers (called "compute nodes"") with many processors, and they can (and should) be used by many people at the same time. If everyone had to use the same computer interactively as we just did, performance would be very poor - it could happen that another user takes over the machine by launching a job that uses all available processors and memory. This problem is solved by using so-called schedulers.

Schedulers, such as `SLURM`, know how many computers, how many processors, and how much memory is avaible on a large HPC system, and how many users want to run jobs. They take into account resource requirements for each of these jobs and try to optimise utilisation of the machine by running many small jobs in parallel, and by reserving resources for large jobs. For this reason, jobs are first sent to a queue where they wait until there is sufficient capacity to run the job.

We need to help `SLURM` understand our resource requirements and how to launch our program. This is usually done using a so-called "submission script". Let's look at an example:
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
This is simply a shell script with a few extra instructions that we call "directives". The first line tells the computer to use the `bash` shell when interpreting this script. The following lines that start with `#SBATCH` use `SLURM` directives to set a job name, a project account against which the consumed computer time will be charged, the maximum runtime that we expect, and our memory requirements. The last line tells `SLURM` how to run our job; `srun` is needed to clarify that the command should be executed on the compute node that was allocated by `SLURM`.

We can submit the job to `SLURM` using the following command:
```
[user@build-sb swcmeethpc]$ sbatch --reservation=swc example-01.sl
```
~~~ {.output}
Submitted batch job 31632453
~~~
`SLURM` tells us that our job has entered the queue with ID number "31632453".

We can look at all jobs that are currenlty in the queue by running the command:
```
[user@build-sb swcmeethpc]$ squeue
```
This will probably produce a very long list - there are a lot of users running on a large HPC! To narrow down this list a bit, we can ask `SLURM` specifically about our job using the ID number we were given:
```
[user@build-sb swcmeethpc]$ squeue -j 31632453
```
~~~ {.output}
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
          31632453      high DefaultS     user  R       0:21      1 compute-a1-002
~~~
Let's have a look at the output: "JOBID" is our ID number. "PARTITION" is the name of our particular queue (`SLURM` can handle several queues for, e.g., jobs that require a lot memory or GPUs, or high-priority jobs). "NAME" repeats the name that we set using the `#SBATCH -J` directive, and "USER" tells us which user submitted the job. "ST" is short for "STATUS" and tells us if a submitted job is waiting in the queue ("PD" for pending), if it is running ("R" for running), and more. The "TIME" field counts job runtime, and "NODES" and "NODELIST" tell us on how many nodes we are runnning, and which ones these are, or the reason why a job is not running yet.

Unlike running a program directly ("interactively"), we will not see any output from our Python program on the command line. It will run on one of the many computers ("nodes") of the cluster as soon as there is sufficient vacancy. `SLURM` will collect any output and write it into a text file that ends with the ".out" suffix:
```
[user@build-sb swcmeethpc]$ ls *.out
```
~~~ {.output}
slurm-31632453.out
~~~
Note that our job ID number was used for the output file name; it is also possible to set an output file name using a `#SBATCH` directive.

The file contains the output that we would have seen if we had run the program interactively:
```
[user@build-sb swcmeethpc]$ cat slurm-31632453.out
```
~~~ {.output}
Nested for loops:  8.28628749847
~~~
