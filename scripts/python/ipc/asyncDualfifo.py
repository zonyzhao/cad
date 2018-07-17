#!/usr/bin/python
############################################################
# Skill IPC Executable that interacts via a fifo
############################################################
import sys
import os
import string
import time

# Location of the FIFOs
# Python to Skill FIFO
p2s = "/users/1127110/project/python/ipc/trunk/ppipe"
# Skill to Python FIFO
s2p = "/users/1127110/project/python/ipc/trunk/spipe"

# open the fifos for reading and writing
p2s_fh=open(p2s)
s2p_fh=open(s2p)

ack = "ack\n"
resp="waiting"
ackresp="ack received"
skcmod=""
while True: 
    # Check Python to Skill FIFO for a new Skill Command
    while True:
        skcmd = p2s_fh.readline()
        time.sleep(1)
        if skcmd != "": break
    if skcmd == "exit\n":
        sys.stdout.write(skcmd) 
        sys.stdout.flush() 
        break
    # Send FIFO Skill Command to the IPC
    sys.stdout.write(skcmd) 
    sys.stdout.flush()
    # Listen for a response from the IPC
    while True:
        time.sleep(1)
        # Check IPC for an output
        sys.stdin.flush()
        resp = sys.stdin.readline()
        if resp != "": break
        # Write response into Skill to Python FIFO
        s2p_fh.write(resp)
p2s_fh.close()
s2p_fh.close()
sys.exit




