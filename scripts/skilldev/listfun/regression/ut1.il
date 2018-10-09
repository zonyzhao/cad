;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1; Tests setting a list and 
;       getting the n item "head"
;       of a list
; FIXME: off by 1 errors in head length
;        and list length?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
file = "ut1.out"
target = strcat(path "/" file)
fp = outfile(target)
;###################################
;######## BEGIN TEST ###############
;###################################
a=list(0 1 2 3 4 5 6 7 8 9)
n=4
fprintf( fp "N: %d\n" n)
lis = makeInstance( 'listfun )
setElems(lis a)
elems = getElems(lis)
fprintf( fp "elems: %L\n" elems)  
head = head(lis n)
fprintf( fp "head: %L\n" head)  
len = getLen(lis)
fprintf( fp "length: %d\n" len)
;####################################
;########## End Test ################
;####################################	
close(fp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;