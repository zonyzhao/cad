;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'numeric )
num = makeInstance( 'numeric )
classp( num 'numeric)
classOf(num)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate the vertices of
;       a number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
num0 = makeInstance( 'numeric )
setVal(num0 "0")
generate(num0)
num0Tran = makeInstance( 'transform2 )
setVertices(num0Tran generate(num0))
num0Geom = makeInstance( 'geometry )
addTransform(num0Geom num0Tran)
lib = "reticle"
name = "num0"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(num0Geom cv)
render(num0Geom)
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Print the number on a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p_shifturq"
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3 Print number from a string
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "numchar"
view = "layout"
num = makeInstance( 'numeric )
str = "000"
ch = substring(str 2 1)
setVal(num ch)
generate(num)
numTran = makeInstance( 'transform2 )
setVertices(numTran generate(num))
translate(numTran list(964.9 275.2))
numGeom = makeInstance( 'geometry )
addTransform(numGeom num0Tran)
cv = dbOpenCellViewByType( lib name view "maskLayout" "a")
setRef(numGeom cv)
render(numGeom)
dbSave(cv)
dbClose(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3 Print a number scaled by 0.5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "numchar"
view = "layout"
num = makeInstance( 'numeric )
str = "020"
ch = substring(str 2 1)
setVal(num ch)
setScale(num 0.5)
generate(num)
numTran = makeInstance( 'transform2 )
setVertices(numTran generate(num))
translate(numTran list(0.0 0.0))
numGeom = makeInstance( 'geometry )
addTransform(numGeom numTran)
cv = dbOpenCellViewByType( lib name view "maskLayout" "a")
setRef(numGeom cv)
render(numGeom)
dbSave(cv)
dbClose(cv)
dbClose(cv)