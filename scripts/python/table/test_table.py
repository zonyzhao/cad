#!/usr/bin/python
import sys
sys.path.append('/users/1127110/project/python/table/source/trunk')
import os
import struct
import string
import math
import time
import fileinput
import exceptions
import re
import sqlite3
import table
from __future__ import division

charoot = "/home/swimpenney/projects/char/process"
shared_db = charoot + "/shared/db"

###################
# Set Parasitics
###################
par = "PRELAYOUT"
###################
# Set Test Bias
###################
ibias = "100u"
###################
# Set Reference Width
###################
refw = "1u"
###################
# Corner
###################
corner = "tt60"
###################
# Manually choose node
###################
proc = "sg"
tech = "ln14lpe"
pdk  = "PDK1.0.0.0"
###################
#proc = "gf"
#tech = "cmos14xm"
#pdk  = "v0.3"
###################
#proc = "gf"
#tech = "glof28hpp"
#pdk  = "v1.0"
###################

###################
# Define DB Path
###################
pdkp = pdk.replace(".","p")
db_name = proc + "_" + tech + "_" + pdkp
file_db = shared_db + "/" + db_name + ".db"
#############################
# Define DB Interface Object
#############################
tblo = table.dbInterface()
tblo.setDbFile(file_db)
tblo.getDbFile()
tblo.listTables()

#######################################
## VT/IMAX MEASURE PARSE
#######################################
meas = table.hspParseMeas()
file = charoot + "/" + proc + "/" + tech + "/" + pdk + "/hspice/char_fets_core_w_vt/data/char_fets_core_w_vt.ms0"
meas.setFile(file)
meas.parse()
meas.printDmat()
meas.getDmat()
meas.printIndices()
meas.getIndices()
mlist = meas.getMlist()
mat = meas.getSubDmat([0,100],[0,13])
cols = mlist[0:13]

#######################################
## VT/IMAX DB TABLE
#######################################
tblo = table.dbInterface()
tblo.setDbFile(file_db)

tblName = "core_vt" + "_" + refw + "_" + par
tblo.setTableName(tblName)

colType = []
i = 0
for col in cols:
    if i == 0:
        colType.append("TEXT PRIMARY KEY")
    else:
        colType.append("TEXT")
    i=i+1
    
tblo.setColLabels(cols)
tblo.setColTypes(colType)

if tblo.exists() < 1:    
    tblo.create()
else:
    tblo.dropTable()
    tblo.create()

tblo.listTables()
tblo.listTableColumns()

tblo.setData(mat)
tblo.printTableData()
tblo.setTableData()

tblo.read()
tblo.printTable()

#######################################
## VGS,Gm,Ro Vs nf  Waves
#######################################
wave_vgs = table.hspiceWave()
file = charoot + "/" + proc + "/" + tech + "/" + pdk + "/hspice/char_fets_core_w_dc/data/char_fets_core_w_dc.sw0"
wave_vgs.setFile(file)
wave_vgs.parse()
wave_vgs.getName()
wave_vgs.getIndVar()
cols = wave_vgs.getSigList()
wave_vgs.getVarTab()
data = wave_vgs.getDatTab()

#######################################
## Core FET DC DB TABLE
#######################################
tblo = table.dbInterface()
tblo.setDbFile(file_db)

tblName = "core_dc_w" + "_" + ibias + "_" + par
tblo.setTableName(tblName)

colType = []
i = 0
for col in cols:
    if i == 0:
        colType.append("TEXT PRIMARY KEY")
    else:
        colType.append("TEXT")
    i=i+1
    
tblo.setColLabels(cols)
tblo.setColTypes(colType)

if tblo.exists() < 1:    
    tblo.create()
else:
    tblo.dropTable()
    tblo.create()

tblo.listTables()
tblo.listTableColumns()

tblo.setData(data)
tblo.printTableData()
tblo.setTableData()

tblo.read()
tblo.printTable()

#######################################
## DC gm DB TABLE
#######################################

tblo = table.dbInterface()
tblo.setDbFile(file_db)

tblName = "core_gm_dc" + "_" + ibias + "_" + par
tblo.setTableName(tblName)

colType = []
i = 0
for col in cols:
    if i == 0:
        colType.append("TEXT PRIMARY KEY")
    else:
        colType.append("TEXT")
    i=i+1
    
tblo.setColLabels(cols)
tblo.setColTypes(colType)

if tblo.exists() < 1:    
    tblo.create()
else:
    tblo.dropTable()
    tblo.create()

tblo.listTables()
tblo.listTableColumns()

tblo.setData(data)
tblo.printTableData()
tblo.setTableData()

tblo.read()
tblo.printTable()


######################
# Calculate Veff =Vg-Vds table 
# and output a .dat file
# Fresh DB Start
######################
dbo_0 = table.dbInterface()
dbo_0.setDbFile(file_db)
dbo_0.listTables()

#tblName = "core_vt_" + refw + "_" + par
tblName = "core_vtw_" + ibias + "_" + par
dbo_0.setTableName(tblName)
dbo_0.read()
dbo_0.printTable()

dbo_1 = table.dbInterface()
dbo_1.setDbFile(file_db)

#tblName = "core_vt_" + refw + "_" + par
tblName = "core_vgs_w_" + ibias + "_" + par
dbo_1.setTableName(tblName)
dbo_1.read()
dbo_1.printTable()

data_1 = dbo_1.getData()

tblo_0 = table.table()
tblo_0.setTab(dbo_0.getData())

tblo_1 = table.table()
tblo_1.setTab(dbo_1.getData())

lsto_0 = table.lst()
lsto_0.setLst(tblo_0.getCol(1))

lsto_1 = table.lst()
lsto_1.setLst(tblo_1.getCol(1))

lsto_1 - lsto_0
data_veff = lsto_1.getLst()
data_vt  = lsto_0.getLst()
data_vgs  = tblo_1.getCol(1)

fmat = table.ftable()

file_name = proc + "_" + tech + "_" + pdkp + ".dat"
fmat.setFile(file_name)
fmat.appendCol(data_vgs)
fmat.appendCol(data_vt)
fmat.appendCol(data_veff)
fmat.writeTab()

######################
# FT MEASURE
######################

meas = table.hspParseMeas()
file = charoot + "/" + proc + "/" + tech + "/" + pdk + "/hspice/char_fets_core_diff_w_nfet/data/char_fets_core_diff_w_nfet.ma0"
meas.setFile(file)
meas.parse()
meas.getMlist()
meas.printDmat()
meas.getDmat()
meas.printIndices()
meas.getIndices()
mlist = meas.getMlist()

mat = meas.getSubDmat([0,100],[0,22])



######################
# FT DB TABLE
######################
tblo = table.dbInterface()
tblo.setDbFile(file_db)
tblName = "nfet_w_0"
tblo.setTableName(tblName)

col  = mlist[0:22]
coltyp = ["TEXT PRIMARY KEY","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT",
                             "TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT","TEXT"
                             "TEXT","TEXT"]
tblo.setColLabels(col)
tblo.setColTypes(coltyp)

if tblo.exists() < 1:    
    tblo.create()
else:
    tblo.dropTable()
    tblo.create()

tblo.listTables()
tblo.listTableColumns()

tblo.setData(mat)
tblo.printTableData()
tblo.setTableData()


###################
# READ FT TABLE
###################

tblo.read()
tblo.printTable()

data = tblo.getData()

###################
# File Table to generate Matlab .dat file
###################
fmat = table.ftable()
file_name = "./" + proc + "_" + tech + "_" + pdkp + ".dat"
fmat.setFile(file_name)
fmat.setTab(data)
fmat.writeTab()


#########################
# Parse HSPICE Wave Files
#########################
wave = table.hspiceWave()
wave.setFile("./char_fets_core_w_dc.sw0")
wave.parseHeader()
wave.getSigList()
wave.getIndVar()
wave.parseSwData()
wave.getDatTab()

wave = table.hspiceWave()
wave.setFile("./test_1.ac0")
wave.parseHeader()
wave.getCode()
wave.getName()
wave.varLst
wave.parseAcSwData()
wave.datTab.data
wave.getSigList()

wave = table.hspiceWave()
wave.setFile("./test_1.sw0")
wave.parse()
wave.getDatTab()
wave.getIndVar()
wave.getSigList()
wave.getSig('VOLTS')

wave = table.hspiceWave()
wave.setFile("./test_1.sw0")
wave.parse()
wave.getDatTab()
wave.getIndVar()

wave = table.hspiceWave()
wave.setFile("./ro.tr0")
wave.parse()
wave.getDatTab()
wave.getIndVar()
wave.getIndVarLen()
wave.getCode()
wave.getDate()
wave.getTime()
wave.getVarTab()
wave.getSigList()
wave.getSig("TIME")
wave.getSig("v_n1")
wave.getSig("i_vdd")

wave = table.hspiceWave()

########################
# Test table append row
# and columns
########################
tbl_a = table.table()
tbl_a.create(3,4)
tbl_a.getTab()
row = [1, 2, 3, 4]
tbl_a.setRow(0,row)
row = [5,6,7,8]
tbl_a.setRow(1,row)
tbl_a.getTab()
row = [9,10,11,12]
tbl_a.setRow(2,row)
tbl_a.getTab()

tbl_b = table.table()
tbl_b.create(3,4)
tbl_b.getTab()
row = [11, 12, 13, 14]
tbl_b.setRow(0,row)
row = [15,16,17,18]
tbl_b.setRow(1,row)
tbl_b.getTab()
row = [19,20,21,22]
tbl_b.setRow(2,row)
tbl_b.getTab()

tbl_a + tbl_b
tbl_a.getTab()
tbl_b.getTab()

tbl_a = table.table()
tbl_a.create(3,4)
tbl_a.getTab()
row = [1, 1, 1, 1]
tbl_a.setRow(0,row)
row = [1,1,1,1]
tbl_a.setRow(1,row)
tbl_a.getTab()
row = [1,1,1,1]
tbl_a.setRow(2,row)
tbl_a.getTab()

tbl_b = table.table()
tbl_b.create(3,4)
tbl_b.getTab()
row = [2, 2, 2, 2]
tbl_b.setRow(0,row)
row = [3,3,3,3]
tbl_b.setRow(1,row)
tbl_b.getTab()
row = [4,4,4,4]
tbl_b.setRow(2,row)
tbl_b.getTab()

tbl_a - tbl_b
tbl_a.getTab()
tbl_b.getTab()
tbl_a + tbl_b
tbl_a.getTab()
tbl_b.getTab()
tbl_a * tbl_b
tbl_a.getTab()
tbl_b.getTab()
tbl_a / tbl_b
tbl_a.getTab()
tbl_b.getTab()

tbl.appendCol(row)
tbl.getTab()
tbl.stripRow(3)
tbl.getTab()
tbl.stripCol(3)
tbl.getTab()
tbl.stripCol(3)
tbl.getTab()

tbl.rows


#######################################
## AC SIM SINGLE FREQ  Waves
#######################################
wave = table.hspiceWave()
file = charoot + "/" + proc + "/" + tech + "/" + pdk + "/hspice/char_nfets_core_w_ac/data/char_nfets_core_w_ac.ac0"
wave.setFile(file)
wave.parse()
wave.getName()
wave.getIndVar()
cols = wave.getSigList()
wave.getVarTab()
data = wave.getDatTab()


#########################################
# Populate The Current Density Data
# Table Required for the diffamp script
#########################################
#######################################
# Parse Waves
#######################################
file = charoot + "/" + proc + "/" + tech + "/" + pdk + "/hspice/char_fets_core_w_ac/data/char_fets_core_w_ac.ac0"
wave = table.hspiceWave()
wave.setFile(file)
wave.parseHeader()
wave.getCode()
wave.getName()
wave.getDate()
wave.getTime()
wave.parseAcSwData()
data = wave.datTab.data
data[0]
cols = wave.getSigList()

#######################################
## Diffamp DB TABLES
#######################################
tblo = table.dbInterface()
tblo.setDbFile(file_db)

tblName = "core_nfet" + "_" + corner + "_" + ibias + "_" + par
tblo.setTableName(tblName)

colType = []
i = 0
for col in cols:
    if i == 0:
        colType.append("TEXT PRIMARY KEY")
    else:
        colType.append("TEXT")
    i=i+1
    
tblo.setColLabels(cols)
tblo.setColTypes(colType)

tblo.listTables()

if tblo.exists() < 1:    
    tblo.create()
else:
    tblo.dropTable()
    tblo.create()

tblo.listTables()
tblo.listTableColumns()

tblo.setData(data)
tblo.printTableData()
tblo.setTableData()

tblo.read()
tblo.printTable()

#######################################
## PARSE MONTE CARLO MEASURE
#######################################
meas = table.hspParseMeas()
file = "./sim_TT_0.8V_1.2V_1.5V_65C.ms0"
meas.setFile(file)
meas.parse()
mlist = meas.getMlist()
meas.printIndices()
mind = mlist[791]
vals = meas.getCol(791)
maxval = max(vals)



#######################################
# Parse Monte Carlo DC Sweep
#######################################
file = "sim_TT_0.8V_1.2V_1.5V_65C.sw0"
wave = table.hspiceWave()
wave.setFile(file)
wave.parseHeader()
wave.getCode()
wave.getName()
wave.getDate()
wave.getTime()
wave.getMonteNum()

wave.parseData()
wave.getVarList()
wave.getSigList()
wave.getIndVar()
data = wave.datTab.data
data[0]
cols = wave.getSigList()

###########################################
# Import a Matlab data file into SQL
###########################################
dbname = "plldb"
mdatname = "corner_param_full.txt"
mdata = table.mdata2sql()
mdata.setDbname(dbname)
mdata.setDatfile(mdatname)
mdata.readMdata()
mdata.putDbTable()
###########################################
# Export a SQL table to a Matlab data file
###########################################
mdata = table.mdata2sql()
mdata.setDbname(dbname)
mdata.setDatfile(mdatname)
mdata.getDbTable()
mdata.writeMdata()

###########################################

n=0
for line in rdlines:
    line = line.strip('\n')
    line = line.strip('\t')
    line = line.strip()
    num_list = line.split('\t')
    data.append([])
    m = 0
    for num_elem in num_list:
        num_strip = num_elem.strip()
        num = float(num_strip)  
        data[n].append(num)
        m=m+1
    n=n+1

#########################################
# Matlab Data to SQL DB Import
#########################################
dbname = "plldb"
dfile = "corner_param_full.txt"

mdat = table.mdata2sql()
mdat.setDbname(dbname)
mdat.setDatfile(dfile)
mdat.readMdata()

tabledat = mdat.getData()

colLabels = mdat.colLabels

dbi = table.dbInterface()
tbl = table.table()
tbl.setTab(tabledat)

dbname = "pll.db"
tblName = "pv"
dbi.setDbFile(dbname)
dbi.setTableName(tblName)
dbi.setData(tabledat)
ranges=dbi.getRanges()
rows=ranges[0]
cols=ranges[1]
colType = []
for col in range(cols):
    colType.append("TEXT")
rowid = []
for i in range(rows):
    rowid.append(str(i+1))
dbi.setColLabels(colLabels)
dbi.setColTypes(colType)
dbi.setRowLabels(rowid)
if dbi.exists() < 1:    
    dbi.define()
else:
    dbi.dropTable()
    dbi.define()

dbi.listTableColumns()
dbi.getTableColumnTypes()

dbi.populate()

dbi.listTables()

#########################
# Read the data table
#########################
dbi = table.dbInterface()
dbname = "pll.db"
tblName = "pv"
dbi.setDbFile(dbname)
dbi.setTableName(tblName)
dbi.listTables()

dbi.resetData()
dbi.read()

pdb = sqlite.connect(dbname)
cursor = pdb.cursor()
cmd = "SELECT * FROM " + tblName 
cursor.execute(cmd)
tbl = cursor.fetchall()
