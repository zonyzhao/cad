;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'circle )
cir = makeInstance( 'circle )
classp( cir 'circle)
classOf(cir)
cir->radius
cir->X
cir->Y
cir->direction
cir->grid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate a small circle.
;       Under 2048 vertices
;       and test its rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
cir->radius=100
cir->grid=0.1
generate(cir)
getOrigin(cir)
getCentroid(cir->rtran)
getUpperRight(cir->rtran)
getLowerLeft(cir->rtran)
isCentered(cir->rtran)
; Raw Vertex List
vertices = cir->vertices

; Play with raw vertex list
vertObj='()
i = 0
foreach( vert vertices
	  sprintf(vName "vObj%d" i)
	  sprintf(estrng strcat(vName "=makeInstance( 'vertex2 )"))
	  evalstring(estrng)
	  sprintf(estrng strcat("setVertex(" vName " vert)"))
	  evalstring(estrng)
	  sprintf(estrng strcat("setGrid(" vName " cir->grid)"))
	  evalstring(estrng)
	  sprintf(estrng strcat("setId(" vName " \"circle[%d]\")") i)
	  evalstring(estrng)
	  sprintf(estrng strcat("vertObj=cons(" vName " vertObj)"))
	  evalstring(estrng)
	  i=i+1
);foreach

lib="reticle"
name="circleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
setRef(cir->rtran cv)
render(cir->rtran)
dbSave(cv)
dbClose(cv)

;###############################################
; Need to explicitly generate vertex object list
;###############################################
genVertObjList(cir)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Pass Circle Vertex Object list to
;       a polygon and render it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
poly = makeInstance( 'polygon2 )
setVertices(poly cir->vertObjList)
setName(poly "circle")
setLib(poly "test")
setLayer(poly "sd")
setPurpose(poly "drawing")
renderPolygon2(poly)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Generate half circle.
;       Under 2048 vertices
;       and test its rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
cir->radius=100
cir->grid=0.1
generateHalfCircle(cir)
getOrigin(cir)
getCentroid(cir->rtran)
getUpperRight(cir->rtran)
getLowerLeft(cir->rtran)
isCentered(cir->rtran)

lib="reticle"
name="halfCircleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
setRef(cir->rtran cv)
render(cir->rtran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Generate quarter circle.
;       Under 2048 vertices
;       and test its rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
cir->radius=100.0
cir->grid=0.1
generateQuarterCircle(cir)
getOrigin(cir)
getCentroid(cir->rtran)
getUpperRight(cir->rtran)
getLowerLeft(cir->rtran)
isCentered(cir->rtran)

lib="reticle"
name="quarterCircleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
setRef(cir->rtran cv)
render(cir->rtran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Generate quarter circle
;       and add it to a transform
;       for rendering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
setRadius(cir 100.0)
setGrid(cir 0.1)
generateQuarterCircle(cir)
cTran = makeInstance( 'transform2 )
setVertices(cTran getVertices(cir))
setCentroid(cTran getCentroid(cir))
cloneRectTran(cTran)

lib="reticle"
name="quarterCircleTestTran"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cTran cv)
render(cTran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Generate quarter circle
;       and add it to a transform
;       for rendering. Rotate 90 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
setRadius(cir 100.0)
setGrid(cir 0.1)
generateQuarterCircle(cir)
cTran = makeInstance( 'transform2 )
setVertices(cTran getVertices(cir))
setCentroid(cTran getCentroid(cir))
cloneRectTran(cTran)
rotate(cTran 90.0)

lib="reticle"
name="quarterCircleTestTranRot"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cTran cv)
render(cTran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Generate inverse quarter circle
;       and add it to a transform
;       for rendering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cir = makeInstance( 'circle )
setRadius(cir 100.0)
setGrid(cir 0.1)
generateQuarterCircleInv(cir)
cTran = makeInstance( 'transform2 )
setVertices(cTran getVertices(cir))
setCentroid(cTran getCentroid(cir))
cloneRectTran(cTran)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="reticle"
name="quarterCircleInvTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Generate a circle polygon based
;       upon fixed angle increments
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; form the wafer outline - no flats
waferRadius = 50000.0
cir = makeInstance( 'circle )
setRadius(cir waferRadius)
generatePolygon(cir 360.0 )
pnts = getPoints(cir->points)
classOf(pnts)
isEmpty(pnts)
getLen(pnts)
pntsCollection = getCollection(pnts)
pnt0 = nth(0 pntsCollection)
classOf(pnt0)
getPoint(pnt0)
pnt1 = nth(1 pntsCollection)
getPoint(pnt1)
pnt2 = nth(2 pntsCollection)
getPoint(pnt2)
foreach(pnt pntsCollection
  printf("point: %L\n" getPoint(pnt))
)
points2Vertex(cir)
;------------------
lib="ln0246"
name="cirlePolygonTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
dbSave(cv)
dbClose(cv)

; Form the exluson ring
exclusionRing = 3500
cir = makeInstance( 'circle )
setRadius(cir waferRadius-exclusionRing)
generatePolygon(cir 360.0 )
pnts = getPoints(cir->points)
classOf(pnts)
isEmpty(pnts)
getLen(pnts)
pntsCollection = getCollection(pnts)
pnt0 = nth(0 pntsCollection)
classOf(pnt0)
getPoint(pnt0)
pnt1 = nth(1 pntsCollection)
getPoint(pnt1)
pnt2 = nth(2 pntsCollection)
getPoint(pnt2)
foreach(pnt pntsCollection
  printf("point: %L\n" getPoint(pnt))
)
points2Vertex(cir)
;------------------
lib="ln0246"
name="cirlePolygonTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "a")
setRef(cir cv)
render(cir)
dbSave(cv)
dbClose(cv)