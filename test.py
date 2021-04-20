
import time,commands


output=commands.getstatusoutput('yhqueue|wc')
oo=output[1].strip().split()
print oo[0]







