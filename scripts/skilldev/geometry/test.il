;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'geometry )
geo = makeInstance( 'geometry )
classp( geo 'geometry)
classOf(geo)
getUpperRight(geo)
getLowerLeft(geo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create the TriRect using
;       two transforms and generate
;       the tranforms rectTran 
;       union.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
height = 10.0
width = 20.0
body = makeInstance( 'rectangle )			
setHeight(body height)
setWidth(body width)
generate(body)
getCentroid(body)
getUpperRight(body->rtran)
getLowerLeft(body->rtran)
getCentroid(body->rtran)
head = makeInstance( 'triangle )
setBase(head height)
setHeight(head height)
generate(head)
getCentroid(head)
getUpperRight(head->rtran)
getLowerLeft(head->rtran)
getCentroid(head->rtran)
bodyTran = makeInstance( 'transform2 )
setVertices(bodyTran getVertices(body))
setCentroid(bodyTran getCentroid(body))
cloneRectTran(bodyTran)
headTran = makeInstance( 'transform2 )
setVertices(headTran getVertices(head))
setCentroid(headTran getCentroid(head))
cloneRectTran(headTran)
rotate(headTran 270.0)
translate(headTran list((width+height)/2.0 0.0))
getCentroid(headTran)
getCentroid(headTran->rtran) 
getUpperRight(headTran->rtran)
getLowerLeft(headTran->rtran)
geom = makeInstance( 'geometry )
addTransform(geom bodyTran)
addTransform(geom headTran)
rectTranUnion(geom)
getUpperRight(geom->rtran)
getLowerLeft(geom->rtran)
getCentroid(geom->rtran)

name="rtranTriRectTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(geom cv)
render(geom)
setRef(geom->rtran cv)
render(geom->rtran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create the TriRect geometry
;       and rotate the geometry
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
height = 10.0
width = 20.0
body = makeInstance( 'rectangle )			
setHeight(body height)
setWidth(body width)
generate(body)
getCentroid(body)
getUpperRight(body->rtran)
getLowerLeft(body->rtran)
getCentroid(body->rtran)
head = makeInstance( 'triangle )
setBase(head height)
setHeight(head height)
generate(head)
getCentroid(head)
getUpperRight(head->rtran)
getLowerLeft(head->rtran)
getCentroid(head->rtran)
bodyTran = makeInstance( 'transform2 )
setVertices(bodyTran getVertices(body))
setCentroid(bodyTran getCentroid(body))
cloneRectTran(bodyTran)
headTran = makeInstance( 'transform2 )
setVertices(headTran getVertices(head))
setCentroid(headTran getCentroid(head))
cloneRectTran(headTran)
rotate(headTran 270.0)
translate(headTran list((width+height)/2.0 0.0))
getCentroid(headTran)
getCentroid(headTran->rtran) 
getUpperRight(headTran->rtran)
getLowerLeft(headTran->rtran)
geom = makeInstance( 'geometry )
addTransform(geom bodyTran)
addTransform(geom headTran)
rectTranUnion(geom)
getUpperRight(geom->rtran)
getLowerLeft(geom->rtran)
getCentroid(geom->rtran)
getCentroid(geom)
isCentered(geom)
center(geom)
rotate(geom 90.0)

name="triRectRotTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(geom cv)
render(geom)
setRef(geom->rtran cv)
render(geom->rtran)
dbSave(cv)
dbClose(cv)