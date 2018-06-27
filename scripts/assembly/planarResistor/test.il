1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'planarResistor )
pr = makeInstance( 'planarResistor )
classp( pr 'planarResistor)
classOf(pr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pr = makeInstance( 'planarResistor )
setWidth(gs 65.0)
setLength(gs 0.25)
lib = "cadTest"
name = "planarResistor"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(pr cv)
render(pr)
setRef(pr->rtrans cv)
render(pr->rtrans)
dbSave(cv)
dbClose(cv)