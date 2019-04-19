#!/usr/bin/python
import sys
sys.path.append('/users/1127110/cad/scripts/python/parser')
sys.path.append('/users/1127110/cad/scripts/python/reticle')
import os
import struct
import string
import math
import time
import fileinput
import exceptions
import re
import sqlite3
from __future__ import division
import reader
import parse
import writer
import reticle
###################################################
# UT-1 Inheritance/Composition Tests
###################################################
help(reticle.alignMark)
issubclass(reticle.alignMark, reticle.overhead)
eQuadMainL0 = reticle.ebeamQuad()
isinstance(eQuadMainL0, reticle.ebeamQuad)

###################################################
# UT-1 Parse the primary Leica portion of 
#       a Photo Info file
###################################################
read = reader.reader()
read.setName("pa0756.photo")
#read.setName("pa0758.photo")
read.setPath("./testTargets/")
read.read()
leicaParse = parse.parser()
leicaParse.setLines(read.getLines())
leicaParse.setBegString("Primary Leica Marks")
leicaParse.setEndString("Scan")
leicaParse.parse()
leicaParse.getbOccur()
write = writer.writer()
write.setName("leica.parse")
write.setPath("./")
write.setLines(leicaParse.getpLines())
write.write()
# Parse out primary lines
text = leicaParse.getpLines()
pLines=[]
begRexp = re.compile("PRI")
urRexp = re.compile("UR")
lrRexp = re.compile("LR")
llRexp = re.compile("LL")
ulRexp = re.compile("UL")
mloRexp = re.compile("Main_LO")
loRexp = re.compile("LO")
sdaRexp = re.compile("SDA")
southRexp = re.compile("South")
northRexp = re.compile("North")
i=0
while i < len(text):
    if begRexp.search(text[i]) != None:
        pLines.append(text[i].strip("\n"))
        print text[i]
    i=i+1

numLines = len(pLines)

mLoUlCoord = []
mLoUrCoord = []
mLoLlCoord = []
mLoLrCoord = []

if numLines > 6:
    # MIM
    i = 0
    for line in pLines:
        if mloRexp.search(line) != None:
            if northRexp.search(line) != None:
                if ulRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    mLoUlCoord.append(float(xs))
                    mLoUlCoord.append(float(ys))
                    print str(i) + ".) Main L0 North UL COORD: (" + xs + "," + ys + ")"  
                if urRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    mLoUrCoord.append(float(xs))
                    mLoUrCoord.append(float(ys))
                    print str(i) + ".) Main L0 North UR COORD: (" + xs + "," + ys + ")"                               
            if southRexp.search(line) != None:
                if llRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    mLoLlCoord.append(float(xs))
                    mLoLlCoord.append(float(ys))
                    print str(i) + ".) Main LO South LL COORD: (" + xs + "," + ys + ")"
                if lrRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    mLoLrCoord.append(float(xs))
                    mLoLrCoord.append(float(ys))
                    print str(i) + ".) Main LO South LR COORD: (" + xs + "," + ys + ")"
            i=i+1
    mLoLlLrYDiff = mLoLlCoord[1] - mLoLrCoord[1]
    mLoUlUrYDiff = mLoUlCoord[1] - mLoUrCoord[1]
    mLoUlLlYDiff = mLoUlCoord[0] - mLoLlCoord[0]
    mLoUrLrYDiff = mLoUrCoord[0] - mLoLrCoord[0]
    print("################################################")
    print(" LIECA POST PROCESSED REPORT")
    print("################################################")
    print("Main_L0_LL_LR_Y_DIFF = " +  str(mLoLlLrYDiff))
    print("Main_L0_LL_LR_Y_DIFF = " +  str(mLoUlUrYDiff))
    print("Main_L0_UL_LL_X_DIFF = " +  str(mLoUlLlYDiff))
    print("Main_L0_UR_LR_X_DIFF = " +  str(mLoUrLrYDiff))
    mLoCdcX = mLoLrCoord[0] - mLoLlCoord[0] 
    mLoCdcY = mLoUlCoord[1] - mLoLlCoord[1]
    print("Main L0 CDC_X = " +  str(mLoCdcX))
    print("Main L0 CDC_Y = " +  str(mLoCdcY))
    # Populate the ebeam Main L0 Quad
    eQuadMainL0 = reticle.ebeamQuad()
    eQuadMainL0.ul.pos.center.x = mLoUlCoord[0]
    eQuadMainL0.ul.pos.center.y = mLoUlCoord[1]
    eQuadMainL0.ur.pos.center.x = mLoUrCoord[0]
    eQuadMainL0.ur.pos.center.y = mLoUrCoord[1]
    eQuadMainL0.ll.pos.center.x = mLoLlCoord[0]
    eQuadMainL0.ll.pos.center.y = mLoLlCoord[1]
    eQuadMainL0.lr.pos.center.x = mLoLrCoord[0]
    eQuadMainL0.lr.pos.center.y = mLoLrCoord[1]
    
else:
    # SIM
    pass
