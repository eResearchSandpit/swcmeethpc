#!/bin/bash

#
# Scheduler directives
#

# @ job_name = python-example
# @ class = Backfill
# @ account_no = nesi00321
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
