;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'triangle )
tri = makeInstance( 'triangle )
classp( tri 'triangle)
classOf(tri)
tri->base
tri->height
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate Triangle polygon
;       and render its shape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; create the triangle polygon
tri = makeInstance( 'triangle )
setBase(tri 0.8)
setHeight(tri 2.5)
genTri(tri)
rotate(tri 45)
; Add polygon to a geometry container object
triGeom = makeInstance( 'geometry )
addPolygon(triGeom tri)
shp = makeInstance( 'shape )
addGeometry(shp triGeom)
setLayer(shp "sd")
setPurpose(shp "drawing")
lib = "test"
name = "triangleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(shp cv)
render(shp)
dbSave(cv)
dbClose(cv)