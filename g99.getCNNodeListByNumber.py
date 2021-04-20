
#20191004
#get a number of cn[] nodes
#by Chunye Gong

import os,sys,pdb

print 'Get 128 nodes'
print 'python *.py cn[0-2,4-88,105-128,130-9999] 128'

print sys.argv[1],sys.argv[2]


nodes=sys.argv[1]
num=int(sys.argv[2])
s1=nodes.split('[')
s2=s1[1].split(']')
ss=s2[0]

#pdb.set_trace()

s1=ss.split(',')
nn=0
mynode='cn['
for i in range(len(s1)):
    ss=s1[i]
    if '-' in ss:
        g1=ss.split('-')
        n2=int(g1[1])-int(g1[0])+1
        nn2=nn+n2
        print ss, nn2,num
        if nn2<num:
            nn=nn+n2
            mynode=mynode+ss+','
        else:
            nn3=num-nn
            nn4=int(g1[0])+nn3-1
            mynode=mynode+str(g1[0])+'-'+str(nn4)+']'
            break
        print mynode
    else:
        if (nn+1)==num:
            mynode=mynode+ss+']'
            break
        else:
            mynode=mynode+ss+','

cmd='yhinfo -n '+mynode
os.system(cmd)

print '\n\n'
print mynode
print '\n'
