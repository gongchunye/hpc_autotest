import sys,os,pdb,math,time

from GetNodeByNum import GCYNODENUM
from A99GETSLURMJOBNUM import A99GETSLURMJOBNUM

class GENERATEJOBS():
    outdir=''
    mpiPerNode=32
    ompNum=2
    nodeBase=1
    nodeBatch=4
    partition='all'
    jobNum=10
    exclude=''
    worknodes=''
    inputfile='input'
    realrun=True
    mpiNum=1
    nodeNum=1
    scriptPWD=os.getcwd()

    def getArgs(self,gcyargs):
        argLen=len(gcyargs)
        for i in range(argLen):
            if '-outdir'==gcyargs[i].strip():
                self.outdir=str(gcyargs[i+1])
                print 'outdir:',gcyargs[i+1]
            if '-mpiPerNode'==gcyargs[i].strip():
                self.mpiPerNode=int(gcyargs[i+1])
                print 'mpiPerNode:',gcyargs[i+1]
            if '-ompNum'==gcyargs[i].strip():
                self.ompNum=int(gcyargs[i+1])
                print 'ompNum:',gcyargs[i+1]
            if '-N'==gcyargs[i].strip():
                self.nodeNum=int(gcyargs[i+1])
                print 'nodeNum:',gcyargs[i+1]
            if '-n'==gcyargs[i].strip():
                self.mpiNum=int(gcyargs[i+1])
                print 'mpiNum:',gcyargs[i+1]
            if '-nodeBase'==gcyargs[i].strip():
                self.nodeBase=int(gcyargs[i+1])
                print 'nodeBase:',gcyargs[i+1]
            if '-nodeBatch'==gcyargs[i].strip():
                self.nodeBatch=int(gcyargs[i+1])
                print 'nodeBatch:',gcyargs[i+1]
            if '-p'==gcyargs[i].strip():
                self.partition=(gcyargs[i+1])
                print '-p:',gcyargs[i+1]
            if '-x'==gcyargs[i].strip():
                self.exclude=(gcyargs[i+1])
                print '-x:',gcyargs[i+1]
            if '-w'==gcyargs[i].strip():
                self.worknodes=(gcyargs[i+1])
                print '-w:',gcyargs[i+1]
            if '-jobNum'==gcyargs[i].strip():
                self.jobNum=int(gcyargs[i+1])
                print 'jobNum:',gcyargs[i+1]
            if '-input'==gcyargs[i].strip():
                self.inputfile=(gcyargs[i+1])
                print 'input file:',gcyargs[i+1]
            if '-notrun'==gcyargs[i].strip():
                self.realrun=False

    def getInput(self):
        fi=open(self.inputfile)
        self.input=fi.readlines()
        fi.close()
        ss=self.input[0].split()
        dd=self.input[1].split()
        self.mpix=int(ss[0].strip())
        self.mpiy=int(ss[1].strip())
        self.gridx=int(dd[0].strip())
        self.gridy=int(dd[1].strip())
        self.timex=self.gridx/self.mpix
        self.timey=self.gridy/self.mpiy

        fi=open('run.sh')
        self.sh=fi.readlines()
        fi.close()
        for ss in self.sh:
            if 'yhrun ' in ss:
                s1=ss.strip().split()
                self.exe=s1[len(s1)-1]

    def outputInput(self,myout2,nodeNum):

        if self.mpiNum>1:
            mpinum=self.mpiNum
        else:
            mpinum=nodeNum*self.mpiPerNode

        for i in range(int(math.sqrt(mpinum)),0,-1):
            if int(mpinum/i)*i==mpinum:
                self.mpix=i
                self.mpiy=mpinum/i
                break
        if self.mpix>self.mpiy:
            tmp=self.mpix
            self.mpix=self.mpiy
            self.mpiy=self.mpix

        #localgridx=px*self.gridx
        #localgridy=py*self.gridy
        localgridx=self.gridx
        localgridy=self.gridy

        #print px,py
        #print nodeNum

        ss=self.input[0].strip().split()
        self.input[0]=str(self.mpix)+' '+str(self.mpiy)+' '+ss[2]+' '+ss[3]+' '+ss[4]+'\n'
        ss=self.input[1].strip().split()
        self.input[1]=str(localgridx)+' '+str(localgridy)+' '+ss[2]+' '+ss[3]+' '+ss[4]+'\n'


        fo=open(myout2+'/input','w')
        for ss in self.input:
            fo.write(ss)
            #print ss.strip()
        fo.close()
        #exit(0)

    def outputSH(self,myout2,nodeNum):
        cmd='cp bangding.sh '+myout2+'/'
        os.system(cmd)
        mysh=self.sh
        #mysh[1]='export OMP_NUM_THREADS='+str(self.ompNum)+'\n'
       # mysh[2]='yhrun -N '+str(nodeNum)+' -n '+str(self.mpiPerNode*nodeNum) +' taskset 0xffff ' + self.exe
        #mysh[2]='yhrun -N '+str(nodeNum)+' -n '+str(self.mpiPerNode*nodeNum) +' ' + self.exe
        for i in range(len(mysh)):
            if 'export OMP_NUM_THREADS=' in mysh[i]:
                mysh[i]='export OMP_NUM_THREADS='+str(self.ompNum)+'\n'
            if 'yhrun -N ' in mysh[i] and self.exe in mysh[i]:
                if self.mpiNum>1:
                    mysh[i]='yhrun -N '+str(nodeNum)+' -n '+str(self.mpiNum) +' ' + self.exe+'\n'
                else:
                    mysh[i]='yhrun -N '+str(nodeNum)+' -n '+str(self.mpiPerNode*nodeNum) +' ' + self.exe+'\n'

        #print 'gcy124:',mysh
        fo=open(myout2+'/run.sh','w')
        for ss in mysh:
            #print 'gcy123',ss
            fo.write(ss)
        fo.close()

    def submitJob(self,myout2,nodeNum):
        os.chdir(myout2)
        cmd='yhbatch  -N '+ str(nodeNum)+' -J sn'+str(nodeNum)+' -p '+self.partition 
        #cmd='yhbatch --begin=22:00 -N '+ str(nodeNum)+' -J sn'+str(nodeNum)+' -p '+self.partition 
        if len(self.exclude)>0:
            cmd=cmd+' -x '+self.exclude
        cmd=cmd+' run.sh'
        slurm=A99GETSLURMJOBNUM()
        ngcy=0
        for i in range(self.jobNum):
            os.system(cmd)
            ngcy=ngcy+1
            if int(i/10)*10==i:
                print cmd
                time.sleep(0.1)
            if int(ngcy/100)*100==ngcy:
                while(True):
                    jobnums123=slurm.getSlurmJobNum()
                    print jobnums123
                    if jobnums123< 2000:
                        break
                    else:
                        print 'too many jobs: ',jobnums123
                        time.sleep(10)
        os.chdir(self.scriptPWD)
 

    def submitJobWorkNode(self,myout2,nodeNum):
        os.chdir(myout2)
        obj2=GCYNODENUM()
        obj2.setParameter(self.worknodes)
        obj2.getNodebyNum()
        gcynodeList=obj2.nodeList
        totalNode=len(gcynodeList)
        self.jobNum=int(totalNode/nodeNum)
        slurm=A99GETSLURMJOBNUM()

        for i in range(self.jobNum):
            cmd='yhbatch -N '+ str(nodeNum)+' -J sn'+str(nodeNum)+' -p '+self.partition 
            if len(self.exclude)>0:
                cmd=cmd+' -x '+self.exclude
            nodes=''
            for j in range(i*nodeNum,(i+1)*nodeNum-1):
                nodes=nodes+'cn'+str(gcynodeList[j])+','
            nodes=nodes+'cn'+str(gcynodeList[(i+1)*nodeNum-1])
            cmd=cmd+' -w '+nodes
            sstime=time.strftime(".%H%M%S",time.localtime())
            if nodeNum<=8:
                cmd=cmd+' -o '+nodes+sstime+'.out'
            cmd=cmd+' run.sh'
            if self.realrun:
                os.system(cmd)
            if int(i/10)*10==i:
                time.sleep(1)
                print i+1,cmd
            if int(i/100)*100==i:
                while(True):
                    jobnums123=slurm.getSlurmJobNum()
                    print jobnums123
                    if jobnums123< 2000:
                        break
                    else:
                        print 'too many jobs: ',jobnums123
                        time.sleep(10)
        os.chdir(self.scriptPWD)

    def generateJob(self):
        myout='../rundir/'+self.outdir
        if not os.path.isdir(myout):
            os.mkdir(myout)
        for i in range(self.nodeBatch):
            if i==0:
                if self.nodeNum>1:
                    nodes=self.nodeNum
                else:
                    nodes=self.nodeBase
            else:
                nodes=nodes*2
            ##nodes=2**(self.nodeBase+i-1)
            myout2=myout+'/'+str(nodes)
            if not os.path.isdir(myout2):
                os.mkdir(myout2)
            self.outputInput(myout2,nodes)
            self.outputSH(myout2,nodes)
            if len(self.worknodes)==0:
                self.submitJob(myout2,nodes)
            else:
                self.submitJobWorkNode(myout2,nodes)









