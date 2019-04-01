;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'gateStem )
gs = makeInstance( 'gateStem )
classp( gs 'gateStem)
classOf(gs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gs = makeInstance( 'gateStem )
setWidth(gs 65.0)
setLength(gs 0.25)
setWidthTaper(gs 2.5)
setLayer(gs "text")
generate(gs)
;translate(gs list(8.75 0.0))
lib = "test"
name = "gateStemTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(gs cv)
render(gs)
setRef(gs->rtrans cv)
render(gs->rtrans)
dbSave(cv)
dbClose(cv)