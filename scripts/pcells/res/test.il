;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'res )
r = makeInstance( 'res )
classp( r 'res)
classOf(r)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Generate Pcell definition
;       file - FIXME: Not working!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getPcellCodeFromClass( 'res "pd0164" "res" "layout" "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/scripts/pcells/res/pcWrap.il" "draw")