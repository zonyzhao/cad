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
name="p80B_1_fet_mult_F"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
st = makeInstance( 'stackup )
setRef(st cv)
getStackUp(st)
nth(0 st->stack->list->elems)->name
classOf(nth(0 st->stack->list->elems))
classOf(nth(0 nth(0 st->stack->list->elems)->shapes->list->elems))
nth(0 nth(0 st->stack->list->elems)->shapes->list->elems)->vertices
; Take the "snapshot" of the target cv
; and render it in a new cellview
name="p80B_1_fet_mult_snapshot"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(st cv)
renderStack(st)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: test removing a layer from
;       the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="p80B_1_fet_mult_F"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
st = makeInstance( 'stackup )
setRef(st cv)
getStackUp(st)
deleteLayer(st "text")
printStackUp(st)
dbClose(cv)