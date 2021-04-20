#!/bin/bash
#export LD_LIBRARY_PATH=/vol8/lib/mpi-x/lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/vol8/lib/ucx/lib:$LD_LIBRARY_PATH
export PMI_TIME=20000
#export UCX_TLS=glex,sm
export OMP_NUM_THREADS=1
yhrun -N 1 -n 32 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
