:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'snapshot )
ss = makeInstance( 'snapshot )
classp( ss 'snapshot)
classOf(ss)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Get the cellview stackup - single layer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="ASML_PM_LO"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
nth(0 ss->layers->list->elems)->name
classOf(nth(0 ss->layers->list->elems))
classOf(nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems))
nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems)->vertices
dbClose(cv)
; Render snapshot it in a new cellview
name="ASML_PM_LO_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "resistor")
getName(nth(0 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Get the cellview stackup - multilayer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_X_AH32"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
nth(0 ss->layers->list->elems)->name
classOf(nth(0 ss->layers->list->elems))
classOf(nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems))
nth(0 nth(0 ss->layers->list->elems)->shapes->list->elems)->vertices
dbClose(cv)
; Render snapshot it in a new cellview
name="SPM_X_AH32_snapshot"
lib="reticle"
view = "layout" 
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(ss cv)
length(ss->layers->list->elems)
getName(nth(0 ss->layers->list->elems))
setName(nth(0 ss->layers->list->elems) "numbers")
getName(nth(0 ss->layers->list->elems))
getName(nth(1 ss->layers->list->elems))
setName(nth(1 ss->layers->list->elems) "resistor")
getName(nth(1 ss->layers->list->elems))
renderStack(ss)
dbSave(cv)
dbClose(cv)

:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: test removing a layer from
;       the stackup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH53"
lib="numbers"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
ss = makeInstance( 'snapshot )
setRef(ss cv)
getStackUp(ss)
deleteLayer(ss "nitEtch")
printStackUp(ss)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="SPM_Y_AH53_snapshot"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
renderStack(ss)
dbSave(cv)
dbClose(cv)
