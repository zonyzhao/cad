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