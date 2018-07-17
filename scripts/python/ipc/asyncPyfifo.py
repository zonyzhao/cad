#!/usr/bin/python
########################################################
# Skill IPC Executable that interacts via a fifo
########################################################
import sys
import os
import string
import time

# location of the FIFO
ffile = "/users/1127110/project/python/ipc/trunk/pipe"

# open the fifos for reading and writing
fh=open(ffile)

ack = "ack\n"
resp="waiting"
ackresp="ack received"
skcmod=""
while True:
    while True:
        skcmd = fh.readline()
        time.sleep(1)
        if skcmd != "": break
    if skcmd == "exit\n":
        sys.stdout.write(skcmd) 
        sys.stdout.flush() 
        break
    sys.stdout.write(skcmd) 
    sys.stdout.flush() 
fh.close()
sys.exit
