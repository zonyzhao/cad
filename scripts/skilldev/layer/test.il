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
name="Wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "resistor"
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
setName(lay "resistor")
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
;name="ln246_3p_am_lna_v5b"
name="ln246_3p_am_int23_front_v5"
lib="ln0246"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
insts = getInstances(cell)
length(insts)
;;
for(i 0 sub1(length(insts))
  inst = nth(i cv->instances)
  printf("%d: %s " i inst~>name)
  printf("%d: %s \n" i inst~>cellName)
  lay = makeInstance( 'techLayer )
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
inst0 = nth(0 cv->instances)
inst0~>name
inst0~>cellName
inst0~>isFull
inst0~>?
inst0~>??
inst0~>bBox
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

;#########################################################
; Experimental Code
;#########################################################
layName = "thick"

setof(lp cv~>lpps lp~>layerName==layName)

car(setof(lp cv~>lpps lp~>layerName==layName))~>??

car(setof(lp cv~>lpps lp~>layerName==layName))~>shapes

setof(lp cv~>lpps lp~>layerName==layName)~>shapes