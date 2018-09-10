;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'numbers )
num = makeInstance( 'numbers )
classp( num 'numbers)
classOf(num)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate the vertices of
;       a number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
num = makeInstance( 'numbers )
setVal(num "9")
generate(num)
getWidth(num)
getHeight(num)
numTran = makeInstance( 'transform2 )
setVertices(numTran generate(num))
numGeom = makeInstance( 'geometry )
addTransform(numGeom numTran)
lib = "reticle"
name = "num9_code"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(numGeom cv)
render(numGeom)
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Print the number on a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "memsChipFrameTest"
view = "layout"
num0 = makeInstance( 'numeric )
setVal(num0 "0")
generate(num0)
num0Tran = makeInstance( 'transform2 )
setVertices(num0Tran generate(num0))
translate(num0Tran list(964.9 275.2))
num0Geom = makeInstance( 'geometry )
addTransform(num0Geom num0Tran)
cv = dbOpenCellViewByType( lib name view "maskLayout" "a")
setRef(num0Geom cv)
render(num0Geom)
dbSave(cv)
dbClose(cv)
dbClose(cv)