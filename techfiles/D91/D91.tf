; Technology File TS0447_Clay
; Generated on Jun 14 15:31:43 2018
;     with @(#)$CDS: layout.exe_64 version 5.1.0-64b 06/20/2007 03:00 (cicamd4) $

; Technology File D91
; Generated on June 27 2018
;********************************
; Controls
;********************************
controls(
	viewTypeUnits(
		( maskLayout "micron" 1000 )
	);viewTypeUnits
	mfgGridResolution((0.1))
	processFamily("D91")
);controls

;********************************
; LAYER DEFINITION
;********************************
layerDefinitions(

 techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
  ( resistor                  4          resisto      )
  ( dielectric                5          dielect      )
  ( dot_etch                  6          dot_etc      )
  ( thick                     8          thick        )
  ( electrode                 10         electro      )
  ( membrane                  11         membran      )
  ( via                       13         via          )
  ( Lid_Metal                 22         Lid_Met      )
  ( spacer_via                24         spacer_      )
  ( Backside                  29         Backsid      )
  ( Bond_Ring                 32         Bond_Ri      )
  ( glass                     99         glass        )
  ( LID_ETCH                  100        LID_ETC      )
 ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( resistor                  drawing    )
  ( electrode                 drawing    )
  ( dielectric                drawing    )
  ( thick                     drawing    )
  ( membrane                  drawing    )
  ( Bond_Ring                 drawing    )
  ( spacer_via                drawing    )
  ( glass                     drawing    )  
  ( via                       drawing    )
  ( Backside                  drawing    )
  ( dot_etch                  drawing    )
  ( LID_ETCH                  drawing    )
  ( Lid_Metal                 drawing    )
  ( background                drawing    )
  ( grid                      drawing    )
  ( grid                      drawing1   )
  ( annotate                  drawing    )
  ( annotate                  drawing1   )
  ( annotate                  drawing2   )
  ( annotate                  drawing3   )
  ( annotate                  drawing4   )
  ( annotate                  drawing5   )
  ( annotate                  drawing6   )
  ( annotate                  drawing7   )
  ( annotate                  drawing8   )
  ( annotate                  drawing9   )
  ( instance                  drawing    )
  ( instance                  label      )
  ( prBoundary                drawing    )
  ( prBoundary                boundary   )
  ( prBoundary                label      )
  ( align                     drawing    )
  ( hardFence                 drawing    )
  ( softFence                 drawing    )
  ( text                      drawing    )
  ( text                      drawing1   )
  ( text                      drawing2   )
  ( border                    drawing    )
  ( border                    boundary   )
  ( device                    drawing    )
  ( device                    label      )
  ( device                    drawing1   )
  ( device                    drawing2   )
  ( device                    annotate   )
  ( wire                      drawing    )
  ( wire                      label      )
  ( wire                      flight     )
  ( pin                       label      )
  ( pin                       drawing    )
  ( pin                       annotate   )
  ( axis                      drawing    )
  ( edgeLayer                 drawing    )
  ( edgeLayer                 pin        )
  ( snap                      boundary   )
  ( snap                      drawing    )
  ( snap                      grid       )
  ( stretch                   drawing    )
  ( y0                        drawing    )
  ( y1                        drawing    )
  ( y2                        drawing    )
  ( y3                        drawing    )
  ( y4                        drawing    )
  ( y5                        drawing    )
  ( y6                        drawing    )
  ( y7                        drawing    )
  ( y8                        drawing    )
  ( y9                        drawing    )
  ( hilite                    drawing    )
  ( hilite                    drawing1   )
  ( hilite                    drawing2   )
  ( hilite                    drawing3   )
  ( hilite                    drawing4   )
  ( hilite                    drawing5   )
  ( hilite                    drawing6   )
  ( hilite                    drawing7   )
  ( hilite                    drawing8   )
  ( hilite                    drawing9   )
  ( select                    drawing    )
  ( drive                     drawing    )
  ( hiz                       drawing    )
  ( resist                    drawing    )
  ( spike                     drawing    )
  ( supply                    drawing    )
  ( unknown                   drawing    )
  ( unset                     drawing    )
  ( designFlow                drawing    )
  ( designFlow                drawing1   )
  ( designFlow                drawing2   )
  ( designFlow                drawing3   )
  ( designFlow                drawing4   )
  ( designFlow                drawing5   )
  ( designFlow                drawing6   )
  ( designFlow                drawing7   )
  ( designFlow                drawing8   )
  ( designFlow                drawing9   )
  ( changedLayer              tool0      )
  ( changedLayer              tool1      )
  ( marker                    warning    )
  ( marker                    error      )
  ( Row                       drawing    )
  ( Row                       label      )
  ( Group                     drawing    )
  ( Group                     label      )
  ( Cannotoccupy              drawing    )
  ( Cannotoccupy              boundary   )
  ( Canplace                  drawing    )
  ( Unrouted                  drawing    )
  ( Unrouted                  drawing1   )
  ( Unrouted                  drawing2   )
  ( Unrouted                  drawing3   )
  ( Unrouted                  drawing4   )
  ( Unrouted                  drawing5   )
  ( Unrouted                  drawing6   )
  ( Unrouted                  drawing7   )
  ( Unrouted                  drawing8   )
  ( Unrouted                  drawing9   )
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( resistor     drawing      grid             t t t t t ) 
  ( electrode    drawing      annotate6        t t t t t )
  ( dielectric   drawing      annotate7        t t t t t )
  ( thick        drawing      annotate1        t t t t t )
  ( membrane     drawing      annotate2        t t t t t )
  ( Bond_Ring    drawing      annotate9        t t t t t )
  ( spacer_via   drawing      annotate3        t t t t t )
  ( glass        drawing      annotate4        t t t t t )
  ( via          drawing      annotate8        t t t t t )
  ( Backside     drawing      instance         t t t t t )
  ( dot_etch     drawing      annotate5        t t t t t )
  ( LID_ETCH     drawing      instanceLbl      t t t t t )
  ( Lid_Metal    drawing      prBoundary       t t t t t ) 
  ( background   drawing      background       t nil t nil nil )
  ( grid         drawing      grid             t nil t nil nil )
  ( grid         drawing1     grid1            t nil t nil nil )
  ( annotate     drawing      annotate         t t t t nil )
  ( annotate     drawing1     annotate1        t t t t nil )
  ( annotate     drawing2     annotate2        t t t t nil )
  ( annotate     drawing3     annotate3        t t t t nil )
  ( annotate     drawing4     annotate4        t t t t nil )
  ( annotate     drawing5     annotate5        t t t t nil )
  ( annotate     drawing6     annotate6        t t t t nil )
  ( annotate     drawing7     annotate7        t t t t nil )
  ( annotate     drawing8     annotate8        t t t t nil )
  ( annotate     drawing9     annotate9        t t t t nil )
  ( instance     drawing      instance         t t t t nil )
  ( instance     label        instanceLbl      t t t t nil )
  ( prBoundary   drawing      prBoundary       t t t t nil )
  ( prBoundary   boundary     prBoundaryBnd    t t t t nil )
  ( prBoundary   label        prBoundaryLbl    t t t t nil )
  ( align        drawing      defaultPacket    t t t t nil )
  ( hardFence    drawing      hardFence        t t t t nil )
  ( softFence    drawing      softFence        t t t t nil )
  ( text         drawing      text             t t t t nil )
  ( text         drawing1     text1            t t t t nil )
  ( text         drawing2     text2            t t t t nil )
  ( border       drawing      border           t t t t nil )
  ( device       drawing      device           t t t t nil )
  ( device       label        deviceLbl        t t t t nil )
  ( device       drawing1     device1          t t t t nil )
  ( device       drawing2     device2          t t t t nil )
  ( device       annotate     deviceAnt        t t t t nil )
  ( wire         drawing      wire             t t t t nil )
  ( wire         label        wireLbl          t t t t nil )
  ( wire         flight       wireFlt          t t t t nil )
  ( pin          label        pinLbl           t t t t nil )
  ( pin          drawing      pin              t t t t nil )
  ( pin          annotate     pinAnt           t t t t nil )
  ( axis         drawing      axis             t nil t t nil )
  ( edgeLayer    drawing      edgeLayer        t t t t nil )
  ( edgeLayer    pin          edgeLayerPin     t t t t nil )
  ( snap         boundary     snap             t t t t nil )
  ( snap         drawing      snap             t t t t nil )
  ( stretch      drawing      stretch          t t t t nil )
  ( y0           drawing      y0               t t t t nil )
  ( y1           drawing      y1               t t t t nil )
  ( y2           drawing      y2               t t t t nil )
  ( y3           drawing      y3               t t t t nil )
  ( y4           drawing      y4               t t t t nil )
  ( y5           drawing      y5               t t t t nil )
  ( y6           drawing      y6               t t t t nil )
  ( y7           drawing      y7               t t t t nil )
  ( y8           drawing      y8               t t t t nil )
  ( y9           drawing      y9               t t t t nil )
  ( hilite       drawing      hilite           t t t t nil )
  ( hilite       drawing1     hilite1          t t t t nil )
  ( hilite       drawing2     hilite2          t t t t nil )
  ( hilite       drawing3     hilite3          t t t t nil )
  ( hilite       drawing4     hilite4          t t t t nil )
  ( hilite       drawing5     hilite5          t t t t nil )
  ( hilite       drawing6     hilite6          t t t t nil )
  ( hilite       drawing7     hilite7          t t t t nil )
  ( hilite       drawing8     hilite8          t t t t nil )
  ( hilite       drawing9     hilite9          t t t t nil )
  ( select       drawing      select           t t t t nil )
  ( drive        drawing      drive            t t t t nil )
  ( hiz          drawing      hiz              t t t t nil )
  ( resist       drawing      resist           t t t t nil )
  ( spike        drawing      spike            t t t t nil )
  ( supply       drawing      supply           t t t t nil )
  ( unknown      drawing      unknown          t t t t nil )
  ( unset        drawing      unset            t t t t nil )
  ( designFlow   drawing      designFlow       t nil nil nil nil )
  ( designFlow   drawing1     designFlow1      t nil nil nil nil )
  ( designFlow   drawing2     designFlow2      t nil nil nil nil )
  ( designFlow   drawing3     designFlow3      t nil nil nil nil )
  ( designFlow   drawing4     designFlow4      t nil nil nil nil )
  ( designFlow   drawing5     designFlow5      t nil nil nil nil )
  ( designFlow   drawing6     designFlow6      t nil nil nil nil )
  ( designFlow   drawing7     designFlow7      t nil nil nil nil )
  ( designFlow   drawing8     designFlow8      t nil nil nil nil )
  ( designFlow   drawing9     designFlow9      t nil nil nil nil )
  ( changedLayer tool0        changedLayerTl0  nil nil t nil nil )
  ( changedLayer tool1        changedLayerTl1  nil nil t nil nil )
  ( marker       warning      markerWarn       t t t t nil )
  ( marker       error        markerErr        t t t t nil )
  ( Row          drawing      Row              t t t t nil )
  ( Row          label        RowLbl           t t t t nil )
  ( Group        drawing      Group            t t t t nil )
  ( Group        label        GroupLbl         t t t t nil )
  ( Cannotoccupy drawing      Cannotoccupy     t t t t nil )
  ( Cannotoccupy boundary     CannotoccupyBnd  t t t t nil )
  ( Canplace     drawing      Canplace         t t t t nil )
  ( Unrouted     drawing      Unrouted         t t t t nil )
  ( Unrouted     drawing1     Unrouted1        t t t t nil )
  ( Unrouted     drawing2     Unrouted2        t t t t nil )
  ( Unrouted     drawing3     Unrouted3        t t t t nil )
  ( Unrouted     drawing4     Unrouted4        t t t t nil )
  ( Unrouted     drawing5     Unrouted5        t t t t nil )
  ( Unrouted     drawing6     Unrouted6        t t t t nil )
  ( Unrouted     drawing7     Unrouted7        t t t t nil )
  ( Unrouted     drawing8     Unrouted8        t t t t nil )
  ( Unrouted     drawing9     Unrouted9        t t t t nil )
 ) ;techDisplays

techDerivedLayers(
	( rcon                  20000 ( resistor 'and electrode ) )
	( scon                  20001 ( membrane 'and thick ) )
	( electrode_dielectric  20002 ( electrode 'and dielectric ) )
	( dielectric_thick      20003 ( thick 'and dielectric ) )
 );techDerivedLayers
) ;layerDefinitions

layerRules(
	layerMfgResolutions(
	; ( layer      value )
	  ( resistor    0.1 )
	  ( electrode   0.1 )
	  ( dielectric  0.1 )
	  ( thick       0.1 )
 	  ( membrane    0.1 )
	  ( via         0.1 )
	  ( glass       0.1 )
	);layerMfgResolutions
	equivalentLayers(
		( "resistor"   "electrode")
		( "electrode"  "thick"    )
		( "thick"      "membrane" )
	);equivalentLayers
	functions(
		( resistor        "pdiff"           4  )
		( electrode       "metal"          10  )
		( dielectric      "li"              5  )
		( thick           "metal"           8  )
		( membrane        "metal"          11  )
		( glass       "passivationCut"     99  )
		( via         "tsv"                13  )
	);functions	
) ;layerRules

viaDefs(
	standardViaDefs( 
			 ( via1 electrode thick ( "dielectric" 4.0 4.0 5.0) 
			 (1 1 (0.5 0.5))  
			 (0.1 0.01) (0.1 0.1) (0.0 0.0) (0.0 0.0) (0.0 0.0) )
	);standardViaDefs
);viaDefs

;********************************
; CONSTRAINT GROUPS
;********************************
constraintGroups(

 ;( group	[override] )
 ;( -----	---------- )
  ( "foundry"	nil

    spacings(
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; Resistor layer 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth "resistor"
       		5.0 
		'hard
		'ref "RES 00.010.01"
		'description "Minimum resistor width is 5um"
		)
     ( minSpacing "resistor"	               
       		  10.0 )
     ( minNotchSpacing "resistor"	               
       		       10.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; Electrode layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth "electrode"	                        
       		4.0 )
     ( minSpacing                 
       		"electrode"	                        
		3.0 )
     ( minSpacing "resistor" "electrode"	        
       		5.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; resistor layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth                   "resistor"	                4.0 )
     ( minSpacing                 "resistor"	                7.0 )
     ( minNotchSpacing            "resistor"	                4.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; electrode layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth                   "electrode"	                5.0 )
     ( minSpacing                 "electrode"	                5.0 )
     ( minNotchSpacing            "electrode"	                5.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; dielectric layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth                   "dielectric"	                4.0 )
     ( minSpacing                 "dielectric"	                7.0 )
     ( minNotchSpacing            "dielectric"	                4.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; thick layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth                   "thick"	                5.0 )
     ( minSpacing                 "thick"	                5.0 )
     ( minNotchSpacing            "thick"	                5.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; membrane layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minWidth                   "membrane"	                5.0 )
     ( minSpacing                 "membrane"	                5.0 )
     ( minNotchSpacing            "membrane"	                5.0 )
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ; glass layer
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ( minSpacing                 "glass"	                9.0 )
     ( minWidth                   "glass"	               40.0 )
    ) ;spacings

    orderedSpacings(
     ( minExtensionDistance       "resistor"	"electrode"	1.0 )
     ( minExtensionDistance       "electrode"	"dielectric"	1.0 )
     ( minExtensionDistance       "thick"	"dielectric"	1.0 )
     ( minExtensionDistance       "glass"	"thick"	        6.0 )
    ) ;orderedSpacings

    interconnect(	
     ( validLayers ( "electrode" "thick" ) )
    );interconnect

  ) ;foundry

  

) ;constraintGroups


