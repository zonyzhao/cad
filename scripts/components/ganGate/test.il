;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object dependency 
;       existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ganGate )
gg = makeInstance( 'ganGate )
classp( gg 'ganGate)
classOf(gg)
className(findClass( 'ganGate ))
superclassesOf(classOf(gg))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Preview the gate layout
;       prior to commiting to PCELL
;       supermaster
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gg = makeInstance( 'ganGate )
setWidth(gg 100.0)
setLength(gg 0.25)
lib = "pd0164"
name = "ganGatePreview"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(gg cv)
generate(gg)
render(gg)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(gg->rtrans->rtran cv)
;render(gg->rtrans->rtran)
;cv~>bBox
;gg->coreBBox
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Preview the gate component layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gg = makeInstance( 'ganGate )
setWidth(gg 100.0)
setLength(gg 0.25)
lib = "pd0164"
name = "ganGatePreview"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(gg cv)
generate(gg)
render(gg)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(gg->rtrans->rtran cv)
;render(gg->rtrans->rtran)
;cv~>bBox
;gg->coreBBox
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Preview the shifted gate component 
;       layout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gg = makeInstance( 'ganGate )
setWidth(gg 100.0)
setLength(gg 0.25)
lib = "pd0164"
name = "ganGatePreview"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "a")
setRef(gg cv)
generate(gg)
translate(gg list(0.0 100.0))
render(gg)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(gg->rtrans->rtran cv)
;render(gg->rtrans->rtran)
;cv~>bBox
;gg->coreBBox
dbSave(cv)
dbClose(cv)
