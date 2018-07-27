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
setWidth(cf 10000.0)
setHeight(cf 10000.0)
setEdgeWidth(cf 100.0)
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