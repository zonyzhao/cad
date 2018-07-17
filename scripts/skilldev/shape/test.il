;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'shape )
shp = makeInstance( 'shape )
classp( shp 'shape)
classOf(shp)
superclassesOf(classOf(shp))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;