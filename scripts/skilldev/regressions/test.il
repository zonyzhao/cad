path = "/users/1127110/cad/scripts/skilldev/cadObj/regression/"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut0.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
findClass( 'cadObj )
co = makeInstance( 'cadObj )
classp( co 'cadObj)
classOf(co)
superclassesOf(classOf(co))
name = className(findClass( 'cadObj ))
fprintf( fp "name: %s\n" name)  
;####################################
;########## End Test ################
;####################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Test diff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut1.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
; match
a = makeInstance( 'cadObj )
setOid(a "foo")
b = makeInstance( 'cadObj )
setOid(b "foo")
name = diff(a b)
fprintf( fp "match case: %L\n" name)
; mismatch
a = makeInstance( 'cadObj )
setOid(a "foo")
b = makeInstance( 'cadObj )
setOid(b "foobar")
name = diff(a b)
fprintf( fp "mismatch case: %L\n" name)  
;###################################
;########## End Test ###############
;###################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
exit
path = "/users/1127110/cad/scripts/skilldev/coord2/regression/"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut0.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
findClass( 'coord2 )
c2 = makeInstance( 'coord2 )
classp( c2 'coord2)
classOf(c2)
superclassesOf(classOf(c2))
name = className(findClass( 'coord2 ))
fprintf( fp "name: %s\n" name)  
;####################################
;########## End Test ################
;####################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

exit
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

exit
