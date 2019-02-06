;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'shape )
shp = makeInstance( 'shape )
classp( shp 'shape)
classOf(shp)
superclassesOf(classOf(shp))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get all shapes on a given layer
;       and render those shapes in a new
;       cellview - IMPORTANT!!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Capture the layer shapes in a cellview
name="gaas_1_ASML_viaAlignment_A"
lib="ASML"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
;; Use a techLayer object to get shapes
lay = makeInstance( 'techLayer )
setRef(lay cv)
;printLayers(lay)
layName = "via"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
; Grab shapes references on target layer 
shapes = lay->shapes->list->elems
num=length(shapes)

shape = nth(0 shapes)
shape~>??
getVertices(shape)

; Open a cv for write and rendor the target layer
name="viaAlignment"
lib="ln0246"
view = "layout"
cv_via = dbOpenCellViewByType( lib name view "maskLayout" "w")

for(i 0 num-1
  shp = nth(i shapes)
  setLayer(shp "via")
  setPurpose(shp "drawing")
  setRef(shp cv_via)
  renderShape(shp)
)

dbSave(cv_via)
dbClose(cv_via)
dbClose(cv)
