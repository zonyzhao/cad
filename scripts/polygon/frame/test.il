;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'frame )
fr = makeInstance( 'frame )
classp( fr 'frame)
classOf(fr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Render the construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fr = makeInstance( 'frame )
getVertices(fr)
lib="test"
name="frameTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(fr cv)
render(fr)
dbSave(cv)
dbClose(cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Render the frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fr = makeInstance( 'frame )
setWido(fr 10.0)
setWidi(fr 8.0)
setHgto(fr 10.0)
setHgti(fr 8.0)
generate(fr)
getVertices(fr)
lib="test"
name="frameTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(fr cv)
render(fr)
;dbCreatePolygon(cv list("text" "drawing") fr->vertices)
dbSave(cv)
dbClose(cv)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate Default Rectangle 
;       Vertices 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fr = makeInstance( 'frame )
generate(fr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Generate Rectangle 
;       Vertices using different
;       width and length
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rec = makeInstance( 'rectangle )
setWid(rec 5.0)
setLen(rec 5.0)
genRect(rec)


a=list(1 2 3 4 5 6 7 8 9 10)
n=6
val=10

tmp1=rplaca(nthcdr(n a) val)
tmp0='()
for( i 1 n
     tmp0 = cons(popf(a) tmp0)
);for
tmp0=reverse(tmp0)
ret=append(tmp0 tmp1)
     

a=list(list(0.0 0.0) list(0.0 100.0) list(100.0 100.0) list(100.0 0.0))
n=1
val=list(100.0 100.0)
tmp1=rplaca(nthcdr(n a) val)
tmp0='()
for( i 1 n
     tmp0 = cons(popf(a) tmp0)
);for
tmp0=reverse(tmp0)
ret=append(tmp0 tmp1)
