path = "/users/1127110/cad/scripts/skilldev/point2/regression/"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut0.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
findClass( 'point2 )
p2 = makeInstance( 'point2 )
classp( p2 'point2)
classOf(p2)
superclassesOf(classOf(p2))
name = className(findClass( 'point2 ))
fprintf( fp "name: %s\n" name)  
;####################################
;########## End Test ################
;####################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exit
