;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'via )
v = makeInstance( 'via )
classp( v 'via)
classOf(v)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate and render unit 
;       gate stem
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v = makeInstance( 'via )
setWidth(v 50.0)
setLength(v 50.0)
setMinWidth(v 10.0)
setMinLength(v 10.0)
setTopPlateEnc(v 25.0)
setPostLayer(v "via")
setPostPurpose(v "drawing")
setTopPlateLayer(v "resistor")
setTopPlatePurpose(v "drawing")
generate(v)
lib = "pd0164"
name = "viaTest"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(v cv)
render(v)
dbSave(cv)
dbClose(cv)