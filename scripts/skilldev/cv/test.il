;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cv )
cell = makeInstance( 'cv )
classp( cell 'cv)
classOf(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate Recursive Tree (DFS)
; Simple cell: pcell instance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
name="ln246_3p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
getTree(cell)
leafs = getLeafCells(cell)
length(leafs)
;;
; list all the leafs in the design
;;
for(i 0 sub1(length(leafs))
  leaf = nth(i leafs)
  printf("%d) Cell name:  %s \n" i leaf->name)
);for
;;
; Define the target layer
;;
lay = makeInstance( 'techLayer )
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
;;
; list all the leafs that contain a via
;;
for(i 0 sub1(length(leafs))
  leaf = nth(i leafs)
  cv = dbOpenCellViewByType( leaf->lib leaf->name "layout" "maskLayout")
  setRef(lay cv)
  if(!null(getShapesOnLayer(lay)) then
    printf("%d) %s found via shapes in leaf cell\n" i leaf->name)
  );if
);for

leaf = nth(0 leafs)
;leaf = nth(0 cell->leafCells->list->elems)
;length(cell->leafCells->list->elems)
leaf->name
leaf->lib
leaf->bbx->bbox


cell_flat = makeInstance( 'cv )
lib="ln0246"
view="layout"
name_flat="ln246_3p_chip_00_flat"
setView(cell_flat view)
setName(cell_flat name_flat)
setLib(cell_flat lib)
if(!null(isCell(cell_flat))
  println("Flattened cellview exists in library - removing ...")
  removeCell(cell_flat)
  Copy(cell name_flat)
else
  Copy(cell name_flat)
);if

cv_flat = dbOpenCellViewByType( lib name_flat "layout" "maskLayout" "a")
setRef(cell_flat cv_flat)
smash(cell_flat)
dbSave(cv_flat)
dbClose(cv_flat)

insts = getInstances(cell)
for(i 0 sub1(length(insts))
  inst = nth(i insts)
  dbFlattenInst(inst 32 t)
);for
dbSave(cv_flat)
dbClose(cv_flat)

lib="ln0246"
view="layout"
cv_via = dbOpenCellViewByType( lib "viaTest" "layout" "maskLayout" "w")

name_flat="ln246_3p_chip_00_flat"
cv_flat = dbOpenCellViewByType( lib name_flat "layout" "maskLayout" "r")

lay = makeInstance( 'techLayer )
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
setRef(lay cv_flat)
getShapesOnLayer(lay)
setRef(lay cv_via)
renderShapesOnLayer2(lay)
dbSave(cv_via)
dbClose(cv_via)
dbClose(cv_flat)

;;
; Check for the presence of a layer in any leaf cell of the 
; cellview
;;

for(i 0 sub1(length(leafs))
  leaf = nth(i leafs)
  cv = dbOpenCellViewByType( leaf->lib leaf->name "layout" "maskLayout")
  setRef(lay cv) 
  if(!null(getShapesOnLayer(lay)) then
    printf("%d) %s found via shapes in leaf cell\n" i leaf->name)
    setRef(lay cv_via)
    renderShapesOnLayer2(lay)
  );if
);for

dbSave(cv_via)
dbClose(cv_via)
dbClose(cv)

leaf3 = nth(2 leafs)
leaf3->name
l3cv = dbOpenCellViewByType( leaf3->lib leaf3->name "layout" "maskLayout")
setRef(lay l3cv) 
getShapesOnLayer(lay)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Generate Recursive Tree (DFS)
; Complex cell: Reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pd0164"
name="pd0164_0p"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
getTree(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Test getting the cell 
;       dimensions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pd0164"
name="pd0164_0p"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
getName(cell)
getView(cell)
getRef(cell)

; Need to get bounding box property first
getbBox(cell)
getDim(cell)

cell->bb->width
cell->bb->height

fp = outfile("ut2.txt")
fprintf( fp "nam: %s\n" cell->name)
fprintf( fp "lib: %s\n" cell->lib)
fprintf( fp "wid: %f\n" cell->bb->width)
fprintf( fp "hgt: %f\n" cell->bb->height)	  	
close(fp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3
; This tests the alignment of the 
; cell to the reference position of
; the cell origin aligned to the 
; upper right hand quadrant of the 
; cellviews master field
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

cell = makeInstance( 'cv )
cell->lib = "test"
cell->name = "test_origin_shift"
cell->view = "layout"

getbBox(cell)
getOrigin(cell)
cellA->x0
cellA->y0
getDim(cell)
cellA->bbwidth
cellA->bbheight

shiftURQ(cell)

getAttrList(cell)
cell->attr

vals = getAttrValues(cell)

nth(0 vals)
nth(1 vals)
nth(2 vals)
nth(3 vals)
nth(4 vals)
nth(5 vals)
nth(6 vals)
nth(7 vals)
nth(8 vals)

length(vals)

foreach(x vals
	  println(x)
)

attribute = '()
value = '()
vals = cdr(vals)
m = 1
foreach(x vals
	  if( (m > 0) then
	      attribute = cons(x attribute)
	      m = -1
	  else
	      value = cons(x value)
              m = 1
	  )
)

hashlist = '()
i=0
foreach(x attribute
	  y = nth(i value)
	  println(x)
	  i=i+1
	  rlist = '()
	  rlist = cons(y rlist)
	  rlist = cons(x rlist)	  
	  println(rlist)
	  hashlist = cons(rlist hashlist)
)

key = stringToSymbol("bBox")
coords = nth(1 assq( key hashlist))

key = stringToSymbol("cellView")
cvid = nth(1 assq( key hashlist))

type   = getAttrValueByKey(cell "objType")
cvtype = getAttrValueByKey(cell "cellViewType")
bound  = getAttrValueByKey(cell "bBox")
cvid   = getAttrValueByKey(cell "cellView")
lib    = getAttrValueByKey(cell "libName")
libid  = getAttrValueByKey(cell "lib")
name   = getAttrValueByKey(cell "cellName")
view   = getAttrValueByKey(cell "viewName")
dbu    = getAttrValueByKey(cell "DBUPerUU")
file   = getAttrValueByKey(cell "fileName")
insCnt = getAttrValueByKey(cell "anyInstCount")
useru  = getAttrValueByKey(cell "userUnits")
	  
getAttr(cell 0)
getAttr(cell 1)
getAttr(cell 2)
getAttr(cell 3)
getAttr(cell 4)

getAttrValue(cell 0)
getAttrValue(cell 1)
getAttrValue(cell 2)
getAttrValue(cell 3)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5
; Test Cell Exist, Remove and Copy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cellA = makeInstance( 'layCell )
cellA->library = "XYnumbers"
cellA->cellName = "wpnums_xyPad_SLA"
cellA->viewName = "layout"
isCell(cellA)

cellB = makeInstance( 'layCell )
cellB->library  = "test"
cellB->cellName = "wpnums_xyPad_SLA"
if(isCell(cellB) then
   removeCell(cellB)
else
   copyCell(cellB "XYnumbers" "wpnums_xyPad_SLA")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6
; Test Create New Cell View
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7
; Copy another cellview into current
; cellview (child cellview instance)
; Child cell is centered at origin
; of parent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cellA = makeInstance( 'layCell )
cellA->library = "test"
cellA->cellName = "child"
cellA->viewName = "layout"
isCell(cellA)
;FIXME: Need a constructor to define this list prior
;       to adding a child to the children list
; messin' with a member
slotValue(cellA 'children)
setSlotValue(cellA 'children '())
slotValue(cellA 'children)
setSlotValue(cellA 'children cons( "foo" slotValue(cellA 'children)))
slotValue(cellA 'children)
setSlotValue(cellA 'children '())
slotValue(cellA 'children)

cellA->children = '()
slotValue(cellA 'children)

cellB = makeInstance( 'layCell )
cellB->library = "XYnumbers"
cellB->cellName = "wpnums_xyPad_SLA"
cellB->viewName = "layout"
isCell(cellB)

newCellInstance(cellA cellB->library cellB->cellName)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8
; Tests cellView database "sniffing"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cell = makeInstance( 'layCell )
cell->library = "PLL_80B_PCELLS"
cell->cellName = "p80B_1_grid_E"
cell->viewName = "layout"
getAttrList(cell)
getAttrValueByKey(cell "isParamCell")
propBag=getAttrValueByKey(cell "prop")
prop0a = nth(0 propBag)
prop0a->??
prop0a->prop
prop0b = nth(1 propBag)
prop0b->??
prop0b->prop
prop0c = nth(2 propBag)
prop0c->??
prop0c->prop
prop0d = nth(3 propBag)
prop0d->??

prop1a=prop0d->prop
prop1a=nth(0 prop1a)
prop1a->??
prop1a=prop0d->prop
prop2a=nth(1 prop1a)
prop2a->??
prop2a=prop2a->prop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9
; Tests getLib method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cell = makeInstance( 'layCell )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Test if cv is a "leaf" cell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="XYnumbers"
name="wpnums_xyPad_SLA"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
isLeaf(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-11: Test getting the instances
;        of the cellview. Flat 
;        - no recursion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
;name="ln246_3p_wafer_flat"
name="WaferViaMask"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
insts = getInstances(cell)
length(insts)
inst0 = nth(0 cv->instances)
inst0~>name
inst0~>cellName
inst0~>isFull
inst0~>?
inst0~>??
inst0~>bBox
dbClose(cv)
for(i 0 sub1(length(insts))
  inst = nth(i cv->instances)
  printf("%s " inst~>name)
  printf("%s " inst~>cellName)
  printf("%L\n" inst~>isFull)
);for
foreach(insts list(cv~>instances)
  inst~>name	  
);foreach
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-12: Test getting the recursive 
;        heirarchical tree of the cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-13: Test printing the recursive 
;        heirarchical tree of the cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)
printTree(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-14: Test getting the recursive
;        Names List
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)
nameList = '()
getTreeNames(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-15: Test getting the recursive 
;        heirarchical tree of the cv (second case)
;        (Negative case failing on missing library
;         deseg)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ts0455"
name="ts455_0p"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-16: Test getting the recursive 
;        layer list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00_bias2"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getLayers(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-17: Test getting the recursive 
;        layer list (another lib)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="XYnumbers"
name="asml_1_cd_cross_1X_A"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getLayers(cell)
getUsedLayers(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-18: Tests getting both the cellview
;        and it's library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)
cellnames = getTreeNames(cell)
libnames = getLibTreeNames(cell)
printTree(cell)
liblst = makeInstance('listfun)
setElems(liblst libnames)
flattenRecursive(liblst)
cellst = makeInstance('listfun)
setElems(cellst cellnames)
flattenRecursive(cellst)
for( i 0 sub1(length(liblst->elems))
  printf("CELL: %s, LIB: %s\n" nth(i cellst->elems) nth(i liblst->elems))
);for

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-19: Tests closing and purging a 
;        cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0s_xyn"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
closeAndPurge(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-20: Tests remove a 
;        cellview from a library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0s_xyn"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
removeCell(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-21: Tests remove a list of
;        cellviews from a library 
;        "Clean"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0s_xyn"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell view)
setName(cell name)
setLib(cell lib)
cvList = list( "pa715_0p_aeblemap" 
               "pa715_0p_startmap" 
  	       "pa715_0p_sites" 
	       "pa715_0p_wafer" 
	       "pa715_0p_wafer_Flat" 
	       "pa715_0s_xyn" 
	       "pa715_0p_xyn" 
	       "pa715_0p_wpnums");list
clean(cell cvList)
getName(cell)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-22: Populate the instance object
;        with all the leaf instances
;        within the cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
getTree(cell)
cellnames = getTreeNames(cell)
libnames = getLibTreeNames(cell)
printTree(cell)

liblst = makeInstance('listfun)
setElems(liblst libnames)
flattenRecursive(liblst)
cellst = makeInstance('listfun)
setElems(cellst cellnames)
flattenRecursive(cellst)
for( i 0 sub1(length(liblst->elems))
  printf("CELL: %s, LIB: %s\n" nth(i cellst->elems) nth(i liblst->elems))
);for

;;;;;;;;;;;;;;;;;;;;;;;
; Need a list of leaf
; cells only

leafNameList = '()
inst = makeInstance( 'cv )

;;;;;;;;;;;;;;;;;;;;;;;;
; This for loop is 
; scanning for leaf cells only
; but we need the leaf cell name 
; and its source library (leafs 
; will most probably come from 
; tech libs)
; FIXME: WHY DO I HAVE TO REPEAT THE FOLLOWING FOR LOOP TWICE!! ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
i=0                                                                                              ;
foreach(n cellst->elems                                                                          ;
    printf("Checking instance %s" n)                                                             ;
    cvRef = dbOpenCellViewByType( lib n view "maskLayout")                                       ;
    setRef(inst cvRef)                                                                           ;
    if(!null(isLeaf(inst)) then                                                                  ;
      println(" Is LEAF")                                                                        ;
      leafNameList = cons(list(n nth(i liblst->elems)) leafNameList)                             ;         
    else                                                                                         ;
      println(" Is Not LEAF")                                                                    ;
    );if                                                                                         ;
    i++                                                                                          ;
);foreach                                                                                        ;
                                                                                                 ;
                                                                                                 ;
;listing of leafs and their libs                                                                 ;       
for( i 0 sub1(length(liblst->elems))                                                             ;
  printf("CELL: %s, LIB: %s\n" nth(0 nth(i leafNameList)) nth(1 nth(i leafNameList)))            ;
);for                                                                                            ;
;FIXME: if you see a nil error in printing execute the for loop above ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instanceObjList = '()
for(i 0 sub1(length(leafNameList))
	  iobj = makeInstance('instance)
	  setName(iobj nth(0 nth(i leafNameList)))
	  setLib(iobj nth(1 nth(i leafNameList)))
	  setView(iobj view)
	  setParent(iobj name) 
	  setInstRef(iobj)
	  getUsedLayers(iobj)
	  instanceObjList = cons(iobj instanceObjList)
);for

nth(0 instanceObjList)->name 
nth(0 instanceObjList)->parent
nth(0 instanceObjList)->ref
nth(0 instanceObjList)~>iLayers~>elems
nth(i instanceObjList)->iNames
nth(i instanceObjList)->iLibNames
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Now that we have a list of leaf instance
; objects and the layers used in the intance
; object, let's scan for cells that have a
; specific layer used in them
targ = "keepout"
targList = '()
for(i 0 sub1(length(leafNameList))
   if(!null(isElem(nth(i instanceObjList)~>iLayers targ)) then
     targList = cons(list(nth(i instanceObjList)->name  nth(i instanceObjList)->lib) targList)
   )
);for
targList 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-23: Tests the smashing of cell
;        heirarchy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	  
lib="test"
; Names of the cellviews to be acted on
name  = "p80B_1_fet_mult_F"
fname = "p80B_1_fet_mult_F_flattened"
sname = "p80B_1_fet_mult_F_snapshot"
view="layout"
; Delete the clone (if it exists)
cv = dbOpenCellViewByType( lib fname view "maskLayout")
; Create the reusable object
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell fname)
setLib(cell lib)
removeCell(cell)
; Delete the snapshot cellview (if it exists)
cv = dbOpenCellViewByType( lib sname view "maskLayout")
setRef(cell cv)
setName(cell fname)
removeCell(cell)
; Open the target cell to be flattened
cv = dbOpenCellViewByType( lib name view "maskLayout")
setRef(cell cv)
setName(cell name)
; Copy the target cell to clone
cv = copyCell(cell lib fname)
; Close the clone
dbSave(cv)
dbClose(cv)
; Open the clone in append mode
cv = dbOpenCellViewByType( lib fname view "maskLayout" "a")
setRef(cell cv)
setName(cell fname)
; Get the instances of the clone
getInstances(cell)
; Smash the cell heirarchy
smash(cell)
; Save the flattened cell
dbSave(cv)
dbClose(cv)
; Open the flattened cell in read mode
cv = dbOpenCellViewByType( lib fname view "maskLayout")
setRef(cell cv)
setName(cell fname)
; Get the stackup of the flattened cellview
getStackUp(cell)
; Remove the text layer of the cellview stackup
removeLayerFromStackup(cell "text")
printStackUp(cell)
; Open snapshot cell in write mode
cv = dbOpenCellViewByType( lib sname view "maskLayout" "w")
setRef(cell cv)
setName(cell sname)
; Save the stackup of the flattened cell to the snapshot cell
snapshot(cell)
; save and close the snapshot cell
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-24 Copy Cell to another name in the
;       same library
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pd0164"
name="pd0164_0p"
view="layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setName(cell name)
setLib(cell lib)
setView(cell view)
copyName = "pd0164_0p_shifturq"
Copy(cell copyName)
ddGetObj(getLib(cell) getName(cell) getView(cell))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-25 Clone the object to another object
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib  = "pd0164"
name = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setOid(cell "foo")
setName(cell name)
setLib(cell lib)
setView(cell view)
getRef(cell)
getOid(cell)
getName(cell)
getLib(cell)
getView(cell)
; Clone object
cellcp = makeInstance( 'cv )
cloneCv(cell cellcp)
getRef(cellcp)
getOid(cellcp)
getName(cellcp)
getLib(cellcp)
getView(cellcp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-26
; Cellview Replace Test:
; Test Cell Removal, Copy from reference cell,
; and check valid replaced cell has instances ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cellA = makeInstance( 'cv )
setName(cellA "ln246_3p_wafer")
setLib(cellA "ln0246")
setView(cellA "layout")
isCell(cellA)

cellB = makeInstance( 'cv )
setName(cellB "WaferViaMask")
setLib(cellB "ln0246")
setView(cellB "layout")
isCell(cellB)
if(isCell(cellB) then
   removeCell(cellB)
else
   copyCell(cellA "ln0246" "WaferViaMask")

cellC = makeInstance( 'cv )
setName(cellB "WaferViaMask")
setLib(cellB "ln0246")
setView(cellB "layout")
isCell(cellB)
hasInstance(cellB)
insts = getInstances(cellB)
for(i 0 sub1(length(insts))
  inst = nth(i insts)
  printf("%s\n" inst~>cellName)
);for

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-27: Remove all instances in a cellview that are not in the
;        target library 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="ln0246"
name="ln246_3p_wafer_flat_copy"
view="layout"
;cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
cv = dbOpenCellViewByType( lib name view "maskLayout" "a")
;cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
dbIsId(cv)
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
insts = getInstances(cell)
length(insts)

; Deleting instances without the isFull property being true
for(i 0 sub1(length(insts))
  inst = nth(i insts)
  if(dbIsId(inst) then
    cond(
      (inst~>isFull 
        printf("INFO: Full Site Detected: %s\n" inst~>cellName)
	inst = dbCreateInst( cv master nil 0:0 "R0" 1)
      );inst~>isFull
      ((!null(getShapesOnLayer(lay)) 
        (
          printf("INFO: Instance Containing Via Shapes Detected: %s\n" inst~>cellName) 
        )
      );getLayer()
      ((t) 
        (
          printf("INFO: Deleting Full Site Instance %s\n" inst~>cellName)
          dbDeleteObject(inst)
        )
      );t
    );cond
  );if	  
);for

insts = getInstances(cell)
length(insts)

; Deleting instances that are not in the target library
for(i 0 sub1(length(insts))
  inst = nth(i cv->instances)
  cvi = dbOpenCellViewByType( lib inst~>cellName view "maskLayout")
  if(null(cvi) then
    if(!null(dbDeleteObject(inst)) then
      println("INFO: Deleting instance not in local library")
    );if
  );if	  
);for
insts = getInstances(cell)
length(insts)
inst0 = nth(0 cv->instances)
inst0~>name
inst0~>cellName
inst0~>isFull
inst0~>?
inst0~>??
inst0~>bBox
for(i 0 sub1(length(insts))
  inst = nth(i cv->instances)
  if(inst~>isFull then
    printf("%s " inst~>name)
    printf("%s \n" inst~>cellName)
  else
;    if(dbIsId(inst) then
      print("INFO: Removing non full site instance %s \n" inst~>cellName)
      dbDeleteObject(inst)
;    );if
  );if
;  printf("%L\n" inst~>isFull)
);for

insts = getInstances(cell)
length(insts)

foreach(insts list(cv~>instances)
  inst~>name	  
);foreach
dbSave(cv)
dbClose(cv)

nth(0 nth(0 cell->stack->stack->list->elems)->shapes->list->elems)->vertices

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-28: Process a flattened wafer cellview by placing only 
;        valid vias into a cellview
;
;  FIXME: This produced a 5TByte layout file in Cadence!! Cadence crash attempting to read it!!
;
;  Steps:
;        1.) Create a new wafer via mask cellview
;        2.) Filter instances in the flattened wafer cellview generated by xyn.il for valid sites and instances containing via shapes
;          2.a) Copy the valid sites into a temporary cellview and flatten the temporary cellview
;          2.b) Copy via shapes on the via layer into the new wafer via mask cellview
;          2.c) Clean the temporary cellview by deleting all instances
;          2.d) Copy the via shape containing instances to the temporary cellview 
;          2.e) flattening the cellview, and detect shapes on the via layer.
;          2.f) Copy the via shapes on the via layer to the new wafer via mask cellview
;          2.g) Clean the temporary cellview by deleting all instances 
;        3.) Delete the temporary cellview, save/close the new wafer via cellview, and close the flattened wafer cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
; Step 1.) Create a new wafer via mask cellview
;;
;;
; Create the new Wafer Via Cellview
;;
lib="ln0246"
name_via="ln246_3p_wafer_via"
view="layout"
cell_via = makeInstance( 'cv )
setView(cell_via view)
setLib(cell_via lib)
setName(cell_via name_via)
if(isCell(cell_via) then
  println("INFO: Wafer Via cellview exists in library - removing ...")
  removeCell(cell_via)
  println("INFO: Creating new Wafer Via cellview.")
  cv_via = dbOpenCellViewByType( lib name_via view "maskLayout" "w")
else
  println("INFO: Creating new Wafer Via cellview.")
  cv_via = dbOpenCellViewByType( lib name_via view "maskLayout" "w")
);if
setRef(cell_via cv_via)
;;
; Step 2.)
;;
name_wf="ln246_3p_wafer_flat_copy"
view="layout"
cv_wf = dbOpenCellViewByType( lib name_wf view "maskLayout" "r")
cell_wf = makeInstance( 'cv )
setRef(cell_wf cv_wf)
setView(cell_wf "layout")
setName(cell_wf name_wf)
setLib(cell_wf lib)
insts_wf = getInstances(cell_wf)

setRef(cell_temp cv_temp)
;;
; Tech layer for filtering via shapes
;;
lay = makeInstance( 'techLayer )
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
;;
; This is the processing loop for via cellview generation ...
; WARNING: This runs extremely slowly!
; NOTE: Every via shape in every valid via cell is being rendered
;       into the new Wafer Via cellview. This can be sped up by
;       just copying valid cells into the Wafer Via cellview, and also
;       copying instances with detected via shapes into the cell view.
;       A via layer only stream out of the Wafer Via cellview provides
;       the mask data for the wafer contact mask. It will be a little
;       messier, but much faster ... 
;;
printf("INFO: Wafer Instances : %d\n" length(insts_wf))
for(i 0 sub1(length(insts_wf))  
  inst = nth(i insts_wf)
  printf("INFO: %d.) Processing Wafer Instance : %s\n" i inst~>cellName)
  if(dbIsId(inst) then
    setRef(lay inst)
    cond(
      (inst~>isFull
         printf("INFO: Full Site Detected: %s\n" inst~>cellName)
         copyInstance(cell_temp inst)
	 dbSave(cv_temp)
      	 smash(cell_temp)
      	 setRef(lay cv_temp)
      	 if(null(getShapesOnLayer(lay)) then
           printf("INFO: No Via Shapes Found In Full Site: %s\n" inst~>cellName)
	 else
      	   setRef(lay cv_via)
      	   renderShapesOnLayer2(lay)
	   dbSave(cv_via)
           deleteAllInstances(cell_temp)
           dbSave(cv_temp)
         );if
      );inst~>isFull
      (!null(getShapesOnLayer(lay)) 
         printf("INFO: Instance %d Containing Via Shapes Detected: %s\n" i inst~>cellName) 
      );!null(getShapesOnLayer(lay))
      (t 
         printf("INFO: Deleting Instance %s\n" inst~>cellName)
         dbDeleteObject(inst)
      );t
    );cond
  );if
);for
removeCell(cell_temp)
;dbSave(cv_temp)
;dbClose(cv_temp)
dbSave(cv_via)
dbClose(cv_via)
dbClose(cv_wf)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-29: Process a flattened wafer cellview by placing only 
;        valid vias into a cellview
;
;  New version of UT-29 that just saves cellview instances and not individual vias
;
;  Steps:
;        1.) Create a new wafer via mask cellview
;        2.) Filter instances in the flattened wafer cellview generated by xyn.il for valid sites and instances containing via shapes
;          2.a) Copy the valid sites into a temporary cellview and flatten the temporary cellview
;          2.b) Copy via shapes on the via layer into the new wafer via mask cellview
;          2.c) Clean the temporary cellview by deleting all instances
;          2.d) Copy the via shape containing instances to the temporary cellview 
;          2.e) flattening the cellview, and detect shapes on the via layer.
;          2.f) Copy the via shapes on the via layer to the new wafer via mask cellview
;          2.g) Clean the temporary cellview by deleting all instances 
;        3.) Delete the temporary cellview, save/close the new wafer via cellview, and close the flattened wafer cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
; Step 1.) Create a new wafer via mask cellview
;;
;;
; Create the new Wafer Via Cellview
;;
lib="ln0246"
name_via="ln246_3p_wafer_via"
view="layout"
cell_via = makeInstance( 'cv )
setView(cell_via view)
setLib(cell_via lib)
setName(cell_via name_via)
if(isCell(cell_via) then
  println("INFO: Wafer Via cellview exists in library - removing ...")
  removeCell(cell_via)
  println("INFO: Creating new Wafer Via cellview.")
  cv_via = dbOpenCellViewByType( lib name_via view "maskLayout" "w")
else
  println("INFO: Creating new Wafer Via cellview.")
  cv_via = dbOpenCellViewByType( lib name_via view "maskLayout" "w")
);if
setRef(cell_via cv_via)
;;
; Step 2.)
; Open the reference wafer flat cellview
;;
name_wf="ln246_3p_wafer_flat_copy_small"
view="layout"
cv_wf = dbOpenCellViewByType( lib name_wf view "maskLayout" "r")
cell_wf = makeInstance( 'cv )
setView(cell_wf "layout")
setName(cell_wf name_wf)
setLib(cell_wf lib)
setRef(cell_wf cv_wf)
insts_wf = getInstances(cell_wf)
;;
; Create the temporary instance for flattening and via shape filtering
;;
name_temp="wafer_via_temp"
cell_temp = makeInstance( 'cv )
setName(cell_temp name_temp)
setView(cell_temp "layout")
setLib(cell_temp lib)
if(isCell(cell_temp) then
  println("INFO: Wafer Via Temp cellview exists in library - removing ...")
  removeCell(cell_temp)
  println("INFO: Creating new Wafer Via Temp cellview.")
  cv_temp = dbOpenCellViewByType( lib name_temp view "maskLayout" "w")
else
  println("INFO: Creating new Wafer Via Temp cellview.")
  cv_temp = dbOpenCellViewByType( lib name_temp view "maskLayout" "w")
);if
setRef(cell_temp cv_temp)
;;
; Tech layer for filtering via shapes
;;
lay = makeInstance( 'techLayer )
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
setRef(lay cv_temp)
;;
; This is the processing loop for via cellview generation ...
;
;;
printf("INFO: Wafer Instances : %d\n" length(insts_wf))
for(i 0 sub1(length(insts_wf))  
  inst = nth(i insts_wf)
  printf("INFO: Process wafer instance [ %d ] Instance name : %s\n" i inst~>cellName)
  if(dbIsId(inst) then
    if(inst~>isFull then
       printf("INFO: Full Site Detected: %s\n" inst~>cellName)
       copyInstance(cell_via inst)
       dbSave(cv_via)
    else
       printf("INFO: Non-Full Site Instance Detected: %s\n" inst~>cellName)
       copyInstance(cell_temp inst)
       smash(cell_temp)
       dbSave(cv_temp) 
       setRef(lay inst)
       if(!null(getShapesOnLayer(lay)) then
         printf("INFO: Instance Containing Via Shapes Detected: %s\n" inst~>cellName) 
         copyInstance(cell_via inst)
         dbSave(cv_via)
         deleteAllInstances(cell_temp)
         dbSave(cv_temp)
       else      
         printf("INFO: No via shapes found. Ignoring Instance: %s\n" inst~>cellName)
         deleteAllInstances(cell_temp)
         dbSave(cv_temp)
       );if
    );if
    else
      printf("ERROR: Invalid Instance. No instance ID. Deleting Instance %s\n" inst~>cellName)      
  );if
);for
removeCell(cell_temp)
;dbSave(cv_temp)
;dbClose(cv_temp)
dbSave(cv_via)
dbClose(cv_via)
dbClose(cv_wf)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-29: Verify that the new wafer via cellview (generated in UT-28) is correct 
;
;  Steps:
;        1.) Copy the flattened wafer cellview generated by xyn.il to a temporary cellview
;        2.) Stream via layer from the temporary cellview
;        3.) Delete the temporary cellview
;        4.) Stream in the GDS from step 2 into the a temporary cellview 
;        5.) Perform a via layer diff between the new wafer via mask cellview and the temporary cellview
;        6.) If the diff comes out clean stream out the new wafer via mask into the release directory
;        7.) If the diff is not clean print out an error to the console and no stream out is performed
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PA0715
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="pa715_0p"
name="pa715_0p_chip_00"
name="pa715_0p_chip_00_guts"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Output Matching Network
name="pa715_0p_chip_00_omn"
; 3rd Stage Amp
name="pa715_0p_chip_00_3rdStFets"
; Inter-Stage Matching Network #2
name="pa715_0p_chip_00_ismn2"
; 2nd Stage Amp
name="pa715_0p_chip_00_2ndStFets"
; Inter-Stage Matching Network #1
name="pa715_0p_chip_00_ismn1"
; First Stage Amp
name="pa715_0p_chip_00_6x66FET"
; Input Matching Network
name="pa715_0p_chip_00_imn"
; Bias
name="pa715_0p_chip_00_bias2"
name="pa715_0p_autoBias"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "PLL_80B"
name = "p80B_1_res_mesa_A"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "PLL_80B_Eng"
name="p80B_1_finger_option1_A"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "test"
name = "heir_test"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cellList = '()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(0 cv~>lpps)~>?
nth(0 cv~>lpps)~>layerName
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( getLpps(@key cv cLst)
  prog( (instRef rlist)
       if(!null(cv~>instances) then
         if( length(cv~>instances) > 0 then
	   rlist = '()
       	   foreach( instance cv~>instances
	     printf("Sniffing ID->[%L]: CV->%s: INST->%s(%s)\n" instance cv~>cellName instance~>cellName instance~>name)
	     instRef = dbOpenCellViewByType(instance~>libName instance~>cellName "layout" "maskLayout")
             rlist = cons(getLpps(?cv instRef ?cLst '()) rlist)  
	   );foreach
	   return(cons(rlist cLst))
         else
           printf("Leaf Cell: ID->[%L]: %s\n" cv cv~>cellName)
	   foreach( lpp cv~>lpps
	   	 printf("Leaf Cell Layer: %s: %s\n" cv lpp~>layerName)
		 if(!null(lpp~>layerName) then
		   rlist = cons(lpp~>layerName rlist)
                 else
		   return(rlist)
		 );if 
	   );foreach
           return(rlist)
         );if
      else
         printf("INFO (getCells): No cellview instances found - leaf cell: %s\n" cv~>cellName)
	 foreach( lpp cv~>lpps
	   	 printf("Leaf Cell Layer: %s: %s\n" cv lpp~>layerName) 
		 if(!null(lpp~>layerName) then
		   rlist = cons(lpp~>layerName rlist) 
		 else
		   return(rlist)
		 );if   
	 );foreach
	 return(rlist)
      );if
  );let
);procedure

outList = getLpps(?cv cv ?cLst '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; V2 - Flatten recursive list - belongs in listfun?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( flattenRecurseList(@key hlist flist)
  prog( (retList)
    retList = '()
    printf("Recursed List: %L\n" flist)
    if(listp(hlist) then
      if( length(hlist) != 1 then
        for( i 0 sub1(length(hlist))
          if( listp(nth(i hlist)) then
	    printf("Detected List %L\n", nth(i hlist))
	    retList = append(flattenRecurseList(?hlist nth(i hlist) ?flist flist) retList)
	  else
            printf("Nested Layer added %L\n", nth(i hlist))
	    retList = cons(nth(i hlist) retList)		    
	  );if
        );for
        return(append(flist retList))
      else
        println("Nested List Detected")
        retList = append(flattenRecurseList(?hlist nth(0 hlist) ?flist flist) retList)
        return(retList)
      );if
      else 
        return(cons(hlist retList))
    );if
  );prog
);procedure

flatList = flattenRecurseList(?hlist outList ?flist '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Remove redundant list items
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( removeRedundantItems(list rlist)
  prog( (item retList)
    retList = rlist
    if(length(list)>0 then
      item = nth(0 list)
      printf("Adding Item: %s\n" item)
      retList = cons(item retList)
      retList = append(removeRedundantItems( remove(item list) '()) retList) 
      return(retList)
    else
      println("List expired")
      return(retList)	
    );if
  );prog
);procedure

removeRedundantItems(flatList '())



procedure( getCells(@key cv cLst)
  prog( (instRef llist rlist)
       cLst = cons(cv cLst)
       if(!null(cv~>instances) then
         if( length(cv~>instances) > 0 then
           llist = '()
	   rlist = '()
       	   foreach( instance cv~>instances
	     printf("Sniffing ID->[%L]: CV->%s: INST->%s(%s)\n" instance cv~>cellName instance~>cellName instance~>name)
	     instRef = dbOpenCellViewByType(instance~>libName instance~>cellName "layout" "maskLayout")
             rlist = cons(getCells(?cv instRef ?cLst llist) rlist)  
	     ;dbClose(instRef)
	   );foreach
	   return(cons(rlist cLst))
         else
           printf("INFO: Leaf Cell: ID->[%L]: %s\n" cv cv~>cellName)
           return(cv)
         );if
       else
         printf("INFO: Leaf cell: ID->[%L] %s\n" cv cv~>cellName)
	 return(cv)
       );if
  );let
);procedure

outList = getCells(?cv cv ?cLst '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; get Tree names
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

procedure( getTreeNames(@key hlist nlev nList)
  prog( (revlist plist)
  	nlev++
	if( listp(hlist) then
	  revlist = reverse(hlist)
	  if( !listp(nth(0 revlist)) && listp(nth(1 revlist)) then
	    nList = cons(nth(0 revlist)~>cellName nList) 
	    plist = nth(0 cdr(revlist))
	    for(i 0 sub1(length(plist))
	        nList = cons(getTreeNames(?hlist nth(i plist) ?nlev nlev ?nList '()) nList)
	    );for
	    return(nList)
	   else
	     nList = cons(nth(0 hlist)~>cellName nList) 
	     return(nList)
	   );if
	else
	   nList = cons(hlist~>cellName nList)
	   return(nList)
	);if
  );prog
);procedure


nameList = '()
levelList = '()

hlist = outList
cellList = reverse(getTreeNames(?hlist hlist ?nlev 0 ?nList nameList))


procedure( getLibs(@key cv cLst)
  prog( (instRef llist rlist)
       cLst = cons(cv cLst)
       if(!null(cv~>instances) then
         if( length(cv~>instances) > 0 then
           llist = '()
	   rlist = '()
       	   foreach( instance cv~>instances
	     printf("Sniffing ID->[%L]: CV->%s: INST->%s(%s)\n" instance cv~>cellName instance~>cellName instance~>name)
	     instRef = dbOpenCellViewByType(instance~>libName instance~>cellName "layout" "maskLayout")
             rlist = cons(getLibs(?cv instRef ?cLst llist) rlist)  
	     ;dbClose(instRef)
	   );foreach
	   return(cons(rlist cLst))
         else
           printf("INFO: Leaf Cell: ID->[%L]: %s\n" cv cv~>libName)
           return(cv)
         );if
       else
         printf("INFO: Leaf cell: ID->[%L] %s\n" cv cv~>libName)
	 return(cv)
       );if
  );let
);procedure

libOutList = getLibs(?cv cv ?cLst '())


procedure( getLibNames(@key hlist nlev nList)
  prog( (revlist plist)
  	nlev++
	if( listp(hlist) then
	  revlist = reverse(hlist)
	  if( !listp(nth(0 revlist)) && listp(nth(1 revlist)) then
	    nList = cons(nth(0 revlist)~>libName nList) 
	    plist = nth(0 cdr(revlist))
	    for(i 0 sub1(length(plist))
	        nList = cons(getLibNames(?hlist nth(i plist) ?nlev nlev ?nList '()) nList)
	    );for
	    return(nList)
	   else
	     nList = cons(nth(0 hlist)~>libName nList) 
	     return(nList)
	   );if
	else
	   nList = cons(hlist~>libName nList)
	   return(nList)
	);if
  );prog
);procedure


libNameList = '()

hlist = libOutList
libList = reverse(getLibNames(?hlist hlist ?nlev 0 ?nList libNameList))

liblst = makeInstance('listfun)
setElems(liblst libList)
flattenRecursive(liblst)
cellst = makeInstance('listfun)
setElems(cellst cellList)
flattenRecursive(cellst)

for( i 0 sub1(length(liblst->elems))
  printf("Name %s, Lib %s\n" nth(i cellst->elems) nth(i liblst->elems))
);for


;###############################################################################################
;# This standard skill procedure recursively finds all the instances of the given name in 
;# a cellview heirarchy
;###############################################################################################
procedure(getAllInstances(cv name @optional (transform list(0:0 "R0" 1)) (hierInstPath "/"))
  let( (InternalCellInfo iname)
    iname = lowerCase(name)
    foreach(inst cv~>instances
      when(inst~>objType=="inst"
	printf("Checking instance: %s\n" inst~>cellName)
	if( rexMatchp(iname lowerCase(inst~>cellName)) then
	  InternalCellInfo = list(inst~>cellName  dbTransformPoint(inst~>xy transform) inst~>orient)
	  GLOBAL_INST = cons(InternalCellInfo GLOBAL_INST)
	  printf("Adding %s to list" inst~>cellName)
	);if 
	getAllInstances(inst~>master iname dbConcatTransform(inst~>transform transform) strcat(hierInstPath inst~>cellName "/"))
      );while
    );foreach
    t
  );let
);proc