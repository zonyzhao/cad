#!/usr/bin/python
###################################################################################################################
# Engages with a cadence skill IPC to convert characters to uppercase 
###################################################################################################################
import sys
import string

while True:
    buff=sys.stdin.readline()
    if buff == "foo\n":
        sys.stderr.flush() 
        sys.stdout.flush()
        sys.stdin.flush()
        break
    buff=buff.upper()
    sys.stdout.write(buff) 
    sys.stdout.flush()
sys.exit

#import sys
#import string
#sys.stdout.write("hello")
#upper=sys.stdout.read()
