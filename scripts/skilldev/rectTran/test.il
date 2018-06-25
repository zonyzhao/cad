;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'rectTran )
rt = makeInstance( 'rectTran )
classp( rt 'rectTran)
classOf(rt)
getUpperRight(rt)
getLowerLeft(rt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Genterate a rectTran for
;       a square
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 100x100 Square
v0 = list(-45.0 -45.0)
v1 = list(55.0 -45.0)
v2 = list(55.0 55.0)
v3 = list(-45.0 55.0)

ll = v0
ur = v2

rt = makeInstance( 'rectTran )
setUpperRight(rt ur)
setLowerLeft(rt ll)
calculateCentroid(rt)

name="rtranSquareTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Genterate a rectTran for
;       a rectangle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(-100.0 -50.0)
v1 = list(100.0 -50.0)
v2 = list(100.0 50.0)
v3 = list(-100.0 50.0)

ll = v0
ur = v2

rt = makeInstance( 'rectTran )
setUpperRight(rt ur)
setLowerLeft(rt ll)
calculateCentroid(rt)

name="rtranRectTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Genterate a rectTran for
;       a rectangle and translate
;       it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(-100.0 -50.0)
v1 = list(100.0 -50.0)
v2 = list(100.0 50.0)
v3 = list(-100.0 50.0)

ll = v0
ur = v2

rt = makeInstance( 'rectTran )
setUpperRight(rt ur)
setLowerLeft(rt ll)
calculateCentroid(rt)
translate(rt list(25.0 0.0))
getCentroid(rt)
getUpperRight(rt)
getLowerLeft(rt)

name="rtranRectTranslateTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Genterate a rectTran for
;       a rectangle and rotate it
;       it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(-100.0 -50.0)
v1 = list(100.0 -50.0)
v2 = list(100.0 50.0)
v3 = list(-100.0 50.0)

ll = v0
ur = v2

rt = makeInstance( 'rectTran )
setUpperRight(rt ur)
setLowerLeft(rt ll)
calculateCentroid(rt)
rotate(rt 90.0)
getCentroid(rt)
getUpperRight(rt)
getLowerLeft(rt)

name="rtranRectTranslateTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

