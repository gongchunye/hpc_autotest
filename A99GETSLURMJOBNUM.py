
import time,commands

class A99GETSLURMJOBNUM():
    def getSlurmJobNum(self):

        output=commands.getstatusoutput('yhqueue|wc')
        oo=output[1].strip().split()
        return int( oo[0])







