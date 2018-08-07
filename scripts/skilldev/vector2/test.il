;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'vector2 )
vect = makeInstance( 'vector2 )
classp( vect 'vector2)
classOf(vect)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Set head and tail return
;       magniture and theta
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vect = makeInstance( 'vector2 )
setHead(vect 0:1)
setTail(vect 0:0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Vector Dot product of two
;       vector2's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vectA = makeInstance( 'vector2 )
setHead(vectA -6.0:8.0)
setTail(vectA 0.0:0.0)
vectB = makeInstance( 'vector2 )
setHead(vectB 5.0:12.0)
setTail(vectB 0.0:0.0)
dot(vectA vectB)
acos(dot(vectA vectB))/3.141593*180
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Vector Cross product of two
;       vector2's
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vectA = makeInstance( 'vector2 )
setHead(vectA -6.0:8.0)
setTail(vectA 0.0:0.0)
vectB = makeInstance( 'vector2 )
setHead(vectB 5.0:12.0)
setTail(vectB 0.0:0.0)
asin(cross(vectA vectB)/(mag(vectA)*mag(vectB)))/3.141593*180
asin(cross(vectB vectA)/(mag(vectA)*mag(vectB)))/3.141593*180
angle(vectA)-angle(vectB)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Convert a Cartesian vector
;       to a polar vector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vectA = makeInstance( 'vector2 )
setHead(vectA -6.0:8.0)
setTail(vectA 0.0:0.0)
setPolar(vectA)