;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Definition of chip/recticle stop ring
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
multipartPathTemplates(
(chipstop
        ; master path:
        (
                ("GRID" "drawing" ; lpp
                1.8               ; width
                nil               ; choppable
                )
        )
        ; offset subpath (there is none )
        nil
        ; enclosure subpath:
        (
                ("glass" "drawing" ; lpp
                 0.2               ; enclosure
                 t                 ; choppable
                 -0.2               ; begin offset
                 0.2                 ; end offset
                 )
        )
        ; set of subrectangels:
        (
                ("sd" "drawing" ; lpp
                 nil            ; width
                 nil            ; length
                 t              ; choppable
                 nil            ; separation
                 nil            ; justification
                 nil            ; space
                 -0.6             ; begin offset
                 )
        )
 );end chipstop 
);multipartPathTemplates
