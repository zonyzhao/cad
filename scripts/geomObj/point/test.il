;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'point )
p = makeInstance( 'point )
classp( p 'point)
classOf(p)
className(classOf(p))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Create a point and describe 
;       it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p = makeInstance( 'point )
setX(p 0.0)
setY(p 4.0)
Describe( p )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Create a point and render 
;       it to a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p = makeInstance( 'point )
setX(p 0.0)
setY(p 4.0)
Describe( p )
render(p)
