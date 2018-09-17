;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'symbol )
sym = makeInstance( 'symbol )
classp( sym 'symbol)
classOf(sym)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate the vertices of
;       a number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sym = makeInstance( 'symbol )
setVal(sym "<")
generate(sym)
symTran = makeInstance( 'transform2 )
setVertices(symTran generate(sym))
symGeom = makeInstance( 'geometry )
addTransform(symGeom symTran)
lib = "pd0164"
name = "sym"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(symGeom cv)
render(symGeom)
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Print the number on a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sym = makeInstance( 'symbol )
setVal(sym ">")
generate(sym)
symTran = makeInstance( 'transform2 )
setVertices(symTran generate(sym))
symGeom = makeInstance( 'geometry )
addTransform(symGeom symTran)
lib = "pd0164"
name = "sym"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(symGeom cv)
render(symGeom)
dbSave(cv)
dbClose(cv)