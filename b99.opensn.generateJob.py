import sys,os,pdb,math,time

from GetNodeByNum import GCYNODENUM
from GENERATEJOBS import GENERATEJOBS



obj=GENERATEJOBS()
obj.getArgs(sys.argv)
obj.getInput()
obj.generateJob()




