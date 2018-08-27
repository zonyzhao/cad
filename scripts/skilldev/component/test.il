;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'component )
comp = makeInstance( 'component )
classp( comp 'component)
classOf(comp)
className(findClass( 'component ))
superclassesOf(classOf(comp))