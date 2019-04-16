###################################################
# Parser Package Unit Tests
###################################################
###################################################
###################################################
# Reader Class Unit Tests
###################################################
# UT-0
###################################################
import reader
read = reader.reader()
read.setName("cdb2oa_full_dry.log")
read.getName()
read.setPath("/users/1127110/project/gmake/oaConversion/trunk/")
read.getPath()
read.read()
read.getNumLines()
read.getLineNum(0)
read.getLineNum(1)
###################################################
# UT-1
###################################################
import reader
import parser
read = reader.reader()
read.setName("cdb2oa_full_dry.log")
read.setPath("/users/1127110/project/gmake/oaConversion/trunk/")
read.read()
parse = parser.parser()
parse.setLines(read.getLines())
parse.setBegString("WARNING")
parse.setEndString("\.")
parse.parse()
###################################################
# UT-2
###################################################
import reader
import parser
import writer
read = reader.reader()
read.setName("cdb2oa_full_dry.log")
read.setPath("/users/1127110/project/gmake/oaConversion/trunk/")
read.read()
parse = parser.parser()
parse.setLines(read.getLines())
parse.setBegString("WARNING")
parse.setEndString("\.")
parse.parse()
parse.getbOccur()
write = writer.writer()
write.setName("warn.log")
write.setPath("./")
write.setLines(parse.getpLines())
write.write()
###################################################
# UT-3
###################################################
import reader
import parser
import writer
read = reader.reader()
read.setName("cdb2oa_092617.log")
read.setPath("/users/1127110/project/gmake/oaConversion/trunk/")
read.read()
parse = parser.parser()
parse.setLines(read.getLines())
parse.setBegString("WARNING")
parse.setEndString("\.")
parse.parse()
parse.getbOccur()
write = writer.writer()
write.setName("warn.log")
write.setPath("./")
write.setLines(parse.getpLines())
write.write()
###################################################
# UT-4
###################################################
import reader
import parse
import writer
read = reader.reader()
read.setName("cdb2oa__e.log")
read.setPath("/users/1127110/cad/scripts/python/parser/testTargets/cdb2oa_e/")
read.read()
parse = parse.parser()
parse.setLines(read.getLines())
parse.setBegString("ERROR")
parse.setEndString("\.")
parse.parse()
parse.getbOccur()
write = writer.writer()
write.setName("cdb2oa__e_err.log")
write.setPath("./")
write.setLines(parse.getpLines())
write.write()
###################################################
# UT-5
###################################################
import reader
import parse
import writer
read = reader.reader()
read.setName("cdb2oa__e.log")
read.setPath("/users/1127110/cad/scripts/python/parser/testTargets/cdb2oa_e/")
read.read()
parse = parse.parser()
parse.setLines(read.getLines())
parse.setBegString("WARNING")
parse.setEndString("\.")
parse.parse()
parse.getbOccur()
write = writer.writer()
write.setName("cdb2oa__e_warn.log")
write.setPath("./")
write.setLines(parse.getpLines())
write.write()
###################################################
# UT-6
###################################################
import reader
import parser
import writer
read = reader.reader()
read.setName("cdb2oa_092717.log")
read.setPath("./testTargets")
read.read()
parse = parser.parser()
parse.setLines(read.getLines())
parse.setBegString("ERROR")
parse.setEndString("\.")
parse.parse()
parse.getbOccur()
write = writer.writer()
write.setName("err.log")
write.setPath("./")
write.setLines(parse.getpLines())
write.write()
###################################################
# UT-7
###################################################
import reader
import parser
import writer
read = reader.reader()
read.setName("cdb2oa__b.log_common")
read.setPath("./testTargets")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("ERROR")
errparse.setEndString("\.")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("common_err.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
wrnparse = parser.parser()
wrnparse.setLines(read.getLines())
wrnparse.setBegString("WARNING")
wrnparse.setEndString("\.")
wrnparse.parse()
wrnparse.getbOccur()
write.setName("common_wrn.log")
write.setPath("./")
write.setLines(wrnparse.getpLines())
write.write()
###################################################
# UT-8: Process a list of logfiles
###################################################
import reader
import parser
import writer
logFileList = [ "cdb2oa__b.log_common",
                "cdb2oa__b.log_pa0715",
                "cdb2oa__b.log_lvslib",
                "cdb2oa__b.log_TECH46",
                "cdb2oa__b.log_TECH51",
                "cdb2oa__b.log_TECH60",
                "cdb2oa__b.log_TECH70",
                "cdb2oa__b.log_TECH80",
                "cdb2oa__b.log_TECH80A",
                "cdb2oa__b.log_TECH80B",
                "cdb2oa__b.log_TECH81",
                "cdb2oa__b.log_TECH82",
                "cdb2oa__b.log_TECH85",
                "cdb2oa__b.log_TECHD" ]

read = reader.reader()
read.setPath("./testTargets")
write = writer.writer()
write.setPath("./processed")
errparse = parser.parser()
wrnparse = parser.parser()
errparse.setBegString("ERROR")
errparse.setEndString("\.")
wrnparse.setBegString("WARNING")
wrnparse.setEndString("\.")

for logFile in logFileList:
    read.reset()
    write.reset()
    errparse.reset()
    wrnparse.reset()
    read.setName(logFile)
    read.read()
    errparse.setLines(read.getLines())
    wrnparse.setLines(read.getLines())
    errparse.parse()
    wrnparse.parse()
    errFileName = logFile + "_ERROR"
    wrnFileName = logFile + "_WARNING"
    write.setName(errFileName)
    write.setLines(errparse.getpLines())
    write.write()
    write.setName(wrnFileName)
    write.setLines(wrnparse.getpLines())
    write.write()
###################################################
# UT-9: ASML ERROR progression parsing
###################################################
import reader
import parser
import writer
# First pass
read = reader.reader()
read.setName("ASML_092617.log")
read.setPath("./testTargets")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("ERROR")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092617_err.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
# Second Pass
read = reader.reader()
read.setName("ASML_092617_err.log")
read.setPath("./")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("CDBOA-616")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092617_CDBOA616.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
# Third Pass
read = reader.reader()
read.setName("ASML_092617_err.log")
read.setPath("./")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("CDBOA-401")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092617_CDBOA401.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()

######################
# Second File

import reader
import parser
import writer
# First pass
read = reader.reader()
read.setName("ASML_092717.log")
read.setPath("./testTargets")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("ERROR")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092717_err.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
# Second Pass
read = reader.reader()
read.setName("ASML_092717_err.log")
read.setPath("./")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("CDBOA-616")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092717_CDBOA616.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
# Third Pass
read = reader.reader()
read.setName("ASML_092717_err.log")
read.setPath("./")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("CDBOA-401")
errparse.setEndString("\:")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("ASML_092717_CDBOA401.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
###################################################
# UT-10 Parse a complete Snapshot run
###################################################
import reader
import parser
import writer
read = reader.reader()
read.setName("cdb2oa__c.log")
read.setPath("./testTargets/cdb2oa_c")
read.read()
errparse = parser.parser()
errparse.setLines(read.getLines())
errparse.setBegString("ERROR")
errparse.setEndString("\.")
errparse.parse()
errparse.getbOccur()
write = writer.writer()
write.setName("cdb2oa_c_err.log")
write.setPath("./")
write.setLines(errparse.getpLines())
write.write()
wrnparse = parser.parser()
wrnparse.setLines(read.getLines())
wrnparse.setBegString("WARNING")
wrnparse.setEndString("\.")
wrnparse.parse()
wrnparse.getbOccur()
write.setName("cdb2oa_c_wrn.log")
write.setPath("./")
write.setLines(wrnparse.getpLines())
write.write()
###################################################
# UT-10 Parse the primary Leica portion of 
#       a Photo Info file
###################################################
import reader
import parse
import writer
read = reader.reader()
read.setName("pa0756.photo")
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
; Parse out primary lines
import re
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
else:
    # SIM
    pass

###############################################
# Experimental Code
###############################################
import re


parseString="WARNING"
rexp = re.compile(parseString)
lines = parse.lines
i=0
for line in lines:
    if rexp.search(line) != None:
        print line
    i=i+1

text = []
text.append("WARNING (CDBOA-406): Directory")                                                
text.append("/nfs/layout/procLib/PML_46/p46_1_model_12x300sog_B/p46_1_model_10x100sw_2#2e5K_A/layout")
text.append("is in a cellview. The directory and its contents will be")
text.append("copied to the destination database but will not be")        
text.append("translated.")

import re
pLines=[]
begRexp = re.compile("WARNING")
endRexp = re.compile("\.")  
i=0
while i < len(text):
    if begRexp.search(text[i]) != None:
        pLines.append(text[i])
        while endRexp.search(text[i]) == None:
            print i
            pLines.append(text[i])
            i=i+1
        i=i+1
    else:
        i=i+1
    
