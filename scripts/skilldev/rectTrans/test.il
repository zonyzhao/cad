;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'rectTrans )
rts = makeInstance( 'rectTrans )
classp( rts 'rectTrans)
classOf(rts)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Add three rectran objects to
;       the rtran collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 100x100 Square
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="rtranTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
rt0 = makeInstance( 'rectTran )
setRef(rt0 cv)
getbb(rt0)
bbox2urll(rt0)
getUr(rt0)
getLl(rt0)
dbClose(cv)

name="rtranRectTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
rt1 = makeInstance( 'rectTran )
setRef(rt1 cv)
getbb(rt1)
bbox2urll(rt1)
getUr(rt1)
getLl(rt1)
dbClose(cv)

name="rtranRectRotateTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
rt2 = makeInstance( 'rectTran )
setRef(rt2 cv)
getbb(rt2)
bbox2urll(rt2)
getUr(rt2)
getLl(rt2)
dbClose(cv)

rts = makeInstance( 'rectTrans )
rtsAdd(rts rt0)
rtsAdd(rts rt1)
rtsAdd(rts rt2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Take the union of the three rtran object in
;       the collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rtsUnion(rts)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Translate the union of the
;       three rtran objects
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
translate(rts list(25.0 25.0))
getCentroid(rts)
getUr(rts)
getLl(rts)
getBbox(rts)

name="rtranSTestTranslate"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(rts cv)
render(rts)
dbSave(cv)
dbClose(cv)
