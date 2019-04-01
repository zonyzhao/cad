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
; UT-2: Take the union of the three rtran object in
;       the collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rtsUnion(rts)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Translate the union of the
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Build up a two polygons to a
;       pair of transforms to a geometry
;       group form their union and 
;       then render the geometry and 
;       the rectTran (bbox) in a cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
body = makeInstance( 'rectangle )
setWidth(body 50.0)
setHeight(body 10.0)
generate(body)
;
cont = makeInstance( 'rectangle )
setWidth(cont 10.0)
setHeight(cont 10.0)
generate(cont)
;
bTran = makeInstance( 'transform2 )
setVertices(bTran getVertices(body))
setCentroid(bTran getCentroid(body))
cloneRectTran(bTran)
setLayer(bTran "text")
setPurpose(bTran "drawing")
;
pConTran = makeInstance( 'transform2 )
setVertices(pConTran getVertices(cont))
setCentroid(pConTran getCentroid(cont))
cloneRectTran(pConTran)
setLayer(pConTran "text")
setPurpose(pConTran "drawing")
;
translate(pConTran list(25.0 0))
;
geomGroup = makeInstance('geometry)
addTransform(geomGroup bTran)
addTransform(geomGroup pConTran)
rectTranUnion(geomGroup)
;
ass = makeInstance( 'assembly )
addGeometry(ass geomGroup)
rtsAdd(ass->rtrans getRectTran(geomGroup))
rtsUnion(ass->rtrans)
; debug ...
rt = nth(0 getCollection(ass->rtrans->rtrans))
rtran2bbox(rt)
union(ass->rtrans rt)