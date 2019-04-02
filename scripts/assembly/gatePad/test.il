;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'gatePad )
gp = makeInstance( 'gatePad )
classp( gp 'gatePad)
classOf(gp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit `
;       gate pad
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gp = makeInstance( 'gatePad )
setWidthInner(gp 100.0)
setHeightInner(gp 25.0)
setWidthOutter(gp 110.0)
setHeightOutter(gp 35.0)
setInnerLayer(gp "text")
setInnerPurpose(gp "drawing")
setOutterLayer(gp "text")
setOutterPurpose(gp "drawing")
generate(gp)
;translate(gp list(8.75 0.0))
lib = "test"
name = "gatePadTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(gp cv)
;Render gate pad
render(gp)
;Render gate pad bbox
;FIXME: bbox rtran disabled
;setRef(gp->rtrans cv)
;render(gp->rtrans)
dbSave(cv)
dbClose(cv)