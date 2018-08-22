;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'line )
l = makeInstance( 'line )
classp( l 'line)
classOf(l)
className(classOf(l))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0 Create a line and describe it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
l = makeInstance( 'line  )
setA(l 4.0)
setB(l -16.5)
setC(l 1.0)
Describe( l )