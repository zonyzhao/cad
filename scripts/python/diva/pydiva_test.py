#!/usr/bin/python
import sys
sys.path.append('/users/1127110/project/python/diva/trunk')
import os
import struct
import string
import math
import time
import fileinput
import exceptions
import re
import sqlite3
import pydiva
from __future__ import division

fileA = "/users/1127110/cad_layout_51/drc.out"
fileB = "/users/1127110/cad_layout_51/drc.txt"

pdiva = pydiva.pyVerify()

pdiva.setFileA(fileA)
pdiva.setFileB(fileB)
pdiva.readA()
pdiva.filterA()
pdiva.readB()
pdiva.filterB()
pdiva.write()

errRule   = re.compile('\\ERROR\\b')

errRule = re.compile('ERROR\:')
line = "        1  ERROR: Minimum width of mesa is 5um. Rule 00.010.01\n"
line = " "
errRule.match(line)
errRule.findall(line)

