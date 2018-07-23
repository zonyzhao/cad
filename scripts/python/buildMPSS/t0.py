###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# WARNINGS FILTER
warnings.filterwarnings("ignore")

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the photofile
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "~/"
doc.save(docName)
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# WARNINGS FILTER
warnings.filterwarnings("ignore")

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the photofile
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "./"
doc.save(docName)
sys.stdout.write("Test 0 MPSS complete")
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# WARNINGS FILTER
warnings.filterwarnings("ignore")

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the photofile
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "/users/1127110/gitRepo/mpss/test"
doc.save(docName)
os.system("mv %s %s" % (docName, docxPath))
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the photofile
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "/users/1127110/gitRepo/mpss/test"
doc.save(docName)
os.system("mv %s %s" % (docName, docxPath))
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the PhotoInfo file
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "/users/1127110/gitRepo/mpss/test"
doc.save(docName)
os.system("mv %s %s" % (docName, docxPath))
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

# ERROR OUTPUT TO THE CADENCE IPC THAT CALLS THIS PYTHON CHILD SCRIPT
# effectively redirects error messages to stdout so cadence can read them
sys.stderr = sys.stdout

#Read the PhotoInfo file
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "/users/1127110/gitRepo/mpss/test"
doc.save(docName)
os.system("mv %s %s" % (docName, docxPath))
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

#Read the PhotoInfo file
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
create_header(doc, 5, "core", multi)

# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docName = "core.docx"
docxPath = "/users/1127110/gitRepo/mpss/test"
doc.save(docName)
#os.system("mv %s %s" % (docName, docxPath))
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

#Read the PhotoInfo file
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docxPath = "/users/1127110/gitRepo/mpss/doc/core.docx"
doc.save(docxPath)
###################################################################################
# Test 0: Testing of Layer Class and Layer Class helper procedures
###################################################################################
# This test Generates the Core page of the MPSS with either a 5x Core or
# multi-image Core mask table for a the reticle
###################################################################################

# Assumes that the "god" layer-object and all "helper" procedural code is 
# already loaded

# GLOBAL VARIABLES
#processes for each of the types, add to these if there are more proccesses
GaN =["P80A", "P80B", "P81","P85"]
GaAs = ["P46", "P51", "P60", "P70"]
other = ["P82", "D83", "D82"]
GaNFile = "GaAn_RSS.xlsx"
GaAsFile = "GaAs_RSS.xlsx"
otherFile = "other.xlsx"
GaNSheet = "GaN Master"
GaAsSheet = "GaAs Master"
otherSheet = "DEV"
rssPath = "/users/1127110/gitRepo/mpss/excel/"
northSouthDiagram = "/users/1127110/gitRepo/mpss/data/northSouthDiagram.png"

#Read the PhotoInfo file
photofile = open(photofile, "r")
lines = photofile.readlines()
photofile.close()

#Parse the photofile header
design = lines[0].split()[-1]
primary = lines[1].split()[-1]
secondary = lines[2].split()[-1]
processType = lines[3].split()[-1]
stepRepeatX = lines[4].split()[-2]
stepRepeatY = lines[4].split()[-1]


#strip out the letter for all except P80, ie P46H becomes P46
if not processType[-1].isdigit() and not ("P80" in processType):
    strippedProcess = processType[:-1]
else: strippedProcess = processType

# Generate a List of populated Layer Objects by parsing out the
# data from the RSS spreadheet
layerList = process_worksheet(strippedProcess)

#create the MPSS Word document
doc = Document()
style = doc.styles["Normal"]
font = style.font
font.name = "Times New Roman"
font.size = Pt(12)
#get the date(for header)
today = datetime.date.today()
date = today.strftime("%m/%d/%Y")

##############################################cores##########################################################
# Place the core layers into tables. If the mask is multi-image, create a multi-image table of core layers.
# If the mask is not multi-image make a 5x table of the core layers
#############################################################################################################
# Create layer list of "Core" Layer objects only
coreLayers = getLayers("Core", layerList)

if multi:
    createMultiImageTable(doc, coreLayers, design, strippedProcess)
    #add the north/south image and center align it
    doc.add_picture(northSouthDiagram)
    doc.paragraphs[-1].alignment = WD_ALIGN_PARAGRAPH.CENTER
else: 
    createFiveXTable(doc, coreLayers, "core", design)

# Page Notes
doc.add_paragraph("NOTES:")
doc.add_paragraph("END NOTES")
# Page Break
doc.add_page_break()

# Save the document
docxPath = "/users/1127110/gitRepo/mpss/doc/core.docx"
doc.save(docxPath)
exit
