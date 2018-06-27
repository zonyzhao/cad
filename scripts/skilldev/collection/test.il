;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'collection )
col = makeInstance( 'collection )
classp( col 'collection)
classOf(col)
col->n
col->list
col->cid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Add two shape objects to
;       a collection and display
;       the class of the objects 
;       in the collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
col = makeInstance( 'collection  )
setN(col 2)
getN(col)
genCollection(col "shape")
class(col)