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
            for uu in uudir:
                vv=fdir+uu
                if '.out' not in uu:
                    continue
                fi=open(vv)
                fl=fi.readlines()
                fi.close()
                for ss in fl:
                    if 'Total Elapsed time was:' in ss:
                        ee=ss.strip().split('Total Elapsed time was:')
                        costTime=float(ee[1])
                        timeList.append(costTime)
                        break
            if len(timeList)>0:
                print fdir+'\t'+str(min(timeList))+'\t'+str(max(timeList))
            else:
                print fdir,'Empty'




obj=GCY2()
obj.getResult(obj.mydir)


