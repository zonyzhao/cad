;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'PcellParam )
pcp = makeInstance( 'PcellParam )
classp( pcp 'PcellParam)
classOf(pcp)