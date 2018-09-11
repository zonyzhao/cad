;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'alpha )
al = makeInstance( 'alpha )
classp( al 'alpha)
classOf(al)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate the vertices of
;       a number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ala = makeInstance( 'alpha )
setVal(ala "a")
generate(ala)
alaTran = makeInstance( 'transform2 )
setVertices(alaTran generate(ala))
alaGeom = makeInstance( 'geometry )
addTransform(alaGeom alaTran)
lib = "pd0164"
name = "ala"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(alaGeom cv)
render(alaGeom)
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