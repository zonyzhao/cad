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

; THIS IS IMPORTANT: It's the bridge between Cadence Shapes and the
; Object System ...
; Build up a structure - shapes to assemblies ...
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
;       object
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
setVertices(shp vertices)
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
name="retBbox"
lib="pd0164"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(lay cv)
; FIXME: not working. not finding vertices in the transform member ...
renderShapesOnLayer(lay)
dbSave(cv)
dbClose(cv)

;#########################################################
; Experimental Code
;#########################################################
layName = "thick"

setof(lp cv~>lpps lp~>layerName==layName)

car(setof(lp cv~>lpps lp~>layerName==layName))~>??

car(setof(lp cv~>lpps lp~>layerName==layName))~>shapes

setof(lp cv~>lpps lp~>layerName==layName)~>shapes