#!/usr/bin/python
from __future__ import division
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
import reader
import parse
import writer
import reticle
###################################################
# UT-1 Inheritance/Composition Tests
###################################################
#help(reticle.alignMark)
#issubclass(reticle.alignMark, reticle.overhead)
#eQuadMainL0 = reticle.ebeamQuad()
#isinstance(eQuadMainL0, reticle.ebeamQuad)

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
leicaParse.setBegString("Leica Marks")
leicaParse.setEndString("Scan")
leicaParse.parse()
leicaParse.getbOccur()
write = writer.writer()
write.setName("leica.parse")
write.setPath("./")
write.setLines(leicaParse.getpLines())
write.write()

###############################
# Parse out primary lines
text = leicaParse.getpLines()
pLines=[]
###############################
# Regular Expressions
###############################
# ebeam marker names
mloName = "_Main_LO_"
loName = "_LO_"
sdaName = "_SDA_"
mloRexp = re.compile(mloName)
loRexp = re.compile(loName)
sdaRexp = re.compile(sdaName)
# secondary or primary
begRexp = re.compile("PRI")
begRexpSec = re.compile("SEC")
# reticle corner position
urRexp = re.compile("UR")
lrRexp = re.compile("LR")
llRexp = re.compile("LL")
ulRexp = re.compile("UL")
# MIM: N/S
southRexp = re.compile("South")
northRexp = re.compile("North")
################################

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

loUlCoord = []
loUrCoord = []
loLlCoord = []
loLrCoord = []

sdaUlCoord = []
sdaUrCoord = []
sdaLlCoord = []
sdaLrCoord = []

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
        elif loRexp.search(line) != None:
            if northRexp.search(line) != None:
                if ulRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    loUlCoord.append(float(xs))
                    loUlCoord.append(float(ys))
                    print str(i) + ".) L0 North UL COORD: (" + xs + "," + ys + ")"  
                if urRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    loUrCoord.append(float(xs))
                    loUrCoord.append(float(ys))
                    print str(i) + ".) L0 North UR COORD: (" + xs + "," + ys + ")"                               
            if southRexp.search(line) != None:
                if llRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    loLlCoord.append(float(xs))
                    loLlCoord.append(float(ys))
                    print str(i) + ".) LO South LL COORD: (" + xs + "," + ys + ")"
                if lrRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    loLrCoord.append(float(xs))
                    loLrCoord.append(float(ys))
                    print str(i) + ".) LO South LR COORD: (" + xs + "," + ys + ")"            
            i=i+1
        elif sdaRexp.search(line) != None:
            if northRexp.search(line) != None:
                if ulRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    sdaUlCoord.append(float(xs))
                    sdaUlCoord.append(float(ys))
                    print str(i) + ".) SDA North UL COORD: (" + xs + "," + ys + ")"  
                if urRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    sdaUrCoord.append(float(xs))
                    sdaUrCoord.append(float(ys))
                    print str(i) + ".) SDA North UR COORD: (" + xs + "," + ys + ")"                               
            if southRexp.search(line) != None:
                if llRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    sdaLlCoord.append(float(xs))
                    sdaLlCoord.append(float(ys))
                    print str(i) + ".) SDA South LL COORD: (" + xs + "," + ys + ")"
                if lrRexp.search(line) != None:
                    ls = line.split("\t")
                    coord = ls[3]
                    coords = coord.split()
                    xs = coords[0]
                    ys = coords[1]
                    sdaLrCoord.append(float(xs))
                    sdaLrCoord.append(float(ys))
                    print str(i) + ".) SDA South LR COORD: (" + xs + "," + ys + ")"            
            i=i+1
else:
    pass

##########################################
# Main LO
##########################################
mLoLlLrYDiff = mLoLlCoord[1] - mLoLrCoord[1]
mLoUlUrYDiff = mLoUlCoord[1] - mLoUrCoord[1]
mLoUlLlYDiff = mLoUlCoord[0] - mLoLlCoord[0]
mLoUrLrYDiff = mLoUrCoord[0] - mLoLrCoord[0]
print("################################################")
print(" LIECA POST PROCESSED REPORT - Main LO")
print("################################################")
print("Main_L0_LL_LR_Y_DIFF = " +  str(mLoLlLrYDiff))
print("Main_L0_LL_LR_Y_DIFF = " +  str(mLoUlUrYDiff))
print("Main_L0_UL_LL_X_DIFF = " +  str(mLoUlLlYDiff))
print("Main_L0_UR_LR_X_DIFF = " +  str(mLoUrLrYDiff))
mLoCdcX = mLoLrCoord[0] - mLoLlCoord[0] 
mLoCdcY = mLoUlCoord[1] - mLoLlCoord[1]
print("Main L0 CDC_X = " +  str(mLoCdcX))
print("Main L0 CDC_Y = " +  str(mLoCdcY))
eQuadMainL0 = reticle.ebeamQuad()
eQuadMainL0.ul.pos.center.x = mLoUlCoord[0]
eQuadMainL0.ul.pos.center.y = mLoUlCoord[1]
eQuadMainL0.ur.pos.center.x = mLoUrCoord[0]
eQuadMainL0.ur.pos.center.y = mLoUrCoord[1]
eQuadMainL0.ll.pos.center.x = mLoLlCoord[0]
eQuadMainL0.ll.pos.center.y = mLoLlCoord[1]
eQuadMainL0.lr.pos.center.x = mLoLrCoord[0]
eQuadMainL0.lr.pos.center.y = mLoLrCoord[1]
print("################################################")
print(" LIECA POST PROCESSED REPORT - Main LO (Object)")
print("################################################")
print("L0_Vertical Align Checksum = " +  str(eQuadMainL0.chkValign()))
print("L0_Horizontal Align Checksum = " +  str(eQuadMainL0.chkHalign()))
print("LO CDC Horizontal = " +  str(eQuadMainL0.chkCdcX()))
print("L0_CDC Vertical = " +  str(eQuadMainL0.chkCdcY()))
##########################################
# Main LO
##########################################
loLlLrYDiff = loLlCoord[1] - loLrCoord[1]
loUlUrYDiff = loUlCoord[1] - loUrCoord[1]
loUlLlYDiff = loUlCoord[0] - loLlCoord[0]
loUrLrYDiff = loUrCoord[0] - loLrCoord[0]
print("################################################")
print(" LIECA POST PROCESSED REPORT - LO")
print("################################################")
print("Main_L0_LL_LR_Y_DIFF = " +  str(loLlLrYDiff))
print("Main_L0_LL_LR_Y_DIFF = " +  str(loUlUrYDiff))
print("Main_L0_UL_LL_X_DIFF = " +  str(loUlLlYDiff))
print("Main_L0_UR_LR_X_DIFF = " +  str(loUrLrYDiff))
loCdcX = loLrCoord[0] - loLlCoord[0] 
loCdcY = loUlCoord[1] - loLlCoord[1]
print("Main L0 CDC_X = " +  str(loCdcX))
print("Main L0 CDC_Y = " +  str(loCdcY))
eQuadL0 = reticle.ebeamQuad()
eQuadL0.ul.pos.center.x = loUlCoord[0]
eQuadL0.ul.pos.center.y = loUlCoord[1]
eQuadL0.ur.pos.center.x = loUrCoord[0]
eQuadL0.ur.pos.center.y = loUrCoord[1]
eQuadL0.ll.pos.center.x = loLlCoord[0]
eQuadL0.ll.pos.center.y = loLlCoord[1]
eQuadL0.lr.pos.center.x = loLrCoord[0]
eQuadL0.lr.pos.center.y = loLrCoord[1]
print("################################################")
print(" LIECA POST PROCESSED REPORT -  LO (Object)")
print("################################################")
print("L0_Vertical Align Checksum = " +  str(eQuadL0.chkValign()))
print("L0_Horizontal Align Checksum = " +  str(eQuadL0.chkHalign()))
print("LO CDC Horizontal = " +  str(eQuadL0.chkCdcX()))
print("L0_CDC Vertical = " +  str(eQuadL0.chkCdcY()))
##########################################
# SDA
##########################################
sdaLlLrYDiff = sdaLlCoord[1] - sdaLrCoord[1]
sdaUlUrYDiff = sdaUlCoord[1] - sdaUrCoord[1]
sdaUlLlYDiff = sdaUlCoord[0] - sdaLlCoord[0]
sdaUrLrYDiff = sdaUrCoord[0] - sdaLrCoord[0]
print("################################################")
print(" LIECA POST PROCESSED REPORT - SDA")
print("################################################")
print("SDA_LL_LR_Y_DIFF = " +  str(sdaLlLrYDiff))
print("SDA_LL_LR_Y_DIFF = " +  str(sdaUlUrYDiff))
print("SDA_UL_LL_X_DIFF = " +  str(sdaUlLlYDiff))
print("SDA_UR_LR_X_DIFF = " +  str(sdaUrLrYDiff))
sdaCdcX = sdaLrCoord[0] - sdaLlCoord[0] 
sdaCdcY = sdaUlCoord[1] - sdaLlCoord[1]
print("SDA CDC_X = " +  str(sdaCdcX))
print("SDA CDC_Y = " +  str(sdaCdcY))
eQuadSda = reticle.ebeamQuad()
eQuadSda.ul.pos.center.x = sdaUlCoord[0]
eQuadSda.ul.pos.center.y = sdaUlCoord[1]
eQuadSda.ur.pos.center.x = sdaUrCoord[0]
eQuadSda.ur.pos.center.y = sdaUrCoord[1]
eQuadSda.ll.pos.center.x = sdaLlCoord[0]
eQuadSda.ll.pos.center.y = sdaLlCoord[1]
eQuadSda.lr.pos.center.x = sdaLrCoord[0]
eQuadSda.lr.pos.center.y = sdaLrCoord[1]
print("################################################")
print(" LIECA POST PROCESSED REPORT -  SDA (Object)")
print("################################################")
print("SDA_Vertical Align Checksum = " +  str(eQuadSda.chkValign()))
print("SDA_Horizontal Align Checksum = " +  str(eQuadSda.chkHalign()))
print("SDA CDC Horizontal = " +  str(eQuadSda.chkCdcX()))
print("SDA_CDC Vertical = " +  str(eQuadSda.chkCdcY()))


eQuadMainL0.chkValign()
eQuadMainL0.chkHalign()
eQuadMainL0.chkCdcX()
eQuadMainL0.chkCdcY()

eQuadL0.chkValign()
eQuadL0.chkHalign()
eQuadL0.chkCdcX()
eQuadL0.chkCdcY()

eQuadSda.chkValign()
eQuadSda.chkHalign()
eQuadSda.chkCdcX()
eQuadSda.chkCdcY()
