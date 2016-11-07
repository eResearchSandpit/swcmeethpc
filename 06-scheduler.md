# Using the LoadLeveler scheduler

Large high-performance computers consist of many individual computers (called "compute nodes"") with many processors, and they can (and should) be used by many people at the same time. If everyone had to use the same computer interactively as we just did, performance would be very poor - it could happen that another user takes over the machine by launching a job that uses all available processors and memory. This problem is solved by using so-called schedulers.

Schedulers, such as LoadLeveler, know how many computers, how many processors, and how much memory is avaible on a large HPC system, and how many users want to run jobs. They take into account resource requirements for each of these jobs and try to optimise utilisation of the machine by running many small jobs in parallel, and by reserving resources for large jobs. For this reason, jobs are first sent to a queue where they wait until there is sufficient capacity to run them.

We need to help LoadLeveler understand our resource requirements and how to launch our program. This is usually done using a so-called "submission script". Let's look at an example:
```
-bash-4.2$ cat run_python_matmulti1.ll
```
~~~ {.output}
#!/bin/bash

#
# Scheduler directives
#

# @ job_name = python-example
# @ class = General
# @ account_no = myaccount
# @ job_type = parallel
# @ notification = never
# @ wall_clock_limit = 00:05:00
# @ node_usage = shared
# @ total_tasks = 1
# @ node = 1
# @ network.MPI = sn_all, shared, US
# @ output = $(job_name)_$(jobid).out
# @ error = $(job_name)_$(jobid).err
# @ resources = ConsumableMemory(100Mb)
# @ queue

#
# Job script
#

# Set up default NIWA environment
. /etc/profile.niwa

# Load Python 2.7.5
module load python/2.7.5

# Run example program
python matmulti1.py
~~~
This is simply a shell script with a few extra instructions that we call "directives". The first line tells the computer to use the `bash` shell when interpreting this script. The following lines that start with `# @` use LoadLeveler directives to set a job name, a project account against which the consumed computer time will be charged, the maximum runtime that we expect, our memory requirements, and more.

We can submit the job to LoadLeveler using the following command:
```
-bash-4.2$ llsubmit run_python_matmulti1.ll
```
~~~ {.output}
llsubmit: The job "f2n7.1080085" has been submitted.
~~~
LoadLeveler tells us that our job has entered the queue with ID number "f2n7.1080085".

We can look at all jobs that are currenlty in the queue by running the command:
```
-bash-4.2$ llq
```
This can be a long list - there are a lot of users running on a large HPC! To narrow down this list a bit, we can ask LoadLeveler specifically about our job using the ID number we were given:
```
-bash-4.2$ llq -j f2n7.1080085
```
~~~ {.output}
Id                       Owner      Submitted   ST PRI Class        Running On
------------------------ ---------- ----------- -- --- ------------ -----------
f2n7.1080085.0           user       10/21 02:28 R  50  General      f7n3

1 job step(s) in query, 0 waiting, 0 pending, 1 running, 0 held, 0 preempted
~~~
Let's have a look at the output: "Id" is our ID number. "Owner" is the user who submitted the job, and "Submitted" tells us when the job was submitted. "ST" is short for "STATUS" and tells us if a submitted job is waiting in the queue ("I" for idle), if it is running ("R" for running), and more. The "PRI" field shows job priority level, "Class" tells us to which account category the job belongs, and "Running On" tells us on which node we are running (if the job has started).

Unlike running a program directly ("interactively"), we will not see any output from our Python program on the command line. It will run on one of the many computers ("nodes") of the cluster as soon as there is sufficient capacity. LoadLeveler will collect any output that would normally appear on the terminal and write it into a text file that ends with the ".out" suffix:
```
-bash-4.2$ ls *.out
```
~~~ {.output}
python-example_1080085.out
~~~
Note that our job ID number was used for the output file name; it is possible to change the output file name using the `output` directive in the submission script.

The file contains the output that we would have seen if we had run the program interactively:
```
-bash-4.2$ cat python-example_1080085.out
```
~~~ {.output}
Running nested for loops 10 times...
Best runtime [seconds]: 8.322
~~~

> ## Challenge
>
> For which tasks should a scheduler be used and which tasks should be run interactively on the HPC?
>
> 1. Copying data and source codes between laptop and HPC
> 2. Compiling source codes
> 3. Running tests
> 4. Running production jobs