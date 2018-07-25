;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'memsCapTopCont )
ctc = makeInstance( 'memsCapTopCont )
classp( ctc 'memsCapTopCont)
classOf(ctc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ctc = makeInstance( 'memsCapTopCont )
setWidth(ctc 200.0)
setLength(ctc 300.0)
generate(ctc)
lib = "D91"
name = "capTpcTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(ctc cv)
render(ctc)
dbSave(cv)
dbClose(cv)