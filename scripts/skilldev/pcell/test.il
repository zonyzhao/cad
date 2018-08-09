;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'pcell )
pc = makeInstance( 'pcell )
classp( pc 'pcell)
classOf(pc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: test to see if target cv
;       ref is a pcell 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="memsChipFrame"
lib="reticle"
view = "layout"
type =  "maskLayout"
cv = dbOpenCellViewByType( lib name view type)
pc = makeInstance( 'pcell )
setRef(pc cv)
isPcell(pc)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: get a pcell instance within
;       a pcell 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="memsChipFrameTest"
lib="pd0164"
view = "layout"
type =  "maskLayout"
cv = dbOpenCellViewByType( lib name view type "a")
pc = makeInstance( 'pcell )
setRef(pc cv)
isPcell(pc)
hasInstance(pc)
getInstances(pc)
ncv = nth(0 getInstances(pc))
; Zero level is the instance itself
ncv~>?
ncv~>cellName
ncv~>baseName
; one level up to find master
master = ncv~>master
master~>instances
pci0 = nth(0 master~>instances)
pci0~>?
pci0~>cellName
pci0~>bBox
pci0~>purpose
pci0~>objType
pci0~>libName
pci0~>master
pci0~>master~>cellName
pci0~>master~>libName
pci0~>master~>lpps
lpp0 = nth(0 pci0~>master~>lpps)
lpp0~>layerName
lpp0~>purpose
lpp1 = nth(1 pci0~>master~>lpps)
lpp1~>layerName
lpp1~>purpose
pci1 = nth(1 master~>instances)
pci2 = nth(2 master~>instances)
pci3 = nth(3 master~>instances)
; two levels up to find superMaster
superMaster = master~>superMaster
superMaster~>cellName
; Now I know the instance is indeed a PCELL
superMaster~>isParamCell
; Get and manipulate the pcell instance (master) properties
ncv~>prop
p0 = nth(0 ncv~>prop)
p0~>name
p1 = nth(1 ncv~>prop)
p1~>name
p2 = nth(2 ncv~>prop)
; found spm property
p2~>name
p2~>valueType
p2~>value

; evals with updated value - good!!
p2~>value = 1.0
p2~>value
p3 = nth(3 ncv~>prop)
p3~>name
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: generates the pcell code
;       and save's it to the file
;       arg of the skillGen method 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="memsChipFrame"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
pc = makeInstance( 'pcell )
setCvRef(pc cv)
isPcell(pc)
skillGen(pc "./memsCF.il")
dbClose(cv)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: get the pcell parameters
;       from the property bag 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="memsChipFrame"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
pc = makeInstance( 'pcell )
setCvRef(pc cv)
isPcell(pc)
getParams(pc)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: generates the pcell code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

name="p46_2_label_A"
name="co_1_label_A"

name="co_1_label_anyLayer_A"
lib="CommonOverhead"
cv = dbOpenCellViewByType( lib name "layout")
cv = dbOpenCellViewByType( lib name "layout_xform")
pc = makeInstance( 'pcell )
setCvRef(pc cv)
isPcell(pc)
filename = strcat("./" name ".ils")
skillGen(pc filename)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: generates the pcell code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

name="label"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cv~>instances
iref = nth(0 cv~>instances)
iname = iref~>cellName
ilib = iref~>libName
cviref = dbOpenCellViewByType( ilib iname "layout" "maskLayout")
pc = makeInstance( 'pcell )
setCvRef(pc cviref)
isPcell(pc)
filename = strcat("./" iname ".il")
skillGen(pc filename)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: generates the pcell code
;       5p1 version
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="co_1_label_anyLayer_A"
lib="CommonOverhead"
cv = dbOpenCellViewByType( lib name "layout")
filename = strcat("./" name ".ils")
pcSkillGen(cv filename nil)

##############################################
# Experimental Code
##############################################
dbDumpPcDefinePcell(cv filename)
dbCheckParamCell(cv)
dbEvalParamCell(cv)
dbFixParamCell(cv filename)

;Converts cv into a SKILL file
; not sure what "g_isSkillFile" arg is??
pcSkillGen(cv, ofile, g_isSkillFile)

; lIst point notation:
x:y is equivalent to list(x y)
; Rectangles and ellipses are defined with bounding boxes. A bounding box
; is a specified lsit of coordinate pairs where the first pair refers to the 
; lower left corner (llc) and the second pari refers to the upper right corner (urc)

;You can use analog design-style labels such as cdsName(), cdsParam(1), cdsParam(2) to
;display information about an instance. Labels are controlled by the CDF label set 
;attributes. Refer to "Component Description Format User Guile" for more info.

;For labels to be evaluated correctly, you must set labelType to "ILLabel" as follows:
label = dbCreatelabel(pcCellView
		      '("text" "drawing")
		      x:y
		      "cdsName()"
		      "lowerLeft"
		      "R0"
		      "stick"
		      5.0
);dbCreateLabel
label->labelType="ILLabel"

; The pcFix function lets you correct machine-dependent round-off error. If the argument
; of pcFix is no more that 0.001 away from an integer value, the pcFix returns the integer
;value:
pcFix(1.999999) returns 2.0
pcFix(2.000001) returns 2.0
pcFix(2.1)      returns 2.1

; See pcRound in the "Graphical Parameterized Cell Skill Functions" chapter.
pcRound(n_num [f_precision] [x_tolerance]) => x_results


; The following commands can be used to build geometries
dbCreatePath(d_cellview (tx_layer t_purpose) l_points x_widths t_pathStyle))
dbCreatePolygon(d_cellview (tx_layer t_purpose) l_points)
dbCreateRect(d_cellview (tx_layer t_purpose) l_bBox)
dbCreateEllipse(d_cellview (tx_layer t_purpose) l_bBox)
dbCreateDonut(d_cellview (tx_layer t_purpose) l_point x-outR x_holeR)
dbCreateLabel(d_cellview (tx_layer t_purpose) l_point t_label t_just t_orient t_font x_height)

; Accessing supermasters from an instance - must look two levels up!
; this gets you the supermaster
I1~>master~>superMaster
; this gets you the instance sub-master
I1~>master 

; Example of setting pcell formal parameters from the techfile
; parameters and thier default values:
list(
	(param1  ddGetObj("libName")~>param1Default)
	(param2  techGetParam(techGetTechFile(pcCellView,param2Default)))
);end of parameter list

; Creating Instances with Pcells
; instances of other cells within a pcell
; Create the following in the Pcell code:
; 1.) Get the cellview ID of the cell to add as an instance:
  cellId = dbOpenCellViewByType( gt_lib t_cellName lt_viewName)
; 2.) Create an instance of this cell:
  inst = dbCreateInst( d_cellView d_master nil l_point t_orient 1)
; 3.) If the instance is a Pcell, use
  inst = dbCreateParamInst(d_cellView d_master nil l_point t_orient 1
                             list(
				list( param1Name "float" 10.)
				list( param2Name "string" "some sting" )
                             );list
                          );dbCreateParamInst

; Building Nets, Terminals, and Pins
; The following steps show how to define pins in a layout Pcell:
; 1.) Create the shape that will server as the pin
; Normally a rectangle - cannot be a polygon!!
fig = dbCreateRect(d_cellView tx_layer list(x1:y1 x2:y2))
; 2.) Create the net to which the pint attaches. In this example the pin name n1 matches
;     the corresponding pin in the schematic symbol for this cell:
net = dbCreateNet(d_cellView "n1")
; 3.) Create a terminal on the same net
; The terminal mus have the same name as the net and match the terminal type. In 
; this example, the terminal type is inputOutput, the same terminal typ as the 
; corresponding pin in the schematic symbol:
trm = dbCreateTerm(d_net "n1" "inputOutput")
; 4.) Create a pin
pin = dbCreatePin(d_net d_fig "n1")
; The pin dababase object connects the pin figure with the net. The pin name 
; can match the terminal name but does not have to. In the example, the pin name
; n1 matches the terminal name.
; Within the Pcell, you can have multiple shapes that all belong to the same electrical
; terminal. Each shape would have a pin to associate it to the same net. In such cases,
; each pin is created on the same net and must have a unique pin name
; 5.) If your tool requires pins to have an access direction, define the acess direction:
pin~>accessDir = '("top" "left")
; The access direction is a list identifying the correct sides of the pin shape for connection

;Accessing Technology File Data
; You can access nominal and minimum dimensions and other technology file information from
; with a Pcell, using tech procedures. Use tech procedures to keep process-specific 
; information, such as layer-to-layer spacings, localized to the technology file. Make sure
; rules you want to read from teh technology file are defined there before you load your Pcell
; code otherwise the Pcell compilation fails.
;
; The following three examples show how to get data from the technology file:

; Example 1
Access a single-layer spacing rule, such as minimum width:
tf = techGetTechFile(d_cellView)
d = techGetSpacingRule(tf "minWidth" "layerName")

; Example 2
Access a two-layer property, such as the minimum spacing between two layers
d = techGetSpacingRule(tf "minSpacing" "layer1" "layer2")

; Example 3
Access your own user-created property, such as the layer name for shapes:
techGetlayerProp(tf "layerName" "propName")



#####################################################################################
# Pcell compiler code
#####################################################################################

; getnPcell.il 
; Code to create a Pcell super master for mesaResistor
pcDefinePCell(list(ddGetObj("test") "mesaResistor" "layout")
  (
	( wid  "float" 5)
	( len  "float" 15)
  )
  let((pcell)
	pcell = makeInstance('mesaResistor)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell

; getnPcell.il 
; Code to create a Pcell super master for CORE
pcDefinePCell(list(ddGetObj("test") "CORE" "layout")
  (
	( cyanW  "float" 0.6)
	( greenL  "float" 0.8)
	( greenW "float" 0.2)
	( cyanL  "float" 0.2)

  )
  let((pcell)
	pcell = makeInstance('CORE)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell

; Code to create a Pcell super master for RING
pcDefinePCell(list(ddGetObj("test") "RING" "layout")
  (
	( ringW  "float" 0.1)
	( ringS  "float" 0.1)

  )
  let((pcell)
	pcell = makeInstance('RING)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell

; Code to create a Pcell super master for WRAP
pcDefinePCell(list(ddGetObj("test") "WRAP" "layout")
  (
	( ringW  "float" 0.1)
	( cyanW  "float" 0.6)
	( greenL  "float" 0.8)
	( greenW "float" 0.2)
	( cyanL  "float" 0.2)
	( ringS  "float" 0.1)
  )
  let((pcell)
	pcell = makeInstance('WRAP)
	setPcellParams(pcell pcCellView)
	draw(pcell)
  );let
);pcDefinePcell
; end of file genPcell.il

;
;Start of file - genPcDef.il
; Generate Pcell definition file in user specified directory 
; based on specified name, lib name, cell name, and draw function
; 
; getPcellCodeFromClass( 
;        s_className t_libName t_cellName t_viewName t_pcFilename t_drawFuncName)
; Ex:
: getPcellCodeFromClass( 'WRAP "test" "WRAP" "layout" "./pcWrap.il" "draw")
;
procedure( getPcellCodeFromClass(
	   _className libN cellN viewN filePathName drawFuncName)
  let((oport params device str dirpath)
  when( !filePathName || filePathName == ""
    warn("File path name is empty.\n")
    return()
  ); when
  oport = outfile(filePathName "w")
  fprintf(oport "pcDefinePCell(\n\tlist(ddGetObj(\"%s\") \"%s\" \"%s\")\n" 
          libN cellN viewN)
  ; Output parameters section
  device = makeInstance(concat(_className))
  fprintf(oport "\t(\n")
  params = getPcellParams(device)
  foreach( param params
  	   case( cadr(param)
	   	("int"
			fprintf(oport "\t\t( %s \"int\" %d)\n" car(param) caddr(param))
           	);int
	   	("float"
			fprintf(oport "\t\t( %s \"float\" %f)\n" car(param) caddr(param))
           	);float
  	   	("string"
			fprintf(oport "\t\t( %s \"string\" %s)\n" car(param) caddr(param))
           	);string
	   	("boolean"
			fprintf(oport "\t\t( %s \"boolean\" %L)\n" car(param) caddr(param))
           	);boolean
	   	("ILList" "ilList"
			fprintf(oport "\t\t( %s \"ILList\" %L)\n" car(param) caddr(param))
           	);ILList
	   	(t
			 warn("Unsupported type %s on parameter %s skipped\n" car(param) caddr(param))
           	);t
	  );case
   );foreach
   fprintf(oport "\t\n")
   ; Output the standard Pcell code section
   fprintf(oport "\tlet(pcell)\n")
   fprintf(oport "\t\tpcell = makeInstance('%s)\n" _className)
   fprintf(oport "\t\tsetPcellParams(pcell pcCellView)\n") 
   fprintf(oport "\t\t%s(pcell)\n" drawFuncName)
   fprintf(oport "\t)")
   fprintf(oport ")\n")
   close(oport)
   ; Auto generate Pcell superMaster by user defined Pcell class
   ; load(filePathName)
   ; load("pcWrap.il")
   );let
);procedure

; End of file - genPcDef.il

lib = "pa0715"
name = "segment"
view = "layout"

pcDefinePCell(list(ddGetObj("pa0715") "segment" "layout") 
             ((Radius float 5.0) 
	      (Grid float 0.025) 
	      (Layer string "sd"))
	      let(( pcParameters pcParamProp layer purpose cir poly)
		    pcParameters = pcCellView->parameters->value
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Radius")))
		    Radius = pcParamProp->value
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Grid"))) 
		    Grid = pcParamProp->value 
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Layer")))
		    layer = pcParamProp->value
		    dbReplaceProp( pcCellView "viewSubType" "string" "maskLayoutParamCell") 
		    cir = makeInstance( 'circle )
		    cir->radius=Radius
		    cir->grid=Grid
		    generate(cir)
		    purpose = "drawing" 
		    dbCreatePolygon(pcCellView 
			            list(Layer purpose)
			            cir->vertices)
		);let
);pcDefineCell


cv = dbOpenCellViewByType( lib name view "maskLayout")"memsChipFrame"
nth(0 cv~>prop)~>valueType
nth(0 cv~>prop)~>value

nth(0 nth(0 cv~>prop)~>value)->?
nth(0 nth(0 cv~>prop)~>value)->valueType
nth(0 nth(0 cv~>prop)~>value)->value

nth(1 nth(0 cv~>prop)~>value)->valueType
nth(1 nth(0 cv~>prop)~>value)->value

nth(2 nth(0 cv~>prop)~>value)->valueType
nth(2 nth(0 cv~>prop)~>value)->value

nth(3 nth(0 cv~>prop)~>value)->valueType
nth(3 nth(0 cv~>prop)~>value)->value