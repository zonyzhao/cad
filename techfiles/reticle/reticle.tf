; Technology File reticle
; Generated on Jul 31 12:52:57 2018
;     with @(#)$CDS: virtuoso version 6.1.6-64b 09/26/2013 22:30 (sjfnl160) $

;********************************
; CONTROLS
;********************************
controls(
 techVersion("1.0")

 refTechLibs(
; techLibName            
; -----------            
  "D91" 
 );refTechLibs

 processFamily(
      "D91"
 );processFamily

);controls


;********************************
; LAYER DEFINITION
;********************************
layerDefinitions(

 techPurposes(
 ;( PurposeName               Purpose#   Abbreviation )
 ;( -----------               --------   ------------ )
 ;User-Defined Purposes:
  (         pm                1          pm       )
  (        x32                2          x32      )
  (        y32                3          y32      )
  (        x53                4          x53      )
  (        y53                5          y53      )
  (        rbr                6          rbr      )
  (        rdl                7          rdl      )
  (        rel                8          rel      )
  (        rgl                9          rgl      )
  (        rlm               10          rlm      )
  (        rmb               11          rmb      )
  (        rsv               12          rsv      )
  (        rth               13          rth      )
 ) ;techPurposes

 techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
  ( amex                       1          amex        )
  ( GRID                      14          GRID        )
  ( numbers                   15          numbers     )
 ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( GRID                      drawing    )
  ( numbers                   drawing    )
  ( amex                      pm         )
  ( amex                      x32        )
  ( amex                      y32        )
  ( amex                      x53        )
  ( amex                      y53        )
  ( amex                      rbr        )
  ( amex                      rdl        )
  ( amex                      rel        )
  ( amex                      rgl        )
  ( amex                      rlm        )
  ( amex                      rmb        )
  ( amex                      rsv        )
  ( amex                      rth        )
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( GRID         drawing      creamlineStyle0_L t t nil t t  )
  ( numbers      drawing      orangelineStyle0_L t t nil t t )
  ( amex         pm           creamlineStyle0_L t t nil t t  )
  ( amex         x32          creamlineStyle0_L t t nil t t  )
  ( amex         y32          creamlineStyle0_L t t nil t t  )
  ( amex         x53          creamlineStyle0_L t t nil t t  )
  ( amex         y53          creamlineStyle0_L t t nil t t  )
  ( amex         rbr          creamlineStyle0_L t t nil t t  )
  ( amex         rdl          creamlineStyle0_L t t nil t t  )
  ( amex         rel          creamlineStyle0_L t t nil t t  )
  ( amex         rgl          creamlineStyle0_L t t nil t t  )
  ( amex         rlm          creamlineStyle0_L t t nil t t  )
  ( amex         rmb          creamlineStyle0_L t t nil t t  )
  ( amex         rsv          creamlineStyle0_L t t nil t t  )
  ( amex         rth          creamlineStyle0_L t t nil t t  )
 ) ;techDisplays

 techDerivedLayers(
 ;( DerivedLayerName          #          composition  )
 ;( ----------------          ------     ------------ )
  ( xynum                     30000           ( numbers    'and    resistor  ))
 ) ;techDerivedLayers

) ;layerDefinitions
