#!/usr/bin/python
###################################################################################################################
# Filters the error geometry and error message outputs from ivVerify
###################################################################################################################
# Ex Call:
#          ivVerifyResFilt.py "drc.out" "drc.txt"
# Where:
#            "drc.out" is the drc error geometry output
#            "drc.txt" is the run output log with the drc error message
###################################################################################################################
import sys
import os
import struct
import string
import math
import time
import fileinput

#######################
argnum = len(sys.argv)
filenameA = str(sys.argv[1])
filenameB = str(sys.argv[2])
########################
# DEBUG
########################
#filenameA = "drc.out"
#filenameB = "drc.txt"

sys.path.append('/users/1127110/project/python/diva/trunk')

import pydiva

pdiva = pydiva.pyVerify()
pdiva.setFileA(filenameA)
pdiva.setFileB(filenameB)
pdiva.readA()
pdiva.filterA()
pdiva.readB()
pdiva.filterB()
pdiva.write()
