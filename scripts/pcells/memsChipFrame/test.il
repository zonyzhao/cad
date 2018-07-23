;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'memsChipFrame )
ol = makeInstance( 'memsChipFrame )
classp( ol 'memsChipFrame)
classOf(ol)