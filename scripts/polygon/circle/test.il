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
cir->radius=5
cir->grid=0.025
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

lib="test"
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
cir->radius=5
cir->grid=0.025
generateHalfCircle(cir)
getOrigin(cir)
getCentroid(cir->rtran)
getUpperRight(cir->rtran)
getLowerLeft(cir->rtran)
isCentered(cir->rtran)

lib="test"
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
cir->radius=5
cir->grid=0.025
generateQuarterCircle(cir)
getOrigin(cir)
getCentroid(cir->rtran)
getUpperRight(cir->rtran)
getLowerLeft(cir->rtran)
isCentered(cir->rtran)

lib="test"
name="quarterCircleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cir cv)
render(cir)
setRef(cir->rtran cv)
render(cir->rtran)
dbSave(cv)
dbClose(cv)