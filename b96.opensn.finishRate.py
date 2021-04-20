import sys,os


class GCY2():
    outdir=''
    mydir=sys.argv[1]

    def getResult(self,mydir):
        gdir=os.listdir(mydir)
        print gdir
        for gg in gdir:
            fdir=mydir+gg
            if not os.path.isdir(fdir):
                continue
            fdir=fdir+'/'
            uudir=os.listdir(fdir)
            timeList=list()
            nJobNum=0
            nJobFinishedNum=0
            for uu in uudir:
                vv=fdir+uu
                if '.out' not in uu:
                    continue
                nJobNum=nJobNum+1
                fi=open(vv)
                fl=fi.readlines()
                fi.close()
                for ss in fl:
                    if 'Total Elapsed time was:' in ss:
                        nJobFinishedNum=nJobFinishedNum+1
                        break
            print fdir,nJobFinishedNum,nJobNum
            #print('%s\t%d\t%d'%{fdir,nJobFinishedNum,nJobNum})




obj=GCY2()
obj.getResult(obj.mydir)


