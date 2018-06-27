;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'mesaResistor )
mres = makeInstance( 'mesaResistor )
classp( mres 'mesaResistor)
classOf(mres)