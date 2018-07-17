# table.py

__metaclass__ = type # Make sure we get new style class

class lst:
    name = ""
    lst = []
    def __init__(self):
        lst = []
    def setLst(self,lst):
        self.lst = lst
    def getLst(self):
        return self.lst
    def __sub__(self,lst):
        length = len(self.lst)
        for i in range(length):
            self.lst[i] = str(float(self.lst[i]) - float(lst.lst[i]))
    def __div__(self,lst):
        length = len(self.lst)
        for i in range(length):
            self.lst[i] = str(float(self.lst[i])/float(lst.lst[i]))

class table:
    data = []
    subdata = []
    rows = 0
    cols = 0
    def __init__(self):
        self.data = []
        self.subdata = []
        self.rows = 0
        self.cols = 0
    def setTab(self,mat):
        self.data = mat
        if not mat:
            print "WARNING: Table is empty"
        else:
            self.rows = len(self.data)
            self.cols = len(self.data[0])
    def getTab(self):
        return self.data
    def create(self,rows,cols):
        self.cols = cols
        self.rows = rows
        for m in range(self.rows):
            self.data.append([])
            for n in range(self.cols):
                self.data[m].append("None")
    def printTab(self):
        for i in range(self.rows):
            line = ""
            for j in range(self.cols):
                line = line + " " + str(self.data[i][j])
            print line
    def printRanges(self):
        self.rows = len(self.data)
        self.cols = len(self.data[0])
        print "Rows: %i" % self.rows
        print "Cols: %i" % self.cols
    def getRanges(self):
        retval = []
        self.rows = len(self.data)
        self.cols = len(self.data[0])
        retval.append(self.rows)
        retval.append(self.cols)
        return retval
    def reset(self):
        self.data = []
        self.rows = 0
        self.cols = 0
    def getRow(self,rowNum):
        return self.data[rowNum]     
    def setRow(self,row,data):
        for i in range(self.cols):
            self.data[row][i] = data[i]
    def stripRow(self,ind):
        self.rows = self.rows-1
        return self.data.pop(ind)
    def stripCol(self,ind):
        retval = []
        length = self.rows-1
        self.cols = self.cols-1
        for i in range(length):
            val = self.data[i].pop(ind)
            retval.append(val)
        return retval    
    def appendRow(self,row):
        self.rows = self.rows + 1
        self.data.append([])
        self.cols = len(row)
        for i in range(self.cols):
            self.data[self.rows-1].append(row[i])
    def appendCol(self,col):
        self.rows = len(col)
        try:
            for i in range(self.rows):
                if (self.cols == 0):
                     self.data.append([])
                     self.data[i].append(col[i])
                else:
                    self.data[i].append(col[i])
                    
            self.cols = self.cols + 1
        except:
            print "ERROR: Number of entries greater than to table rows"
    def setElem(self,row,col,val):
        self.data[row][col] = val
    def getElem(self,row,col):
        retval = self.data[row][col]
        return retval
    def getElemReal(self,row,col):
        val = self.data[row][col]
        ind = val.find("j*")
        length = len(val)
        if ind >= 0:
            retval = val[0:ind-1]
        else:
            retval = val
        return retval
    def getElemImag(self,row,col):
        val = self.data[row][col]
        ind = val.find("j*")
        length = len(val)
        if ind >= 0:
            retval = val[ind+2:length]
        else:
            retval = val
        return retval
    def getElemAbs(self,row,col):
        val = self.data[row][col]
        ind = val.find("j*")
        length = len(val)
        if ind >= 0:
            real = val[0:ind-1]
            imag = val[ind+2:length]
            retval = (float(real)**2+float(imag)**2)**0.5
        else:
            retval = val
        return retval
    def getCol(self,colNum):
        col = []
        for i in range(self.rows):
            col.append(self.data[i][colNum])
        return(col)
    def getColAbs(self,colNum):
        col = []
        for i in range(self.rows):
            col.append(self.getElemAbs(i,colNum))
        return(col)
    def getColImag(self,colNum):
        col = []
        for i in range(self.rows):
            col.append(self.getElemImag(i,colNum))
        return(col)
    def getColReal(self,colNum):
        col = []
        for i in range(self.rows):
            col.append(self.getElemReal(i,colNum))
        return(col)
    def getSubTab(self,rows,cols):
        row_min = rows[0]
        row_max = rows[1]
        row_span = row_max-row_min
        col_min = cols[0]
        col_max = cols[1]
        col_span = col_max-col_min
        self.subdata=[]
        for i in range(row_span):
            self.subdata.append([])
        for i in range(row_span):
            for j in range(col_span):
                self.subdata[i].append(str(self.data[row_min+i][col_min+j]))
        return self.subdata
    def __add__(self,tbl):
        for i in range(self.rows):
            for j in range(self.cols):
                a = self.getElem(i,j)
                b = tbl.getElem(i,j)
                c = a + b
                self.setElem(i,j,c)
    def __sub__(self,tbl):
        for i in range(self.rows):
            for j in range(self.cols):
                a = self.getElem(i,j)
                b = tbl.getElem(i,j)
                c = a - b
                self.setElem(i,j,c)
    def __mul__(self,tbl):
        for i in range(self.rows):
            for j in range(self.cols):
                a = self.getElem(i,j)
                b = tbl.getElem(i,j)
                c = a*b
                self.setElem(i,j,c)
    def __truediv__(self,tbl):
        for i in range(self.rows):
            for j in range(self.cols):
                a = self.getElem(i,j)
                b = tbl.getElem(i,j)
                c = a/b
                self.setElem(i,j,c)
    
class ftable(table):
    file = ""
    lines = []
    def __init__(self):
        self.file = ""
        self.lines = []
    def setFile(self,file):
        self.file = file
    def getFile(self):
        return self.file
    def writeTab(self):
        for m in range(self.rows):
            line = ""
            for n in range(self.cols):
                data_form = str(self.data[m][n])
                if (n < self.cols-1):
                    line = line + "\t" + data_form 
                else:
                    line = line + "\t" + data_form + "\n"
            self.lines.append(line)
        fp = open(self.file,'w')
        fp.writelines(self.lines)
        fp.close()
    def readTransPosed(self):
        fp = open(self.file,'r')
        self.lines = fp.readlines()
        fp.close()
        self.cols=0
        for line in self.lines:
            line_strip = line.strip('\n')
            line_strip = line_strip.strip()
            num_list = line_strip.split('\t')
            self.data.append([])
            self.rows = 0
            for num_elem in num_list:
                num = num_elem.strip() 
                self.data[self.cols].append(num)
                self.rows = self.rows + 1
            self.cols=self.cols+1
    def readTab(self):
        fp = open(self.file,'r')
        self.lines = fp.readlines()
        fp.close()
        self.rows=0
        for line in self.lines:
            self.data.append([])
            line_strip = line.strip('\n')
            line_strip = line_strip.strip()
            num_list = line_strip.split('\t')
            self.cols = 0
            for num_elem in num_list:
                num = num_elem.strip()  
                self.data[self.rows].append(num)
                self.cols = self.cols + 1
            self.rows=self.rows+1

class hspParseMeas:
    file = ""
    name = ""
    source = ""
    version = ""
    title = ""
    alter = 0
    mlist = []
    dmat  = table()
    rdlines = []
    def __init__(self):
        self.file = ""
        self.name = ""
        self.source = ""
        self.version = ""
        self.title = ""
        self.alter = ""
        self.mlist = []
        self.dmat = table()
        self.rdlines = []
    def setFile(self,file):
        self.file = file
    def getFile(self):
        return self.file
    def setName(self,name):
        self.name = name
    def getName(self):
        return self.name
    def getSource(self):
        return self.source
    def getVersion(self):
        return self.version
    def getTitle(self):
        return self.title
    def getAlter(self):
        return self.alter
    def getMlist(self):
        return self.mlist
    def getDlist(self):
        return self.dlist
    def printDmat(self):
        self.dmat.printTab()
    def getDmat(self):
        return self.dmat.getTab()
    def getCol(self,col):
        return self.dmat.getCol(col)
    def getSubDmat(self,rows,cols):
        return self.dmat.getSubTab(rows,cols)
    def getIndices(self):
        return self.dmat.getRanges()
    def printIndices(self):
        self.dmat.printRanges()
    def parse(self):
        self.mlist = []
        self.rdlines = []
        fp = open(self.file,'r')
        self.rdlines = fp.readlines()
        fp.close()
        line = self.rdlines.pop(0)
        llen = len(line)
        ind_str = line.find('=')
        line = line[ind_str+2:llen]
        ind_end = line.find('\'')
        self.source = line[0:ind_end]
        llen = len(line)
        line = line[ind_end+1:llen]
        ind_str = line.find('=')
        llen = len(line)
        line = line[ind_str+2:llen]
        ind_end = line.find('\'')
        self.version = line[0:ind_end]
        line = self.rdlines.pop(0)
        ind_str = line.find('*')
        llen = len(line)
        line = line[ind_str+2:llen]
        ind_end = line.find('\'')
        self.title = line[0:ind_end]
        self.mlist = []
        while True:
            line = self.rdlines.pop(0)
            line = line.strip('\n')
            self.mlist = self.mlist + line.split()
            if line.find('alter#')>0 : break
        dline = ""
        length = len(self.rdlines)
        for j in range(length):
            line = ""
            line = self.rdlines.pop(0)
            line = line.strip('\n')
            dline = dline + line
        cols = len(self.mlist)
        dvect = dline.split()
        rows = len(dvect)/cols
        self.dmat.create(rows,cols)
        i=0
        for r in range(rows):
            for c in range(cols):
                self.dmat.setElem(r,c,dvect[i])
                i=i+1
import sqlite3

class dbInterface:
    db_file = ""
    tableName = ""
    mat = table()
    rows = 0
    cols = 0
    rowLabels = []
    colLabels = []
    colTypes = []
    xSel = ""
    ySel = ""
    target = ""
    rowId  = ""
    def __init__(self):
        self.db_file = ""
        self.tableName = ""
        self.mat = table()
        self.rows = 0
        self.cols = 0
        self.rowLabels = []
        self.colLabels = []
        self.colTypes = []
        self.xSel = ""
        self.ySel = ""
        self.target = ""
        self.rowId = ""
    def setDbFile(self,db_file):
        self.db_file = db_file
    def getDbFile(self):
        return self.db_file
    def setTableName(self,tableName):
        self.tableName = tableName
    def getTableName(self):
        return self.tableName
    def getTableData(self):
        return self.mat.getTab()
    def setRowLabels(self,rowLabels):
        self.rowLabels = rowLabels
    def getRowLabels(self):
        return self.rowLabels
    def setColLabels(self,colLabels):
        self.colLabels = colLabels
    def getColLabels(self):
        return self.colLabels
    def setColTypes(self,colTypes):
        self.colTypes = colTypes
    def getColTypes(self):
        return self.colTypes
    def setXSel(self,xSel):
        self.xSel = xSel
    def getXSel(self):
        return self.xSel
    def setYSel(self,ySel):
        self.ySel = ySel
    def getYSel(self):
        return self.ySel
    def setTarget(self,target):
        self.target = target
    def getTarget(self):
        return self.target
    def setRowId(self,rowId):
        self.rowId = rowId
    def getRowId(self):
        return self.rowId
    def setData(self,data):
        self.mat.setTab(data)
    def getData(self):
        return self.mat.getTab()
    def getRanges(self):
        return self.mat.getRanges()
    def listTableColumns(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "PRAGMA table_info(" + self.tableName +")"
        cursor.execute(cmd)
        data = cursor.fetchall()
        i=0
        for cols in data:
            print data[i][1]
            i=i+1
    def getTableColumns(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "PRAGMA table_info(" + self.tableName +")"
        cursor.execute(cmd)
        data = cursor.fetchall()
        colLab = []
        i=0
        for cols in data:
            colLab.append(data[i][1])
            i=i+1
        return colLab
    def getTableColumnTypes(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "PRAGMA table_info(" + self.tableName +")"
        cursor.execute(cmd)
        data = cursor.fetchall()
        colLab = []
        i=0
        for cols in data:
            colLab.append(data[i][2])
            i=i+1
        return colLab
    def read(self):
        self.mat.reset()
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "SELECT * FROM " + self.tableName 
        cursor.execute(cmd)
        tbl = cursor.fetchall()
        self.mat.setTab(tbl)
        cmd = "PRAGMA table_info(" + self.tableName +")"
        cursor.execute(cmd)
        data = cursor.fetchall()
        i=0
        self.colLabels = []
        for cols in data:
            self.colLabels.append(data[i][1])
            i=i+1
        i=0
        self.colTypes = []
        for cols in data:
            self.colTypes.append(data[i][2])
            i=i+1
        pdb.commit()
        pdb.close()
    def printTableData(self):
        self.mat.printTab()
    def printTable(self):
        print self.colLabels
        self.mat.printTab()
    def getRow(self,rowNum):
        row = self.mat.getRow(rowNum)
        return row
    def define(self):
        cmd = "CREATE TABLE IF NOT EXISTS " + self.tableName + " ("
        length = len(self.colLabels)
        cmd = cmd + "rowid TEXT PRIMARY KEY,"
        for i in range(length):
            if (i < length-1):
                cmd = cmd + " " + self.colLabels[i] + " " + self.colTypes[i] + ","
            else:
                cmd = cmd + " " + self.colLabels[i] + " " + self.colTypes[i] + ")"
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        try:
            cursor.execute(cmd)
            pdb.commit()
            pdb.close()
        except:
            print "Table cannot be created!"
            print "Failed command: " + cmd
            pdb.close()
    def create(self):
        cmd = "CREATE TABLE IF NOT EXISTS " + self.tableName + " ("
        length = len(self.colLabels)
        for i in range(length):
            if (i < length-1):
                cmd = cmd + " " + self.colLabels[i] + " " + self.colTypes[i] + ","
            else:
                cmd = cmd + " " + self.colLabels[i] + " " + self.colTypes[i] + ")"
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        try:
            cursor.execute(cmd)
            pdb.commit()
            pdb.close()
        except:
            print "Table cannot be created!"
            print "Failed command: " + cmd
            pdb.close()
    def exists(self):
        cmd = "CREATE TABLE " + self.tableName + " (foo, TEXT)"
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        try:
            cursor.execute(cmd)
            pdb.close()
            return 0
        except:
            pdb.close()
            return 1
    def populate(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        length = len(self.rowLabels)
        for m in range(length):
            trow = self.mat.getRow(m)
            cmd = "INSERT INTO " + self.tableName + " VALUES('" + str(self.rowLabels[m]) + "',"
            cols = len(trow)
            for n in range(cols):
                if (n < cols-1):
                    cmd = cmd + str(trow[n]) + ","
                else:
                    cmd = cmd + str(trow[n]) + ")"
            cursor.execute(cmd)
        pdb.commit()
        pdb.close()
    def dropTable(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "DROP TABLE " + self.tableName
        try:
            cursor.execute(cmd)
            pdb.commit()
            pdb.close()
        except:
            print "Table Drop Failed!"
            pdb.close()
    def listTables(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "SELECT name FROM sqlite_master WHERE TYPE='table'"
        cursor.execute(cmd)
        rows = cursor.fetchall()
        for row in rows:
            print row
        pdb.close()
    def getTables(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "SELECT name FROM sqlite_master WHERE TYPE='table'"
        cursor.execute(cmd)
        rows = cursor.fetchall()
        pdb.close()
        return rows
    def appendTextRow(self,row):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "INSERT INTO " + self.tableName + " VALUES('"
        cols = len(row)
        for n in range(cols):
            if (n < cols-1):
                cmd = cmd + row[n] + "','"
            else:
                cmd = cmd + row[n] + "')"
        cursor.execute(cmd)
        pdb.commit()
        pdb.close()
    def replaceTextRow(self,row):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "INSERT OR REPLACE INTO " + self.tableName + " VALUES('"
        cols = len(row)
        for n in range(cols):
            if (n < cols-1):
                cmd = cmd + row[n] + "','"
            else:
                cmd = cmd + row[n] + "')"
        cursor.execute(cmd)
        pdb.commit()
        pdb.close()
    def insertRow(self,row):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        if self.colTypes[0].find("TEXT") >= 0:
            cmd = "INSERT OR REPLACE INTO " + self.tableName + " VALUES('"
        else:
            cmd = "INSERT OR REPLACE INTO " + self.tableName + " VALUES("
        cols = len(row)
        for n in range(cols):
            if (n < cols-1):
                if self.colTypes[n].find("TEXT") >= 0:
                    cmd = cmd + row[n] + "','"
                else:
                    cmd = cmd + row[n] + ","
            else:
                if self.colTypes[n].find("TEXT") >= 0:
                    cmd = cmd + row[n] + "')"
                else:
                    cmd = cmd + row[n] + ")"
        cursor.execute(cmd)
        pdb.commit()
        pdb.close()
    def getTblEntry(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "SELECT " + self.target + " FROM " + self.tableName + " WHERE " + self.xSel + "=\'" + self.ySel + "\'"
        cursor.execute(cmd)
        retval = cursor.fetchall()
        pdb.commit()
        pdb.close()
        return retval
    def getTblEntryId(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        #cmd = "SELECT " + self.target + " FROM " + self.tableName + " WHERE TEXT PRIMARY KEY=" + self.rowId
        # FIXME - Need to get the primary id from the col label info 
        cmd = "SELECT " + self.target + " FROM " + self.tableName + " WHERE id=" + self.rowId 
        cursor.execute(cmd)
        retval = cursor.fetchall()
        pdb.commit()
        pdb.close()
        return retval
    def createIndex(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        cmd = "CREATE INDEX temp ON " + self.tableName + "(" + self.xSel + ")"
        cursor.execute(cmd)
        pdb.commit()
        pdb.close()
    def setTableData(self):
        pdb = sqlite3.connect(self.db_file)
        cursor = pdb.cursor()
        ind = self.mat.getRanges()
        cols = ind[1]
        cmd = "INSERT INTO " + self.tableName + " VALUES("   
        for i in range(cols):
            if (i < cols-1):
                cmd = cmd + "%s,"
            else:
                cmd = cmd + "%s)"
        cursor.executemany(cmd,self.mat.getTab())
        pdb.commit()
        pdb.close()
    def tableExist(self):
        pdb = sqlite3.connect(self.db_file)
        cmd = "SELECT COUNT(*) FROM sqlite_master WHERE type='table' AND name='" + self.tableName + "'"
        cursor=pdb.rawQuery(cmd)
        count = cursor.getInt(0)
        pdb.close()
        return count > 0
    def textColTypes(self):
        ranges=self.mat.getRanges()
        cols = ranges[1]
        self.colType = []
        for col in range(cols):
            self.colType.append("TEXT")
    def textRowId(self):
        ranges=self.mat.getRanges()
        rows = ranges[0]
        self.rowLabels
        for i in range(rows):
            self.rowLabels.append(str(i+1))
    def resetData(self):
        self.mat.reset()

class table2lat:
    tabmat = table()
    datfile = ""
    latfile = ""
    title = ""
    label = ""
    colLabel = []
    rowLabel = []
    wrlines = []
    dec = 2
    def __init__(self):
        self.tabmat = table()
        self.datfile = ""
        self.latfile = ""
        self.title = ""
        self.label = ""
        self.colLabel = []
        self.rowLabel = []
        self.wrlines = []
        self.dec = 2
    def setDatfile(self,datfile):
        self.datfile = datfile
    def getDatfile(self):
        return self.datfile
    def setLatfile(self,latfile):
        self.latfile = latfile
    def getLatfile(self):
        return self.latfile
    def setTitle(self,title):
        self.title = title
    def getTitle(self):
        return self.title
    def setLabel(self,label):
        self.label = label
    def getLabel(self):
        return self.label
    def setColLabel(self,colLabel):
        self.colLabel = colLabel
    def getColLabel(self):
        return self.colLabel
    def setRowLabel(self,rowLabel):
        self.rowLabel = rowLabel
    def getRowLabel(self):
        return self.rowLabel
    def setDec(self,dec):
        self.dec = dec
    def getRowLabel(self):
        return self.dec
    def printData(self):
        self.tabmat.printTab()
    def setData(self,mat):
        self.tabmat.setTab(mat)
    def readData(self):
        self.tabmat.setFile(self.datfile)
        self.tabmat.reset()
        self.tabmat.readTab()
    def writeTable(self):
        self.wrlines = []
        line = "\\begin{table}\n"
        self.wrlines.append(line)
        line = " \\centering\n"
        self.wrlines.append(line)
        line = " \\caption{" + self.title + "} \n"
        self.wrlines.append(line)
        line = " \\begin{tabular}{cccccccl} \n"
        self.wrlines.append(line)
        line = "   \\toprule \n"
        self.wrlines.append(line)
        line = ""
        length = len(self.colLabel)
        for i in range(length):
            if (i < length-1):
                line = line + "     " + self.colLabel[i] + "     &"
            else:
                line = line + "     " + self.colLabel[i]
        line = line + "\n"
        self.wrlines.append(line)    
        line ="     \\\\ \\midrule \n"        
        self.wrlines.append(line)
        format = "%." + str(self.dec) + "f"
        for i in range(self.tabmat.rows):
            line = "     " + self.rowLabel[i] + "     &"
            for j in range(self.tabmat.cols):
                data_form = format % (float(self.tabmat.data[i][j]))
                if (j < self.tabmat.cols-1):
                    line = line + "     " + data_form + "     &"
                else:
                    line = line + "     " + data_form + "     \n"
            self.wrlines.append(line)
            if (i < self.tabmat.rows-1):
                line ="     \\\\[\\cellspace ] \n"
                self.wrlines.append(line)
        line = " \\\\ \\bottomrule \n"
        self.wrlines.append(line)
        line = "  \\end{tabular} \n"
        self.wrlines.append(line)
        line = "  \\label{" + self.label + "} \n"
        self.wrlines.append(line)
        line = "\\end{table} \n"
        self.wrlines.append(line)
        file = self.latfile
        fp = open(file,'w')
        fp.writelines(self.wrlines)
        fp.close()

import re

class hspiceWave:
    file = ""
    name = ""
    code  = ""
    date = ""
    time = ""
    indVar = ""
    varLst = []
    datTab = table()
    indLen = 0
    rdlines = []
    parSw = -1
    monteNum = 0
    def __init__(self):
        self.file = ""
        self.name = ""
        self.code = ""
        self.data = ""
        self.time = ""
        self.indVar = ""
        self.varLst = []
        self.datTab = table()       
        self.indLen = 0
        self.parSw = -1
        self.rdlines = []
    def setFile(self,file):
        self.file = file
    def getFile(self):
        return self.file
    def getName(self):
        return self.name
    def getCode(self):
        return self.code
    def getMonteNum(self):
        return self.monteNum
    def getDate(self):
        return self.date
    def getTime(self):
        return self.time
    def getVarList(self):
        return self.varLst
    def getDatTab(self):
        return self.datTab.getTab()
    def getSigList(self):
        sigLst = []
        for sigs in self.varLst:
            if len(sigs) > 1:
                tmp = sigs[0] + "_" + sigs[1]
            else:
                tmp = sigs[0]
            sigLst.append(tmp)
        return sigLst
    def getIndVar(self):
        return self.indVar
    def getIndVarLen(self):
        return self.indLen
    def parseHeader(self):
        self.rdlines = []
        fp = open(self.file,'r')
        self.rdlines = fp.readlines()
        fp.close()
        header = ""
        while True:
            line = self.rdlines.pop(0)
            line = line.strip('\n')
            header = header + line
            if line.find("$&%#")>=0 : break
        length = len(header)
        strInd = header.find('*')
        line = header[0:strInd-2]
        self.code = line.strip()
        if self.code[11].find("1") >= 0:
            self.parSw = 1
        header = header[strInd+4:length]
        length = len(header)
        date_rexp = re.compile("\d{2}/\d{2}/\d{4}")
        m = date_rexp.search(header)
        line = header[0:m.start()]
        self.name = line.strip()
        self.date = m.group()
        header = header[m.end():length]
        time_rexp = re.compile("\d{2}:\d{2}:\d{2}")
        m = time_rexp.search(header)
        self.time = m.group()
        length=len(header)
        header = header[m.end():length]
        arr_rexp = re.compile("All Rights Reserved.")
        m = arr_rexp.search(header)
        num_beg = m.end()
        length = len(header)
        header = header[m.end():length]
        ivar_rexp = re.compile("[a-z]",re.IGNORECASE)
        m = ivar_rexp.search(header)
        numvars = header[0:m.start()-1]
        print numvars
        numvarlst = numvars.split()
        self.monteNum = numvarlst[0]
        length = len(header)
        header = header[m.start():length]
        vars = header.split()
        self.indVar = vars[0]
        varList = []
        while True:
                tmp = vars.pop(0)
                if tmp.find("$&%#") >= 0 : break
                pair = tmp.split('(')
                varList.append(pair)
        if self.parSw < 0:
            self.varLst = varList
        else:
            rvarList = []
            rvarList.append(varList.pop(len(varList)-1))
            rvarList.append(varList.pop(0))
            for var in varList:
                rvarList.append(var)
            self.varLst = rvarList
    def parseData(self):
        length = len(self.rdlines)
        datStr = ""
        for i in range(length):
            line = self.rdlines.pop(0)
            line = line.strip('\n')
            datStr = datStr + line
        varLen = len(self.varLst)
        while True:
            length = len(datStr)
            if length <=0 : break
            vals = []
            for j in range(varLen+1):
                strInd = datStr.find("E")
                val = datStr[strInd-7:strInd+4]
                datStr = datStr[11:length]
                vals.append(val)
            self.datTab.appendRow(vals)
        ranges = self.datTab.getRanges()
        self.indLen = ranges[0]
        chkVec = self.datTab.stripRow(self.indLen-1)
        chk_rexp = re.compile("[0.10000E+31]")
        spc_rexp = re.compile("")
        for i in range(varLen):
            if i == 0:
                if chk_rexp.match(chkVec[i]) == None:
                    return -1
                else:
                    if spc_rexp.match(chkVec[i]) == None:
                        return -1
        self.indLen = self.indLen - 1
        return self.indLen
    def parseAcSwData(self):
        length = len(self.rdlines)
        datStr = ""
        for i in range(length):
            line = self.rdlines.pop(0)
            line = line.strip('\n')
            datStr = datStr + line
        while True:
            len_datStr = len(datStr)
            if len_datStr <=0 : break
            ind = datStr.find("0.10000E+31")
            dataLine = datStr[0:ind]
            datStr = datStr[ind+11:len_datStr]
            data = []
            while True:
                len_dataLine = len(dataLine)
                if len_dataLine <=0 : break
                strInd = dataLine.find("E")
                datVal = dataLine[strInd-7:strInd+4]
                dataLine = dataLine[11:len_dataLine]
                data.append(datVal)
            row = []
            for var in self.varLst:
                len_var = len(var)
                if len_var < 2:
                    row.append(data.pop(0))
                else:
                    real = data.pop(0)
                    imag = data.pop(0)
                    complex = real + "+j*" + imag
                    row.append(complex)
            self.datTab.appendRow(row)
        ranges = self.datTab.getRanges()
        self.indLen = ranges[0]
        return self.indLen

class hspiceWaveInter(hspiceWave):
    sigDict = {}
    def printSigList(self):
        for key in self.sigDict:
            print key
    def getSig(self,name):
        return self.sigDict[name]
    def parseInteractive(self):
        sigList = []
        var = []
        var = [self.indVar]
        var.append(self.datTab.stripCol(0))
        sigList.append(var)
        for i in range(varLen):
            var = []
            sig = self.varLst[i][1]
            typ = self.varLst[i][0]
            sigName = typ + "_" + sig
            var.append(sigName)
            var.append(self.datTab.stripCol(0))
            sigList.append(var)
        self.sigDict = dict(sigList)
        self.indLen = self.indLen - 1
        return self.indLen
        
class mdata2sql:
    dbi=dbInterface()
    dbname = ""
    datfile = ""
    tname  = ""
    rowLabels = []
    colLabels = []
    data  = []
    rdlines = []
    wrlines = []
    n = 0
    m = 0
    def getData(self):
        return self.dbi.getTableData()
    def setDbname(self,dbname):
        self.dbname = dbname
    def getDbname(self):
        return self.dbname
    def setDatfile(self,datfile):
        self.datfile = datfile
    def getDatfile(self):
        return self.datfile
    def setTname(self,tname):
        self.tname = tname
    def getTname(self):
        return self.tname
    def setColLabels(self,label):
        self.colLabels.append(label)
    def getColLabels(self):
        return self.colLabels
    def setRowLabels(self,label):
        self.rowLabels.append(label)
    def getRowLabels(self):
        return self.rowLabels
    def readMdata(self):
        data = []
        self.dbi.resetData()
        self.rdlines = []
        file = self.datfile
        fp = open(file,'r')
        self.rdlines = fp.readlines()
        fp.close()
        self.n=0
        line = self.rdlines.pop(0)
        line = line.strip('\n')
        line = line.strip('\t')
        self.colLabels=line.split('\t')
        self.rowLabels=[]
        for line in self.rdlines:
            line = line.strip('\n')
            line = line.strip('\t')
            line = line.strip()
            num_list = line.split('\t')
            data.append([])
            self.m = 0
            for num_elem in num_list:
                num_strip = num_elem.strip()
                num = float(num_strip)  
                data[self.n].append(num)
                self.m = self.m + 1
            self.n=self.n+1
            self.rowLabels.append(self.n)
        self.dbi.setData(data)
    def printData(self):
        for i in range(self.n):
            line = ""
            for j in range(self.m):
                line = line + " " + str(self.dbi.mat.data[i][j])
            print line
    def printRanges(self):
        ranges = self.dbi.getRanges()
        print ranges[0]
        print ranges[1]
    def putDbTable(self):
        self.dbi.setDbFile(self.dbname)
        self.dbi.setTableName(self.tname)
        ranges = self.dbi.getRanges()
        rows = ranges[0]
        cols = ranges[1]
        colType = []
        for col in range(cols):
            colType.append("TEXT")
        rowid = []
        for i in range(rows):
            rowid.append(str(i+1))
        self.dbi.setColLabels(self.colLabels)
        self.dbi.setRowLabels(rowid)
        if self.dbi.exists() < 1:    
            self.dbi.define()
        else:
            self.dbi.dropTable()
            self.dbi.define()
        self.dbi.populate()
    def getDbTable(self):
        self.dbi.setDbFile(dbname)
        self.dbi.setTableName(tName)
        self.dbi.resetData()
        self.dbi.read()
    def putLatex(self):
        self.wrlines = []
        line = "\\begin{table}\n"
        self.wrlines.append(line)
        line = " \\centering\n"
        self.wrlines.append(line)
        line = " \\caption{" + self.title + "} \n"
        self.wrlines.append(line)
        line = " \\begin{tabular}{cccccccl} \n"
        self.wrlines.append(line)
        line = "   \\toprule \n"
        self.wrlines.append(line)
        line = ""
        length = len(self.tlist)
        for i in range(length):
            if (i < length-1):
                line = line + "     " + self.tlist[i] + "     &"
            else:
                line = line + "     " + self.tlist[i]
        line = line + "\n"
        self.wrlines.append(line)    
        line ="     \\\\ \\midrule \n"        
        self.wrlines.append(line)
        for i in range(self.n):
            line = "     " + self.slist[i] + "     &"
            for j in range(self.m):
                data_form = str(self.data[i][j])
                if (j < self.m-1):
                    line = line + "     " + data_form + "     &"
                else:
                    line = line + "     " + data_form + "     \n"
            self.wrlines.append(line)
            if (i < self.n-1):
                line ="     \\\\[\\cellspace ] \n"
                self.wrlines.append(line)
        line = " \\\\ \\bottomrule \n"
        self.wrlines.append(line)
        line = "  \\end{tabular} \n"
        self.wrlines.append(line)
        line = "  \\label{" + self.label + "} \n"
        self.wrlines.append(line)
        line = "\\end{table} \n"
        self.wrlines.append(line)
        file = self.latfile
        fp = open(file,'w')
        fp.writelines(self.wrlines)
        fp.close()

# setDbFile: sets the target database name within the object
# setTableName: sets the target table name
# setRowLabels: Sets the table row labels
# setColLabels: Sets the table col labels
# setColTypes: Sets the type of the column labels
# setXsel: set the target table row location
# seYsel: set the target table col location
# setTarget: set the target?
# getData: returns the objects table data in table object form
# resetData: resets the data in the object
# read: reads a table into the object from the target table
# define: creates a dataase table. This command does not require a
#         the rowid to be embeded in the data. It uses the object's
#         rowid list to populate the first column of the data.
# create: creates a database table with column labels and types. This
#         table assumes that the rowid is embedded in the object data table,
#         and column number one of the object data table is the rowid
# exists: checks to see if the database exists
# populate: adds a rowid to each object data row and adds each row
#           to the newly created table
# dropTable: deletes the objects targe table name from the database
# lisTables: displays a lists all tables residing in the database
# getTables: returns a list of the tables in the database
# appendTextRow: replace a row in a table
# replaceTextRow: replace a row in a text only table
# insertRow: add or insert a row of data entries into the target table
# getTblEntry: get individual table entry by row and col ID values in the object 
# getTblEntryId: get a database table entry using the row ID
# createIndex: 
# setTableData: overwrite the database table with the objects table data. Only data is
#               change - rowid remains the same
# tableExist: checks to see if the objects target table name already exists in the database
