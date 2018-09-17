:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test dependency existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'alpha )
a = makeInstance( 'alpha )
classp( a 'alpha)
classOf(a)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: test dependency existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'numeric )
n = makeInstance( 'numeric )
classp( n 'numeric )
classOf(n)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: test dependency existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'punctuation )
p = makeInstance( 'punctuation )
classp( p 'punctuation )
classOf(p)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'alphaNumeric )
an = makeInstance( 'alphaNumeric )
classp( an 'alphaNumeric)
classOf(an)
:;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Print out a alphanum
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
an = makeInstance( 'alphaNumeric )
setVal(an "8")
generate(an)
anTran = makeInstance( 'transform2 )
setVertices(anTran generate(an))
anGeom = makeInstance( 'geometry )
addTransform(anGeom anTran)
lib = "pd0164"
name = "alphaNumeric"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "w")
setRef(anGeom cv)
render(anGeom)
dbSave(cv)
dbClose(cv)