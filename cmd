class GCY():
    outdir=''
    mpiPerNode=32
    ompNum=2
    nodeBase=1
    nodeBatch=4
    partition='work'
    jobNum=10
    scriptPWD=os.getcwd()

python  b99.opensn.generateJob.py -nodeBase 1 -nodeBatch 7 -p 653_test -jobNum 10 -outdir 1005a


python  b99.opensn.generateJob.py -nodeBase 128 -nodeBatch 1 -p 653_test -jobNum 5 -outdir 1005b


python b98.opensn.getResult.py ../rundir/1005b/| sort -nk 2     


grep Total *.out| sort -nk 6|awk -F - '{print $2}'|awk -F . '{print $1}'


python2  b99.opensn.generateJob.py -ompNum 2 -input input -nodeBase 1 -nodeBatch 1 -p 653_test -jobNum 623 -outdir 1007b -w cn[***]


python2  b99.opensn.generateJob.py -ompNum 4 -mpiPerNode 16 -input input -nodeBase 1 -nodeBatch 7 -p all -jobNum 1 -outdir 1017-c

 python2 b99.opensn.generateJob.py -nodeBase 9 -nodeBatch 3 -p all -jobNum 2 -ompNum 64 -mpiPerNode 1 -outdir 1020omp64 














