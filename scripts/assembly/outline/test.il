;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'outline )
ol = makeInstance( 'outline )
classp( ol 'outline)
classOf(ol)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render the
;       outline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ol = makeInstance( 'outline )
setWidth(ol 1000.0)
setLength(ol 1000.0)
setEdgeWidth(ol 100.0)
setOverlap(ol 4.0)
setLayer(ol "GRID")
setPurpose(ol "drawing")
generate(ol)
lib = "reticle"
name = "outlineTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(ol cv)
render(ol)
dbSave(cv)
dbClose(cv)