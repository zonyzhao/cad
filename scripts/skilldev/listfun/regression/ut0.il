;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0; Existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut0.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
findClass( 'listfun )
lf = makeInstance( 'listfun )
classp( lf 'listfun)
classOf(lf)
superclassesOf(classOf(lf))
name = className(findClass( 'listfun ))
fprintf( fp "name: %s\n" name)  
;####################################
;########## End Test ################
;####################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
