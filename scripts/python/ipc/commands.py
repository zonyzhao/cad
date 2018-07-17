#!/usr/bin/python
###################################################################################################################
# Engages with a cadence skill IPC to convert characters to uppercase 
###################################################################################################################
import sys
import os
import string
import time

resp=""
while True:
    skcmd = input("skcmd>>")
    if skcmd == "exit": break
    sys.stdout.flush() 
    os.write(3,skcmd)
    time.sleep(3)
    resp=os.read(4,4096)
    sys.stdout.flush()
    print("<< " + resp)
sys.exit(1)




