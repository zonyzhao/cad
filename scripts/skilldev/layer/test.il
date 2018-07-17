:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'techLayer )
lay = makeInstance( 'techLayer )
classp( lay 'techLayer)
classOf(lay)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get all shapes on a given
;       layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="p80B_1_fet_mult_F"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "sd"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
lay->shapes->list->elems
nth(0 lay->shapes->list->elems)->ref~>layerName
nth(0 lay->shapes->list->elems)->vertices
dbClose(cv)
; Open a cv for write and rendor the target layer
name="p80B_1_fet_mult_F_copy"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(lay cv)
renderShapesOnLayer(lay)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: delete all shapes on a given
;       layer
; FIXME need to add all shapes to a
; newly opened cellview with write permissions
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="p80B_1_fet_mult_F_copy"
lib="test"
cvCopy = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "sd"
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
name="textBoundary"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(lay cv)
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