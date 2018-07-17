import os
import string
import re

skfifo = "/users/1127110/project/python/ipc/trunk/pipe"

while True:
    skcmd = input("skcmd:")
    if skcmd == "exit": 
        break
    osCmd = "ls " + skfifo
    if os.system(osCmd) == 0:
        if skcmd.find("source") > -1: 
            skcmd = skcmd.split()
            filename = skcmd[1]
            fp = open(filename,'r')
            lines = fp.readlines()
            for line in lines:
                print line 
                line = line.strip("\n")
                osCmd = "echo \""+line+"\"> " + skfifo
                os.system(osCmd)
        else:
            osCmd = "echo \""+skcmd+"\"> " + skfifo
            os.system(osCmd)
    else:
        print "ERROR: Cadence Python IPC not running - Exiting"
        break
    
