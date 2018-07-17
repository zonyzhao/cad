import re
######################################################
# parser.py class
######################################################
class parser:
    def __init__(self):
        self.lines = []
        self.pLines = []
        self.begStr = ""
        self.endStr=""
        self.begRexp = None
        self.endRexp = None
        self.num = 0
        self.pnum = 0
        self.bOccur = 0
        self.eOccur = 0
    def setBegString(self,string):
        self.begStr = string
        self.begRexp = re.compile(self.begStr)
    def getBegString(self):
        return self.begStr 
    def setEndString(self,string):
        self.endStr = string
        self.endRexp = re.compile(self.endStr)
    def getEndString(self):
        return self.endStr 
    def getLines(self):
        return self.lines
    def setLines(self,lines):
        self.lines = lines
        self.num = len(lines)
    def getpLines(self):
        return self.pLines
    def getbOccur(self):
        return self.bOccur
    def reset(self):
        self.lines = []
        self.pLines = []
        self.num = 0
        self.pnum = 0
        self.bOccur = 0
        self.eOccur = 0
    def parse(self):
        i=0
        j=0
        while i < self.num:
            if self.begRexp.search(self.lines[i]) != None:
                while self.endRexp.search(self.lines[i]) == None:
                    self.pLines.append(self.lines[i])
                    i=i+1
                j=j+1
                self.pLines.append(self.lines[i])
                i=i+1
            else:
                i=i+1
        self.bOccur = j
        self.pnum = len(self.pLines)
        return self.pnum
