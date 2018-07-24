;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'rectTran )
rt = makeInstance( 'rectTran )
classp( rt 'rectTran)
classOf(rt)
getUr(rt)
getLl(rt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Genterate a rectTran for
;       a square
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 100x100 Square
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(-45.0 -45.0)
v1 = list(55.0 -45.0)
v2 = list(55.0 55.0)
v3 = list(-45.0 55.0)

ll = v0
ur = v2

rt = makeInstance( 'rectTran )
setUr(rt ur)
setLl(rt ll)
;;;;;;;;;;;;;;;;;;;;
; Ans: Centroid  = (5.0,5.0)
;;;;;;;;;;;;;;;;;;;;
calculateCentroid(rt)
; Visual Test
name="rtranTest"
lib = "test"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(rt cv)
rtran2bbox(rt)
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
setUr(rt ur)
setLl(rt ll)
calculateCentroid(rt)

name="rtranRectTest"
lib = "test"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(rt cv)
rtran2bbox(rt)
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
setUr(rt ur)
setLl(rt ll)
calculateCentroid(rt)
translate(rt list(25.0 0.0))
getCentroid(rt)
getUr(rt)
getLl(rt)

name="rtranRectTranslateTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Genterate a rectTran for
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
setUr(rt ur)
setLl(rt ll)
calculateCentroid(rt)
rotate(rt 90.0)
getCentroid(rt)
getUr(rt)
getLl(rt)

name="rtranRectRotateTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rt cv)
render(rt)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Get the bbox from the rectangle
;       cv generated in UT-1, and 
;       convert the bbox to a rectran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="rtranRectTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
rt = makeInstance( 'rectTran )
setRef(rt cv)
getbb(rt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Create a bbox from a rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;