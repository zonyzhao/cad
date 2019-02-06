;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for class existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'lib )
tlib = makeInstance( 'lib )
classp(tlib 'lib)
classOf(tlib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get attribute list of a 
; target library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tlib = makeInstance( 'lib )
tlib->name = "test"
setLibRef(tlib)
tlib~>ref~>??
setAttrList(tlib)
tlib->attributes
getAttrValueByKey(tlib "lastModify")
tlib->ref->name

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Generates a list of the cells
;       view names contained in the 
;       target library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tlib = makeInstance( 'lib )
tlib->name = "XYnumbers"
tlib->name
genCellNameList(tlib)
tlib->cellNameList


; This an UT output for regression testing
fp = outfile("ut1.txt")
foreach( name lib->cellNameList 
	 fprintf( fp "%s\n" name)
) 	
close(fp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: This test checks that the 
;       techfile can be accessed 
;       from the lib object through
;       the child techfile class
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tlib = makeInstance( 'lib )
tlib->name = "XYnumbers"
setName(tlib "XYnumbers")
tlib->name
getName(tlib)
getTechLib(tlib)

tlib->techLib->techFileName
tlib->techLib->techFileProcess
tlib->techLib->techFilePath

tlib->techLib->ref->libName
tlib->techLib->ref->processFamily
tlib->techLib->ref->path

tlib->techLib->ref->??

getAttrValueByKey(tlib "libName")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: This test detaches the techfile
;       from the current library and attaches
;       another techfile to it. Also testst
;       the reattachment of the destached 
;       tech library.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tlib = makeInstance( 'lib )
tlib->name = "XYnumbers"
setName(tlib "XYnumbers")
tlib->name
getName(tlib)
getTechLib(tlib)
unattachTechFile(tlib)
getTechLib(tlib)
attachTechFile(tlib "fooTech")
getTechLib(tlib)
unattachTechFile(tlib)
getTechLib(tlib)
attachTechFile(tlib "RRFC_2metal")
getTechLib(tlib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: This test tests the encapsulation
;       of all the cells in the target 
;       libary into layout cell objects
;       using the cv class
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "XYnumbers"
lib->name
genCellNameList(lib)
lib->cellNameList

;Instantiate a layout cell object
cell = makeInstance( 'cv )
;Populate its members
setLib(cell "XYnumbers")
setName(cell nth(0 lib->cellNameList))
setView(cell "layout")
cvRef = dbOpenCellViewByType( lib->name nth(0 lib->cellNameList) "layout" "maskLayout")
setRef(cell cvRef)
;Get the target cell and dump it's attributes
setAttrList(cell)
;Inspect the attribute member of the cell object
cell->attributes
getAttrValueByKey(cell "libName")
getAttrValueByKey(cell "cellName")
getAttrValueByKey(cell "DBUPerUU")
getAttrValueByKey(cell "userUnits")
getAttrValueByKey(cell "isParamCell")
getAttrValueByKey(cell "subMasters")
getAttrValueByKey(cell "superMasters")

foreach( name lib->cellNameList
	 cell = makeInstance( 'cv )
	 cell->name = name
	 cell->lib = "XYnumbers"
	 cvRef = dbOpenCellViewByType( "XYnumbers" name "layout" "maskLayout")
	 setRef(cell cvRef)
	 dbu = getAttrValueByKey(cell "DBUPerUU")
	 uun = getAttrValueByKey(cell "userUnits")
	 getUsedLayers(cell)
	 printf("%s , UU: %s, DBU: %n \n", name uun dbu)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6a: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "pa0715"
lib->name
getUsedLayers(lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6b: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "XYnumbers"
lib->name
getUsedLayers(lib)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6c: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "PLL_80B"
lib->name
PLL_80B_ll = getUsedLayers(lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6d: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "POL_80B"
lib->name
POL_80B_ll = getUsedLayers(lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6d: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "PML_80B"
lib->name
PML_80B_ll = getUsedLayers(lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6d: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "PLL_80B_Eng"
lib->name
PML_80B_Eng_ll = getUsedLayers(lib)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Find layers of P80_B tech libraries
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
llist = append(append(append(PML_80B_Eng_ll PML_80B_ll) POL_80B_ll) PLL_80B_ll)
lst = makeInstance( 'listfun )
setElems(lst llist)
P80B_TECH_layers = removeRedundant(lst)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6e: Test getting the used layers
;       in a library object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'lib )
lib->name = "pa0715"
lib->name
pa0715_ll = getUsedLayers(lib)

; golden list of pa0715 library layers
goldenList_pa0715 = list("marker" "break" "ScribePro" "gateBus" "aebleText"
    "GRID" "BCBmetal" "BCBLid" "BCBCorral" "AlignBA"
    "noDrc" "Tgate" "gate1" "sdText" "LayerZero"
    "GateFlag" "thinTa" "EgateStem" "l64" "capTa"
    "eBeamMark" "outline" "DBgrid" "sputNit" "bumppost"
    "tmPlate" "TMPost" "gatePass" "capPad" "diodeTop"
    "diodeStem" "recess" "masterMark" "BCBinv" "BCB"
    "dgate" "catho" "obsolete" "digSect" "anode"
    "RFpad" "DCpad" "BCBPlug" "taProt" "TgateTop"
    "gatePad" "leGatePad" "leGate" "mesa" "gateTop"
    "gateStem" "glass" "keepout" "GAP" "SStop"
    "via" "thick" "Metal2" "SCFP" "nitEtch"
    "capBot" "nitEtch1" "sd" "met2Pass" "stretch"
    "bridge" "text" "ta"
)

goldenList_P80B = list()


;Union of P80_B and pa0715 layer lists
union(lst pa0715_ll)

goldenUnion = list("marker" "ScribePro" "gateBus" "aebleText" "GRID"
    "BCBmetal" "BCBLid" "BCBCorral" "AlignBA" "noDrc"
    "Tgate" "gate1" "sdText" "LayerZero" "GateFlag"
    "thinTa" "EgateStem" "l64" "capTa" "eBeamMark"
    "outline" "DBgrid" "sputNit" "bumppost" "tmPlate"
    "TMPost" "gatePass" "capPad" "diodeTop" "diodeStem"
    "recess" "masterMark" "BCBinv" "BCB" "dgate"
    "catho" "obsolete" "digSect" "anode" "RFpad"
    "DCpad" "BCBPlug" "taProt" "TgateTop" "gatePad"
    "leGatePad" "leGate" "mesa" "gateTop" "gateStem"
    "glass" "keepout" "GAP" "SStop" "via"
    "thick" "Metal2" "SCFP" "nitEtch" "capBot"
    "nitEtch1" "sd" "met2Pass" "stretch" "bridge"
    "text" "ta" "debug" "sputNit" "ScribePro"
    "LayerZero" "gatePass" "thinTa" "ta" "GRID"
    "noDrc" "Tgate" "gap" "l67" "EgateTop"
    "sdText" "catho" "digSect" "dgate" "anode"
    "BCBPlug" "recess" "GateFlag" "taProt" "capPad"
    "bridge" "glass" "tmPlate" "TMPost" "gate1"
    "TgateTop" "gatePad" "leGatePad" "leGate" "gateTop"
    "gateStem" "obsolete" "BCBinv" "BCB" "RFpad"
    "DCpad" "thick" "stretch" "keepout" "mesa"
    "Metal2" "SCFP" "nitEtch" "capBot" "nitEtch1"
    "sd" "met2Pass" "GAP" "text" "SStop"
    "via" "gateBus" "EgateStem" "gate" "PTMXover"
    "marker" "l64" "aebleText" "AlignBA" "BCBCorral"
    "BCBLid" "BCBmetal" "diodeStem" "diodeTop" "masterMark"
    "bumppost" "outline" "DBgrid" "eBeamMark" "capTa"
    "solderBar" "DgateStem" "leGateFlag"
)




intersection(lst pa0715_ll)


goldenIntersection = list("sputNit" "ScribePro" "LayerZero" "gatePass" "thinTa"
    "ta" "GRID" "noDrc" "Tgate" "sdText"
    "catho" "digSect" "dgate" "anode" "BCBPlug"
    "recess" "GateFlag" "taProt" "capPad" "bridge"
    "glass" "tmPlate" "TMPost" "gate1" "TgateTop"
    "gatePad" "leGatePad" "leGate" "gateTop" "gateStem"
    "obsolete" "BCBinv" "BCB" "RFpad" "DCpad"
    "thick" "stretch" "keepout" "mesa" "Metal2"
    "SCFP" "nitEtch" "capBot" "nitEtch1" "sd"
    "met2Pass" "GAP" "text" "SStop" "via"
    "gateBus" "EgateStem" "marker" "l64" "aebleText"
    "AlignBA" "BCBCorral" "BCBLid" "BCBmetal" "diodeStem"
    "diodeTop" "masterMark" "bumppost" "outline" "DBgrid"
    "eBeamMark" "capTa"
)

length(goldenUnion)
length(goldenIntersection)

tf = makeInstance( 'techfile )
setName(tf "RRFC_2metal")
tid=getTechFileRef(tf)
TF_ll = setTechLayers(tf)
length(TF_ll)
printLayers(tf)

gu_list = makeInstance( 'listfun )
setElems(gu_list goldenUnion)
intersection(gu_list TF_ll)
intersectionNot(gu_list TF_ll)

test_lst = makeInstance( 'listfun )
setElems(test_lst TF_ll)
; layers that we need to have that are currently in the TF
tf_intersection_goldenList = intersection(test_lst goldenList)
length(goldenList)
length(tf_intersection_goldenList)
; layers that we need to add to the TF
test_lst1 = makeInstance( 'listfun )
setElems(test_lst1 goldenList)
removeElems(test_lst1 tf_intersection_goldenList)
intersection(test_lst1 goldenUnion)
length(intersection(test_lst1 goldenUnion))
tf_intersectionNot_goldenUnion = intersectionNot(test_lst1 goldenUnion)
length(tf_intersectionNot_goldenUnion)
; layers in the TF that we do not need
setElems(test_lst1 goldenUnion)
goldenUnion_intersectionNot_tf = intersectionNot(test_lst1 TF_ll)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Get the directory path name of 
; target library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tlib = makeInstance( 'lib )
tlib->name = "pa0715"
setLibRef(tlib)
setLibPath(tlib)
getPath(tlib)

######################################################
# Experimental Code
#######################################################
techGetDefaultTechName

tf = techGetTechFile(ddGetObj("XYnumbers"))

tf->??

gridSet = techIsMfgGridResolutionSet(tf)
mfgGrid = techGetMfgGridResolution(tf)

techFindViaDefByName(tf "via_metal")

techGetDeviceInClass(tf "controls" "techParams")


techGetParams(tf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-: Testing the generation of
;       library lists 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = makeInstance( 'library )
getLibList(lib)
lib->libList

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Generating a list of cells in
;  a library - belongs in lib class  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib=ddGetObj("libname")
lib~>cells~>name
lib~>cells

foreach(mapcar cell lib~>cells list(cell~>name cell)