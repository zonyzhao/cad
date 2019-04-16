# reader.py class
class reader:
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
    def getLines(self):
        return self.lines
    def getLineNum(self, ind):
        return self.lines[ind]
    def reset(self):
        self.lines = []
        self.num = 0
    def read(self):
        filename = self.path + "/" + self.name
        fp = open(filename,'r')
        self.lines = fp.readlines()
        fp.close()
        self.num = len(self.lines)
        for i in range(self.num):
            self.lines[i] = self.lines[i].strip()
            self.lines[i] = self.lines[i].strip("\n")
        return self.num
