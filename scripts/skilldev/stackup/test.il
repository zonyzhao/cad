:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'stackup )
st = makeInstance( 'stackup )
classp( st 'stackup)
classOf(st)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get the cellview stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="Wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
st = makeInstance( 'stackup )
setRef(st cv)
getStackUp(st)
nth(0 st->stack->list->elems)->name
classOf(nth(0 st->stack->list->elems))
classOf(nth(0 nth(0 st->stack->list->elems)->shapes->list->elems))
nth(0 nth(0 st->stack->list->elems)->shapes->list->elems)->vertices
; Take the "snapshot" of the target cv
; and render it in a new cellview
name="Wafer_4_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(st cv)
;FIXME: renderStack not working ...
;       this method calls upon the layer's 
;       "renderShapesOnLayer" method which
;       is broken. Fix that method first ...
renderStack(st)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: test removing a layer from
;       the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="Wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
st = makeInstance( 'stackup )
setRef(st cv)
getStackUp(st)
deleteLayer(st "membrane")
printStackUp(st)
dbClose(cv)