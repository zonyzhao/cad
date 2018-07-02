;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'outlineChip )
col = makeInstance( 'outlineChip )
classp( col 'outlineChip)
classOf(col)