;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'memsCapBotCont )
cbc = makeInstance( 'memsCapBotCont )
classp( cbc 'memsCapBotCont)
classOf(cbc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cbc = makeInstance( 'memsCapBotCont )
setWidth(cbc 200.0)
setLength(cbc 300.0)
generate(cbc)
lib = "D91"
name = "capBpcTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cbc cv)
render(cbc)
dbSave(cv)
dbClose(cv)