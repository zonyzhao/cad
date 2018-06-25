;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'coord2 )
c2 = makeInstance( 'coord2 )
classp( c2 'coord2)
classOf(c2)
getX(c2)
getY(c2)
getCoord(c2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Set coordinate values 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c2 = makeInstance( 'coord2 )
setX(c2 5.0)
setY(c2 10.0)
getCoord(c2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Set coordinate values 
;       using a list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c2 = makeInstance( 'coord2 )
setCoord(c2 list(5.0 10.0))
getCoord(c2)