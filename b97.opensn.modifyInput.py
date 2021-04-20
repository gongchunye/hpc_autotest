import pdb,shutil
import os,math,time,sys
from GENERATEJOBS import GENERATEJOBS


class GCY97():

    print 'fix problem size, get best performance'

    def getInput(self):
        fi=open('input')
        self.flInput=fi.readlines()
        fi.close()
        shutil.copyfile('input','ori.input')

        fi=open('run.sh')
        self.fSH=fi.readlines()
        fi.close()

    def getNearSquareBig(self,mpinum):
        n1=int(math.sqrt(mpinum*1.0))
        for i in range(n1,0,-1):
            if int(mpinum/i)*i==mpinum:
                return i

    def generateInputAndSH(self):
        nk=[2,4,8,16,32]
        ompnum=[2,4,8,16,32,64]
        #nk=[4,8]
        #ompnum=[8,16]

        for omp in ompnum:
            mpinum=64/omp
            #if (omp==32):
            #    pdb.set_trace()
            mpiy=self.getNearSquareBig(mpinum)
            mpix=mpinum/mpiy
            if (mpix>mpiy):
                temp=mpiy
                mpiy=mpix
                mpix=temp

            for kk in nk:
                myin=self.flInput
               # print kk, omp
                in1=myin[0].strip()
                ss=in1.split()
                ss[0]=str(mpix)
                ss[1]=str(mpiy)
                ss[2]=str(kk)
                #print  ss
                s1=''
                for yy in ss:
                    s1=s1+yy+' '
                myin[0]=s1+'\n'
                #print kk,omp,'--',s1

                fo=open('input1','w')
                for yy in myin:
                    fo.write(yy)
                fo.close()

                cmd='python2  b99.opensn.generateJob.py -nodeBase 1 -nodeBatch 11 -p all -jobNum 10'
                cmd=cmd+' -outdir omp'+str(omp)+'-nk'+str(kk) +' -ompNum '+str(omp)+ ' -mpiPerNode '+str(64/omp)

                #cmd=cmd+' -input input1'
                cmd=cmd+' -w '
                cmd=cmd+' cn[0-201,203-232,234-251,253-548,550-828,830-901,903-1011,1013-2569,2571-2590,2592-2887,2889-2890,2892-2893,2895-2900,2902-2909,2911-2914,2916,2918,2920-2924,2926-2929,2932-2935,2938,2940-3185,3187-3238,3240-3583]'
                print cmd



obj=GCY97()
obj.getInput()
obj.generateInputAndSH()
