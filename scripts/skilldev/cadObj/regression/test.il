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
