import os,sys


class GCYNODENUM():
    batchSize=0
    nodeinput=''
    batchNum=10
    nodeList=list()
#    print '*.py -node cn[***] -size 64 [-num 10]'

    def getNodebyNum(self):
        self.nodeList=list()
        s1=self.nodeinput.split('[')
        s2=s1[1].split(']')
        ss=s2[0].split(',')
        for i in range(len(ss)):
            if '-' in ss[i]:
                g1=ss[i].split('-')
                for j in range(int(g1[0]),int(g1[1])+1):
                    self.nodeList.append(j)
            else:
                self.nodeList.append(int(ss[i]))
       # print len(self.nodeList),self.nodeList

    def setParameter(self,node2):
        self.nodeinput=node2

    def getParameter(self):
        args=sys.argv
        for i in range(len(args)):
            if '-node' in args[i]:
                self.nodeinput=args[i+1]
            if '-size' in args[i]:
                self.batchSize=int(args[i+1])
            if '-num' in args[i]:
                self.batchNum=int(args[i+1])



#obj=GCYNODENUM()
#obj.getParameter()
#obj.getNodebyNum()
