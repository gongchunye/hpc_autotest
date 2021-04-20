#! /bin/bash

ulimit -s unlimited

Cores=64
#==========================================================
PMI_SIZE=$SLURM_NPROCS

PMI_RANK=$SLURM_PROCID

MPI_NUM_NODES=$SLURM_NNODES

MPI_PER_NODE=$((PMI_SIZE / MPI_NUM_NODES))

MPI_RANK_FOR_NODE=$((PMI_RANK % MPI_PER_NODE))
#==========================================================


threads=`echo ${Cores}*${SLURM_NNODES}/${PMI_SIZE} | bc`

PRO_SIZE=${MPI_PER_NODE}
PMI_RANK_my=${MPI_RANK_FOR_NODE}

case ${PRO_SIZE} in
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-63'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
2)
case ${PMI_RANK_my} in
0)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-31'
numactl -i 4-7 -N 0-3 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='32-63'
numactl -i 0-3 -N 4-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
esac
;;
4)
case ${PMI_RANK_my} in
0)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-15'
numactl -i 0-7 -N 0-1 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='16-31'
numactl -i 0-7 -N 2-3 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
2)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='32-47'
numactl -i 0-7 -N 4-5 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
3)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='48-63'
numactl -i 0-7 -N 6-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
esac
;;
8)
case ${PMI_RANK_my} in
0)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-7'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='8-15'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
2)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='16-23'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
3)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='24-31'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
4)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='32-39'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
5)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='40-47'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
6)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='48-55'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
7)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='56-63'
numactl -i 0-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
esac
;;
16)
case ${PMI_RANK_my} in
0)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-3'
numactl -i 0-7 -C 0-3 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='4-7'
numactl -i 0-7 -C 4-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
2)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='8-11'
numactl -i 0-7 -C 8-11 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
3)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='12-15'
numactl -i 0-7 -C 12-15 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
4)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='16-19'
numactl -i 0-7 -C 16-19 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
5)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='20-23'
numactl -i 0-7 -C 20-23 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
6)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='24-27'
numactl -i 0-7 -C 24-27 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
7)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='28-31'
numactl -i 0-7 -C 28-31 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
8)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='32-35'
numactl -i 0-7 -C 32-35 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
9)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='36-39'
numactl -i 0-7 -C 36-39 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
10)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='40-43'
numactl -i 0-7 -C 40-43 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
11)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='44-47'
numactl -i 0-7 -C 44-47 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
12)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='48-51'
numactl -i 0-7 -C 48-51 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
13)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='52-55'
numactl -i 0-7 -C 52-55 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
14)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='56-59'
numactl -i 0-7 -C 56-59 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
15)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='60-63'
numactl -i 0-7 -C 60-63 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
esac
;;
32)
case ${PMI_RANK_my} in
0)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='0-1'
numactl -i 0-7 -C 0-1 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
1)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='2-3'
numactl -i 0-7 -C 2-3 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
2)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='4-5'
numactl -i 0-7 -C 4-5 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
3)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='6-7'
numactl -i 0-7 -C 6-7 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
4)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='8-9'
numactl -i 0-7 -C 8-9 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
5)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='10-11'
numactl -i 0-7 -C 10-11 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
6)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='12-13'
numactl -i 0-7 -C 12-13 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
7)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='14-15'
numactl -i 0-7 -C 14-15 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
8)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='16-17'
numactl -i 0-7 -C 16-17 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
9)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='18-19'
numactl -i 0-7 -C 18-19 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
10)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='20-21'
numactl -i 0-7 -C 20-21 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
11)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='22-23'
numactl -i 0-7 -C 22-23 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
12)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='24-25'
numactl -i 0-7 -C 24-25 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
13)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='26-27'
numactl -i 0-7 -C 26-27 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
14)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='28-29'
numactl -i 0-7 -C 28-29 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
15)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='30-31'
numactl -i 0-7 -C 30-31 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
16)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='32-33'
numactl -i 0-7 -C 32-33 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
17)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='34-35'
numactl -i 0-7 -C 34-35 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
18)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='36-37'
numactl -i 0-7 -C 36-37 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
19)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='38-39'
numactl -i 0-7 -C 38-39 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
20)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='40-41'
numactl -i 0-7 -C 40-41 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
21)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='42-43'
numactl -i 0-7 -C 42-43 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
22)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='44-45'
numactl -i 0-7 -C 44-45 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
23)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='46-47'
numactl -i 0-7 -C 46-47 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
24)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='48-49'
numactl -i 0-7 -C 48-49 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
25)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='50-51'
numactl -i 0-7 -C 50-51 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
26)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='52-53'
numactl -i 0-7 -C 52-53 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
27)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='54-55'
numactl -i 0-7 -C 54-55 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
28)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='56-57'
numactl -i 0-7 -C 56-57 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
29)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='58-59'
numactl -i 0-7 -C 58-59 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
30)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='60-61'
numactl -i 0-7 -C 60-61 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
31)
export OMP_NUM_THREADS=${threads}
export GOMP_CPU_AFFINITY='62-63'
numactl -i 0-7 -C 62-63 /vol8/home/test653/thpb/parallel/opensn20190805/bin/opensn-omp-gcc
;;
esac
;;
esac

