;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'collection )
col = makeInstance( 'collection )
classp( col 'collection)
classOf(col)
getLen(col)
getList(col)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Create a collection and
;       add 3 cad objects to the
;       collection 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
col = makeInstance( 'collection )
obj0 = makeInstance( 'cadObj )
setCid(obj0 "A")
obj1 = makeInstance( 'cadObj )
setCid(obj1 "B")
obj2 = makeInstance( 'cadObj )
setCid(obj2 "C")
getCid(obj0)
getCid(obj1)
getCid(obj2)
add(col obj0)
add(col obj1)
add(col obj2)

item0 = getItem(col 0)
item1 = getItem(col 1)
item2 = getItem(col 2)

getCid(item0)
getCid(item1)
getCid(item2)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-N: Add two cadObj objects to
;       a collection and display
;       the class of the objects 
;       in the collection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
col = makeInstance( 'collection  )
setN(col 2)
getN(col)
genCollection(col "cadObj")
class(col)