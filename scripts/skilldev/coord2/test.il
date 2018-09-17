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
; UT-2: Set coordinate values 
;       using a list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
c2 = makeInstance( 'coord2 )
setCoord(c2 list(5.0 10.0))
getCoord(c2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: diff two coordinates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; match
c0 = makeInstance( 'coord2 )
setCoord(c0 list(0.0 0.0))
c1 = makeInstance( 'coord2 )
setCoord(c1 list(0.0 0.0))
diff(c0 c1)
;mismatch x
c0 = makeInstance( 'coord2 )
setCoord(c0 list(0.0 0.0))
c1 = makeInstance( 'coord2 )
setCoord(c1 list(1.0 0.0))
diff(c0 c1)
;mismatch y
c0 = makeInstance( 'coord2 )
setCoord(c0 list(0.0 0.0))
c1 = makeInstance( 'coord2 )
setCoord(c1 list(0.0 1.0))
diff(c0 c1)
;mismatch x,y
c0 = makeInstance( 'coord2 )
setCoord(c0 list(0.0 0.0))
c1 = makeInstance( 'coord2 )
setCoord(c1 list(1.0 1.0))
diff(c0 c1)