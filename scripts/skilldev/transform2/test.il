;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'transform2 )
trans = makeInstance( 'transform2 )
classp( trans 'transform2)
classOf(trans)
trans->vertices
getVertices(trans)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Test Create A reference
;       half circle 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran)
setCentroid(tran getCentroid(circle))
name="quartCircleRefTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Test Rotation of quarter 
;       circle by 90 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran->rtran)
getCentroid(tran->polygon->rtran)
getCentroid(circle)
setCentroid(tran getCentroid(circle))
rotate(tran 90.0)
;translate(tran list(75.0 0.0))
name="quartCircleRefTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "a")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Test Rotation of quarter 
;       circle by 180 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran)
setCentroid(tran getCentroid(circle))
rotate(tran 180.0)
translate(tran list(125.0 0.0))
name="quarterCircleRotTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "a")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Test Rotation of quarter
;       circle by 270 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran)
setCentroid(tran getCentroid(circle))
rotate(tran 270.0)
translate(tran list(175.0 0.0))
name="quartCircleRefTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "a")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Test Translatation 
;       of a quarter circle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran)
setCentroid(tran getCentroid(circle))
translate(tran list(25 25))
name="quartCircleTrnTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Test rotation 
;       of a half circle by 180
;       degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateHalfCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
getCentroid(tran)
setCentroid(tran getCentroid(circle))
;rotate(tran 90.0)
;rotate(tran 180.0)
name="halfCircleRotTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Test rotation and translation
;       of a triangle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
width = 5.0
length = 6.0
tri = makeInstance( 'triangle )
setBase(tri width)
setHeight(tri width)
genTri(tri)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(tri))
getCentroid(tran)
setCentroid(tran getCentroid(tri))
getCentroid(tran)
rotate(tran -90)
getCentroid(tran)
translate(tran list(width/2.0 0.0))
getCentroid(tran)
name="tranTriTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: building a trirect 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
height = 0.8
width = 2.5
body = makeInstance( 'rectangle )	   	   
setHeight(body height)
setWidth(body width)
generate(body)
head = makeInstance( 'triangle )
setBase(head height)
setHeight(head height)
generate(head)
bodyTran = makeInstance( 'transform2 )
setVertices(bodyTran getVertices(body))
headTran = makeInstance( 'transform2 )
setVertices(headTran getVertices(head))
setCentroid(headTran getCentroid(head))
rotate(headTran 270.0)
translate(headTran list((width+height)/2.0 0.0)) 
name="tranTrirectTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(bodyTran cv)
render(bodyTran)
setRef(headTran cv)
render(headTran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: building a Capsule 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
height = 4.0
width = 13.5
body = makeInstance( 'rectangle )
setHieght(body height)
setWidth(body width)
generate(body)	   
capR = makeInstance( 'circle )
setGrid(capR 0.025)
setRadius(capR height/2.0)
generateHalfCircle(capR)
capL = makeInstance( 'circle )
setGrid(capL 0.025)
setRadius(capL height/2.0)
generateHalfCircle(capL)
bodyTran = makeInstance( 'transform2 )
setVertices(bodyTran getVertices(body))
setCentroid(bodyTran getCentroid(body))
capRTran = makeInstance( 'transform2 )
setVertices(capRTran getVertices(capR))
setCentroid(capRTran getCentroid(capR))
capLTran = makeInstance( 'transform2 )
setVertices(capLTran getVertices(capL))
setCentroid(capLTran getCentroid(capL))
rotate(capLTran 180.0)
translate(capRTran list(width/2.0 0.0))
translate(capLTran list(width*(-1.0/2.0) 0.0))
name="tranCapsuleTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(bodyTran cv)
render(bodyTran)
setRef(capLTran cv)
render(capLTran)
setRef(capRTran cv)
render(capRTran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Test Rotation of half 
;       circle by 270 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 100x100 Square
v0 = list(0.0 0.0)
v1 = list(0.0 100.0)
v2 = list(100.0 100.0)
v3 = list(100.0 0.0)
v4 = list(0.0 0.0)
vertices = list(v0 v1 v2 v3 v4)
tran = makeInstance( 'transform2 )
setVertices(tran vertices)
getCentroid(tran)
translate(tran list(5 5))
getCentroid(tran)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9: Test Translate/Centroid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 300x400x500 Triangle
v0 = list(0.0 0.0)
v1 = list(0.0 300.0)
v2 = list(400 0.0)
vertices = list(v0 v1 v2)
tran = makeInstance( 'transform2 )
setVertices(tran vertices)
getCentroid(tran)
translate(tran list(10.0 10.0))
getCentroid(tran)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Test Translate/Centroid
;       of a hexagon
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hexagon
v0 = list(0.0 0.0)
v1 = list(-100 100)
v2 = list(-100 200)
v2 = list(0 300)
v3 = list(100 300)
v4 = list(100 200)
v5 = list(100 0)
vertices = list(v0 v1 v2 v3 v4 v5)
poly = makeInstance( 'polygon2 )
setVertices(poly vertices)
centroid(poly)
area(poly)
translate(poly list(5 5))
centroid(poly)
area(poly)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-11: Testing rotation then
;       translation on quarter circle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 25
generateQuarterCircle(circle)
tran = makeInstance( 'transform2 )
setVertices(tran getVertices(circle))
rotate(tran 90.0)
;translate(tran list(50.0 50.0))
name="halfCircleTrnRotTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-12: Complex Polygon - Capsule
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vertices=list(
		list(20.971 7.737) 
    		list(20.858 7.024) 
    		list(20.501 6.324) 
    		list(19.947 5.77) 
    		list(19.247 5.413)
    		list(18.534 5.3) 
    		list(4.808 5.3) 
    		list(4.095 5.413) 
    		list(3.395 5.77) 
    		list(2.841 6.324)
   		list(2.484 7.024) 
    		list(2.371 7.737) 
    		list(2.371 8.463) 
    		list(2.484 9.176) 
    		list(2.841 9.876)
    		list(3.395 10.43) 
    		list(4.095 10.787) 
    		list(4.808 10.9) 
    		list(18.534 10.9) 
    		list(19.247 10.787)
    		list(19.947 10.43) 
    		list(20.501 9.876) 
    		list(20.858 9.176) 
    		list(20.971 8.463)
)
poly = makeInstance( 'polygon2 )
setVertices(poly vertices)
centroid(poly)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-13: Testing rotation on 
;       half circle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 5
circle->centroid->x
circle->centroid->y
generateHalfCircle(circle)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Rotate 90 degrees
rotate(circle 90.0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shp = makeInstance( 'shape )
setVertices(shp getVertices(circle))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="rotation"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setCvRef(shp cv)
setLayer(shp "sd")
setPurpose(shp "drawing")
render(shp)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-14: Testing translate, rotation
;       and scaling on a trirect 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-15: Testing translate, rotation
;       and scaling on a capsule 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-16: Render a transform
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 300x400x500 Triangle
v0 = list(0.0 0.0)
v1 = list(0.0 300.0)
v2 = list(400 0.0)
vertices = list(v0 v1 v2)
transform = makeInstance( 'transform )
setVertices(transform vertices)
centroid(tran)
translate(tran list(5 5))
centroid(tran)
lib="test"
name="triTransTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(tran cv)
render(tran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-17: Test if point is inside
;       a polygon - rectangle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v0 = list(0.0 0.0)
v1 = list(0.0 100.0)
v2 = list(100.0 100.0)
v3 = list(100.0 0.0)
v4 = list(0.0 0.0)
vertices = list(v0 v1 v2 v3 v4)
poly = makeInstance( 'polygon2 )
setVertices(poly vertices)
area(poly)
centroid(poly)
;translate(poly list(-50.0 -50.0))
;area(poly)
;centroid(poly)
;Positives
point = list(20.0 20.0)
point = list(0.0 0.0)
point = list(99.0 99.0)
isPointInside(poly point)
;Negatives
point = list(60.0 -60.0)
point = list(55.0 50.0)
;;;;;;;;;;;;;;;;;;;;;;;;;;
; Special Cases
; on a vertex
point = list(100.0 100.0)
; On a vertex
point = list(0.0 0.0)
; On an edge
point = list(50.0 0.0)
; On an edge
point = list(0.0 50.0)
; "Creeping up" on a vertex
; checking the boundary conditions
; decimal.binary
point = list(99.0 99.0)
point = list(99.5 99.5)
point = list(99.75 99.75)
point = list(99.875 99.875)
point = list(99.9375 99.9375)
point = list(99.96875 99.96875)
point = list(99.99999 99.99999)
point = list(99.99999 100.0000)
point = list(100.00000  99.99999)
point = list(100.00000 100.00000)
point = list(100.00001 100.00000)
point = list(100.00000 100.00001)
point = list(100.00001 100.00001)
point = list(100.00000 100.09375)
point = list(100.09375 100.00000)
point = list(100.09375 100.09375)
point = list(100.0625 100.0000)
isPointInside(poly point)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-18: Test if point is inside
;       a polygon - circle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 5
generate(circle)
poly = makeInstance( 'polygon2 )
setVertices(poly getVertices(circle))
; positives
point = list(0.0 0.0)
point = list(2.0 2.0)
point = list(-2.0 2.0)
point = list(-2.0 -2.0)
point = list(2.0 -2.0)
point = list(5.0 0.0)
point = list(4.0 0.0)
; negatives
point = list(10.0 10.0)
point = list(20.0 20.0)
point = list(-20.0 20.0)
point = list(-20.0 -20.0)
point = list(20.0 -20.0)
isPointInside(poly point)
area(poly)
centroid(poly)
translate(poly list(5 5))
centroid(poly)
area(poly)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-19: Test all vertices of a
;       a polygon are on grid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
circle = makeInstance( 'circle )
circle->radius = 5
generate(circle)
poly = makeInstance( 'polygon2 )
setVertices(poly getVertices(circle))
setVertexList(poly)
isPolyOnGrid(poly)
setPolyOnGrid(poly)
isPolyOnGrid(poly)
point = list(1.0 1.0)
isPointInside(poly point)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-20: building a trirect and
;        testing rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
height = 0.8
width = 2.5
; Body ...
body = makeInstance( 'rectangle )	   	   
setHeight(body height)
setWidth(body width)
generate(body)
setRectTran(body)
bodyTran = makeInstance( 'transform2 )
setVertices(bodyTran getVertices(body))
setCentroid(bodyTran getCentroid(body))
cloneRectTran(bodyTran)
getUpperRight(bodyTran->rtran)
getLowerLeft(bodyTran->rtran)
getCentroid(bodyTran->rtran)
; Head ...
head = makeInstance( 'triangle )
setBase(head height)
setHeight(head height)
generate(head)
setRectTran(head)
headTran = makeInstance( 'transform2 )
setVertices(headTran getVertices(head))
setCentroid(headTran getCentroid(head))
cloneRectTran(headTran)
getUpperRight(headTran->rtran)
getLowerLeft(headTran->rtran)
getCentroid(headTran->rtran)
rotate(headTran 270.0)
translate(headTran list((width+height)/2.0 0.0)) 
getUpperRight(headTran->rtran)
getLowerLeft(headTran->rtran)
getCentroid(headTran->rtran)
getUpperRight(bodyTran->rtran)
getLowerLeft(bodyTran->rtran)
getCentroid(bodyTran->rtran)
name="tranTrirectRtranTest"
lib = "test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(bodyTran cv)
render(bodyTran)
setRef(headTran cv)
render(headTran)
setRef(bodyTran->rtran cv)
render((bodyTran->rtran))
setRef(headTran->rtran cv)
render((headTran->rtran))
dbSave(cv)
dbClose(cv)