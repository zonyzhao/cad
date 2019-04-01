;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'planarResistor )
pr = makeInstance( 'planarResistor )
classp( pr 'planarResistor)
classOf(pr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render the planar
;       resistor preview cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pr = makeInstance( 'planarResistor )
setWidth(pr 1.0)
setLength(pr 10.0)
setMinWidth(pr 1.0)
setMinLength(pr 1.0)
setTermLen(pr 1.0)
setTermEnc(pr 0.5)
setBodyLayer(pr "resistor")
setBodyPurpose(pr "drawing")
setContLayer(pr "electrode")
setContPurpose(pr "drawing")
generate(pr)
lib = "test"
name = "planarResTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(pr cv)
render(pr)
dbSave(cv)
dbClose(cv)