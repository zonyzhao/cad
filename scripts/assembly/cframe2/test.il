;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cframe2 )
cf = makeInstance( 'cframe2 )
classp( cf 'cframe2)
classOf(cf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render the
;       outline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cf = makeInstance( 'cframe2 )
setWidth(cf 4000.0)
setHeight(cf 4000.0)
setEdgeWidth(cf 600.0)
setRadius(cf 200.0)
setPlate(cf 't)
setLayer(cf "GRID")
setPurpose(cf "drawing")
generate(cf)
lib = "test"
name = "cframe2Test"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(cf cv)
render(cf)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Experimental code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Take a peek at the scribe line markers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "reticle"
name = "SPM_Y_AH32"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
cv~>?
cv~>shapes
length(cv~>shapes)
nth(0 cv~>shapes)~>?
nth(0 cv~>shapes)~>layerName
i=0
foreach( shp cv~>shapes
  printf("%d Layer Name: %L, Purpose: %L\n" i shp~>layerName shp~>purpose)
  i++
);foreach