# writer.py class
class writer:
    def __init__(self):
        self.name  = ""
        self.path  = ""
        self.lines = []
        self.num = 0
    def setName(self,name):
        self.name = name
    def getName(self):
        return self.name
    def setPath(self,path):
        self.path = path
    def getPath(self):
        return self.path
    def getNumLines(self):
        return self.num
    def setLines(self,lines):
        self.lines=lines
        self.num=len(lines)
    def getLines(self):
        return self.lines
    def getLineNum(self, ind):
        return self.lines[ind]
    def reset(self):
        self.lines = []
        self.num = 0
    def write(self):
        for i in range(self.num-1):
            self.lines[i] = self.lines[i] + "\n" 
        filename = self.path + "/" + self.name
        fp = open(filename,'w')
        fp.writelines(self.lines)
        fp.close()
