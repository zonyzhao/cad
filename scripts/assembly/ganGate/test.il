;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Dependency Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'gateStem )
gs = makeInstance( 'gateStem )
classp( gs 'gateStem)
classOf(gs)
className(findClass( 'gateStem ))
superclassesOf(classOf(gs))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'gatePad )
gp = makeInstance( 'gatePad )
classp( gp 'gatePad)
classOf(gp)
className(findClass( 'gatePad ))
superclassesOf(classOf(gp))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ganGate )
gt = makeInstance( 'ganGate )
classp( gt 'ganGate)
classOf(gt)
className(findClass( 'ganGate ))
superclassesOf(classOf(gt))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Preview the gate layout
;       prior to commiting to PCELL
;       supermaster
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gt = makeInstance( 'ganGate )
setWidth(gt 100.0)
setLength(gt 0.25)
lib = "pd0164"
name = "ganGatePreview"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(gt cv)
generate(gt)
; FIXME: Rendering of the geom bbox is broken ...
;setRef(gt->rtrans->rtran cv)
;render(gt->rtrans->rtran)
;cv~>bBox
;gt->coreBBox
dbSave(cv)
dbClose(cv)

