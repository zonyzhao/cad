:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'techLayer )
lay = makeInstance( 'techLayer )
classp( lay 'techLayer)
classOf(lay)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get all shapes on a given
;       layer - IMPORTANT!!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Capture the layer shapes in a cellview
name="wafer_4"
lib="ln0246"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "outline"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
shapes = lay->shapes->list->elems
nth(0 shapes)->ref~>layerName
nth(0 shapes)~>vertices
;nth(1 shapes)->ref~>layerName
;nth(1 shapes)->vertices

tran = makeInstance( 'transform2 )
setVertices(tran nth(0 shapes)->vertices)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THIS IS IMPORTANT: It's the bridge between Cadence Shapes and the
; Skill++ Object System ...
; Build up a structure - shapes to assemblies ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
geom = makeInstance( 'geometry )
num=length(shapes)
for(i 0 num-1
  temp = makeInstance( 'transform2 )
  setVertices(temp getItem(getShapes(lay) i)->vertices)
  addTransform(geom temp)
)

getItem(getPoints(getVertices(getItem(geom->transforms 0))) 0)->x
getItem(getPoints(getVertices(getItem(geom->transforms 0))) 0)->y

; Open a cv for write and rendor the target layer
name="inclusionRing"
lib="ln0246"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(geom cv)
render(geom)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: delete all shapes on a given
;       layer
; FIXME need to add all shapes to a
; newly opened cellview with write permissions
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="Wafer_4_noWindows"
lib="pd0164"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "membrane"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
deleteShapesOnLayer(lay)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: add a simple rectangle
;       shape object to a layer 
;       object. Could represent a 
;       reticle, chip or coupon
;       via their boundary box.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; set shape vertices
; 1000x1000 "text" Square
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(0.0 0.0)
v1 = list(0.0 1000.0)
v2 = list(1000.0 1000.0)
v3 = list(1000.0 0.0)
v4 = list(0.0 0.0)
vertices = list(v0 v1 v2 v3 v4)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shp = makeInstance( 'shape )
setVertices(shp->transform vertices)
setLayer(shp "text")
setPurpose(shp "drawing")
; Create a layer object
lay = makeInstance( 'techLayer )
layName = "text"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getName(lay)
getLayer(shp)
addShape(lay shp)
name="reticle"
lib="pd0164"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(lay cv)
renderShapesOnLayer(lay)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Logical and of two layers
;       in a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="Wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Testing primitive le function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
layA = "resistor"
purA = "drawing"
layB = "membrane"
purB = "drawing"
shapes = leLayerAnd(cv list(layA purA) list(layB purB) list("text" "drawing"))

shapes = leLayerSize( cv list("membrane" "drawing") 1.5 list("membrane" "drawing") )
nth(0 shapes)->?
nth(0 shapes)->layerName
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

layerA = makeInstance( 'techLayer )
setLayer(layerA "resistor")
setPurpose(layerA "drawing")
layerB = makeInstance( 'techLayer )
setLayer(layerB "membrane")
setPurpose(layerB "drawing")
setRef(layerA cv)
getLayer(layerA)
getLayer(layerB)
shapes = andLayers(layerA layerB )
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Merging of a layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
lay = makeInstance( 'techLayer )
setRef(lay cv)
setName(lay "outline")
setPurpose(lay "drawing")
getShapesOnLayer(lay)
getCollection(lay->shapes)
length(getCollection(lay->shapes))
;should be two shapes
ml=mergeLayer(lay)
;should be just one output shape
length(ml)
nth(0 ml)~>?
nth(0 ml)~>layerName
nth(0 ml)~>points
;FIXME: should render and check

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Single Layer Wafer Contact Mask Layer Generation  
;      1.) Open a cellview containing instances that have the target layer
;      2.) Create a new cell view which will hold the mask layer
;      3.) Sequence through all the instances in the original cellview and 
;          "layer filter" only the target layer.
;      4.) Copy all shapes on the target layer into the new cellview on a 
;          given layer (could be the same layer)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;name="ln246_3p_wafer_flat"
name="ln246_3p_am_lna_v5b"
lib="ln0246"
;name="gaas_1_ALD_viaAlignment_C"
;lib="ASML"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
;;;;;
; Check top level cellview for shapes - should be nil
;;;;;
lay = makeInstance( 'techLayer )
setRef(lay cv)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
if(!null(getShapesOnLayer(lay)) then
  println("found top level via shapes")
);if
;;
; Take a look one level down
;;
insts = getInstances(cell)
length(insts)
;;
for(i 0 sub1(length(insts))
  inst = nth(i insts)
  printf("%d: %s " i inst~>name)
  printf("%d: %s \n" i inst~>cellName)
  setRef(lay inst)
  layName = "via"
  layPurp = "drawing"
  setName(lay layName)
  setPurpose(lay layPurp)
  if(!null(getShapesOnLayer(lay)) then
    println("found via shapes")
  );if
);for

;;
; sniff instance 12
;;
inst11 = nth(11 insts)
;;
;dbFlattenInst(inst11 32)
;;
inst11_name = inst11~>cellName
inst11_lib = inst11~>libName
inst11_view = inst11~>viewName


inst11_cv = dbOpenCellViewByType(inst11_lib inst11_name inst11_view = inst11~>viewName "maskLayout")
;;
; Check for layer one level down
;;
inst11_cv~>cellName
lay = makeInstance( 'techLayer )
setRef(lay inst11_cv)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
if(!null(getShapesOnLayer(lay)) then
  println("found one level down level via shapes")
);if
inst11_cv~>??
inst11_cell = makeInstance( 'cv )
setRef(inst11_cell inst11_cv)
setName(inst11_cell inst11_name)
setLib(inst11_cell inst11_lib)
setView(inst11_cell inst11_view)
inst11_insts = getInstances(inst11_cell)
inst11_inst0 = nth(0 inst11_insts)
inst11_inst0~>cellName
;;
inst11_inst0_name = inst11_inst0~>cellName
inst11_inst0_lib = inst11_inst0~>libName
inst11_inst0_view = inst11_inst0~>viewName
inst11_inst0_cv = dbOpenCellViewByType(inst11_inst0_lib inst11_inst0_name inst11_inst0_view = inst11~>viewName "maskLayout")
inst11_inst0_cv~>cellName
;;
; Check for layer one level down
;;
setRef(lay inst11_inst0_cv)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
if(!null(getShapesOnLayer(lay)) then
  println("found two level down level via shapes")
);if


setRef(lay cv)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
if(!null(getShapesOnLayer(lay)) then
  println("found top level via shapes")
);if

;;;
;;
;inst0 = nth(0 cv->instances)
inst0 = nth(0 insts)
inst0~>name
inst0~>cellName
inst0~>isFull
inst0~>?
inst0~>??
inst0~>bBox
grpMembers = inst0~>groupMembers
grpMem0 = nth(0 grpMembers)
grpMem0~>??
;;;
inst10 = nth(10 cv->instances)
inst10~>name
inst10~>cellName
inst10~>isFull
inst10~>?
inst10~>??
inst10~>bBox

cvi10 = dbOpenCellViewByType( lib inst10~>cellName view "maskLayout")
ci10 = makeInstance( 'cv )
setRef(ci10 cvi10)
setView(ci10 "layout")
setName(ci10 inst10~>cellName)
setLib(ci10 lib)
insts = getInstances(cell)
length(insts)
cvi10Inst0 = nth(0 cv->instances)
cvi10Inst0~>name
cvi10Inst0~>cellName
cvi10Inst0~>?
cvi10Inst0~>??
cvi10Inst0~>bBox

;;
name="ln246_3p_am_int23_front_v5"
lib="ln0246"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
lay = makeInstance( 'techLayer )
setRef(lay cv)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
shapes = lay->shapes->list->elems
nth(0 shapes)->ref~>layerName
nth(0 shapes)~>vertices
;nth(1 shapes)->ref~>layerName
;nth(1 shapes)->vertices

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Check for the existance of a particular 
;       layer in a cellview  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Capture the layer shapes in a cellview
name="asml_1_viaVernierCross_A"
lib="ASML"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
insts = getInstances(cell)
length(insts)
lay = makeInstance( 'techLayer )
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
inst = nth(0 insts)
inst~>cellName
inst~>??
dbFlattenInst(inst 32)
setRef(lay inst)
getShapesOnLayer(lay)
for(i 0 sub1(length(insts))
  inst = nth(i insts)
  dbFlattenInst(inst)
  setRef(lay inst)
  if(getShapesOnLayer(lay)
  printf("%s " inst~>name)
  printf("%s " inst~>cellName)
  printf("%L\n" inst~>isFull)
);for
;printLayers(lay)

; flatten the heirarcy of the cell to check for target layer
insts = getInstances(cell)
length(insts)
getShapesOnLayer(lay)
shapes = lay->shapes->list->elems
nth(0 shapes)->ref~>layerName
nth(0 shapes)~>vertices
;nth(1 shapes)->ref~>layerName
;nth(1 shapes)->vertices

tran = makeInstance( 'transform2 )
setVertices(tran nth(0 shapes)->vertices)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THIS IS IMPORTANT: It's the bridge between Cadence Shapes and the
; Object System ...
; Build up a structure - shapes to assemblies ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
geom = makeInstance( 'geometry )
num=length(shapes)
for(i 0 num-1
  temp = makeInstance( 'transform2 )
  setVertices(temp getItem(getShapes(lay) i)->vertices)
  addTransform(geom temp)
)

getItem(getPoints(getVertices(getItem(geom->transforms 0))) 0)->x
getItem(getPoints(getVertices(getItem(geom->transforms 0))) 0)->y

; Open a cv for write and rendor the target layer
name="inclusionRing"
lib="pd0164"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(geom cv)
render(geom)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Test the XoR of two layers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Capture the layer shapes in a cellview
;name="viaAlignment_mod"
name="viaAlignment_copy"
lib="ln0246"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "a")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;;
; Check for shapes on via drawing layer
;;
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
viaShapes = getShapesOnLayer(lay)
length(viaShapes)
;;
; Check for shapes on mesa drawing layer
;;
layName = "mesa"
setName(lay layName)
mesaShapes = getShapesOnLayer(lay)
length(mesaShapes)
;;
; Since the layer is set to mesa we need
; to XoR against the via layer
;;
xOrShapes = xOrLayers(lay list("via" "drawing"))
length(xOrShapes)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Using leAndNot, test the "diff" of one layer in two
;       cellviews.
;       This is checking what is the difference
;       or "diff" between the two layers
;       Output: 1.) The list of shape differences is 
;                   output from the xOrShapes method
;               2.) Create a new cellview with a "_(layer name)_diff"
;                   extension in order to visualize the differences
;                   in the two same named layers
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
; Open the reference cellview in read mode
;;
name="viaAlignment"
lib="ln0246"
view = "layout"
cv_ref = dbOpenCellViewByType( lib name view "maskLayout" "r")
lay_ref = makeInstance( 'techLayer )
setRef(lay_ref cv_ref)
;;
; Open the compare cellview in read mode
;;
name="viaAlignment_copy"
cv_cmp = dbOpenCellViewByType( lib name view "maskLayout" "r")
lay_cmp = makeInstance( 'techLayer )
setRef(lay_cmp cv_cmp)
;;
; Choose the layer and purpose to perform the diff on ...
;;
layName = "via"
layPurp = "drawing"
setName(lay_ref layName)
setPurpose(lay_ref layPurp)
;;
; Get reference shapes on target layer
;;
shapes_ref = getShapesOnLayer(lay_ref)
setName(lay_cmp layName)
setPurpose(lay_cmp layPurp)
;;
; Get compare shapes on target layer
;;
shapes_cmp = getShapesOnLayer(lay_cmp)
;;
; Create the new diff cellview
;;
name="viaAlignment_via_diff"
lib="ln0246"
view = "layout"
cv_diff = dbOpenCellViewByType( lib name view "maskLayout" "w")
;;
; render the reference shapes on the text drawing layer
; in the diff cellview
;;
shp = makeInstance( 'shape )
for(i 0 sub1(length(shapes_ref))
  shape_ref = nth(i shapes_ref)
  setVertices(shp shape_ref~>points)
  setLayer(shp "text")
  setPurpose(shp "drawing")
  setRef(shp cv_diff)
  renderShape(shp)
);for
;;
; render the compare shapes on the stretch drawing layer in the
; diff cellview
;;
for(i 0 sub1(length(shapes_cmp))
  shape_cmp = nth(i shapes_cmp)
  setVertices(shp shape_cmp~>points)
  setLayer(shp "stretch")
  setPurpose(shp "drawing")
  setRef(shp cv_diff)
  renderShape(shp)
);for
;;
; perform XoR between text and stretch layers in the cv_diff cellview and 
; set the result on the target via drawing layer
;;
lay_diff = makeInstance( 'techLayer )
setName(lay_diff "text")
setPurpose(lay_diff "drawing")
setRef(lay_diff cv_diff)
;;
;
; Choose One
;
; NOTE: "andNot" gives the diff result desired.
;
; WARNING: It appears that the "and" and the "andNot" work,
;          but "xOr" and "or" appear to give "and" results
;
; FIXME: Try using the db booleans instead of le booleans (i.e dbAndNot, dbXor, etc ...)
;
;
; 1.) xOrShapes = xOrLayers(lay_diff list("stretch" "drawing") list("via" "drawing"))
; 2.) orShapes = orLayers(lay_diff list("stretch" "drawing") list("via" "drawing"))
; 3.) andShapes = andLayers(lay_diff list("stretch" "drawing") list("via" "drawing"))
; 4.) andNotShapes = andNotLayers(lay_diff list("stretch" "drawing") list("via" "drawing"))
;
; FIXME: There needs to be db "Geomtric" booleans that are PCELL compatible!!
;
;;
dbSave(cv_diff)
dbClose(cv_diff)
dbClose(cv_ref)
dbClose(cv_cmp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;#########################################################
; Experimental Code
;#########################################################
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
layName = "thick"

setof(lp cv~>lpps lp~>layerName==layName)

car(setof(lp cv~>lpps lp~>layerName==layName))~>??

car(setof(lp cv~>lpps lp~>layerName==layName))~>shapes

setof(lp cv~>lpps lp~>layerName==layName)~>shapes