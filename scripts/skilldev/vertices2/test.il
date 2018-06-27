;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'vertices2 )
vs2 = makeInstance( 'vertices2 )
classp( vs2 'vertices2)
classOf(vs2)
vs2->vertexList
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Adding a vertex to the 
;       vertex list of vertices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v2 = makeInstance( 'vertex2 )
val = list(10.0 10.0)
setVertex(v2 val)
v2->x
v2->y
v2->value
vs2 = makeInstance( 'vertices2 )
addToVerticesList(vs2 v2)
; add second vertex
v3 = makeInstance( 'vertex2 )
val = list(20.0 20.0)
setVertex(v3 val)
v3->x
v3->y
v3->value
addToVerticesList(vs2 v3)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Getting a vertex from the 
;       list of vertices
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
v2 = makeInstance( 'vertex2 )
val = list(10.0 10.0)
setVertex(v2 val)
v2->x
v2->y
v2->value
vs2 = makeInstance( 'vertices2 )
addToVerticesList(vs2 v2)
; add second vertex
v3 = makeInstance( 'vertex2 )
val = list(20.0 20.0)
setVertex(v3 val)
v3->x
v3->y
v3->value
addToVerticesList(vs2 v3)
ind = 0
getFromVerticesList(vs2 ind)