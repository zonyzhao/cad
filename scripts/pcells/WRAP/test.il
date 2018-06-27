;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'WRAP )
ring = makeInstance( 'WRAP )
classp( ring 'WRAP)
classOf(ring)