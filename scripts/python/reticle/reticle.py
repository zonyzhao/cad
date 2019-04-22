###################################
# Reticle Class Package: reticle.py
####################################

__metaclass__ = type # Make sure we get new style class

class coordinate:
    def __init__(self):
        self.x = 0.0
        self.y = 0.0

class position:
    def __init__(self):
        self.origin = coordinate()
        self.center = coordinate()
        
class overhead(object):
    def __init__(self):
        self.type = ""
        self.pos = position()
    def getPos(self):
        return self.pos

class alignMark(overhead):
    def __init__(self):
        super(alignMark,self).__init__()
        self.name = ""

class ebeamQuad:
    def __init__(self):
        self.layer = ""
        self.ul = alignMark()
        self.ur = alignMark()
        self.ll = alignMark()
        self.lr = alignMark()
        self.va = False
        self.ha = False
        self.cdcx = 0.0
        self.cdcy = 0.0
    def chkValign(self):
        chkUpper = self.ul.pos.center.x - self.ll.pos.center.x
        chkLower = self.ur.pos.center.x - self.lr.pos.center.x
        return chkUpper+chkLower
    def chkHalign(self):
        chkRight = self.ul.pos.center.y - self.ur.pos.center.y
        chkLeft  = self.ll.pos.center.y - self.lr.pos.center.y
        return chkRight+chkLeft
    def chkCdcX(self):
        chk = self.lr.pos.center.x - self.ll.pos.center.x
        return chk
    def chkCdcY(self):
        chk = self.ul.pos.center.y - self.ll.pos.center.y
        return chk
        
class reticle:
    def __init__(self):
        self.multiImage = False
        self.productCode = ""
        self.tech = ""
        self.processCode = ""
        self.width = 0.0
        self.length = 0.0
