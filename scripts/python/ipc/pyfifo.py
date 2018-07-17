#!/usr/bin/python
###################################################################################################################
# Skill IPC Executable that interacts via a fifo
###################################################################################################################
import sys
import os
import string
import time

# location of the FIFO
ffile = "/users/1127110/project/python/ipc/trunk/pipe"

# Create the fifo
os.system("mkfifo " + ffile)

# location of file fifo
fh=open(ffile)

ack = "ack\n"
resp="waiting"
ackresp="ack received"
skcmod=""
while True:
    while True:
        skcmd = fh.read()
        time.sleep(1)
        if skcmd != "": break
    if skcmd == "exit\n":
        sys.stdout.write(skcmd) 
        sys.stdout.flush() 
        break
    sys.stdout.write(skcmd) 
    sys.stdout.flush() 
    while True:
        time.sleep(3)
        if sys.stdin.readline() == "ack\n": break
    sys.stdout.write(ackresp)
    sys.stdout.flush() 
fh.close()
# Remove the FIFO
os.system("rm " + ffile)
sys.exit




