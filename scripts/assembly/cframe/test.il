;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cframe )
cf = makeInstance( 'cframe )
classp( cf 'cframe)
classOf(cf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render the
;       outline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cf = makeInstance( 'cframe )
setWidth(cf 4000.0)
setHeight(cf 4000.0)
setEdgeWidth(cf 95.0)
setLayer(cf "GRID")
setPurpose(cf "drawing")
generate(cf)
lib = "reticle"
name = "cframeTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cf cv)
render(cf)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Take a peek at the scribe line markers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "reticle"
name = "SPM_X_AH32"
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