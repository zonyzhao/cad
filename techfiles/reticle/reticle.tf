; Technology File: reticle
; Incremental technfile containing the reticle specific
; data needed to create reticles
; Created on 5.3.18 08:40:31 2017

;********************************
; Controls
;********************************
controls(
	refTechLibs("D91")
);controls
;********************************

;********************************
; LAYER DEFINITIONS
;********************************
layerDefinitions(
	techLayers(
		;( LayerName                 Layer#     Abbreviation )
 		;( ---------                 ------     ------------ )
		( GRID                      14         GRID          )
		( numbers                   15         numbers        )
 	);techLayers
	techLayerPurposePriorities(
		;layers are ordered from lowest to highest priority
	 	;( LayerName                 Purpose    )
 	 	( GRID                         drawing    )
		( numbers                      drawing    )
	);techLayerPurposePriorities
	techDisplays(
		;( LayerName    Purpose      Packet           Vis Sel Con2ChgLy DrgEnbl Valid )
 		;( ---------    -------      ------           --- --- --------- ------- ----- )
		( GRID         drawing      creamlineStyle0_L  t   t     nil       t      t   )
		( numbers      drawing      orangelineStyle0_L t   t     nil       t      t   )
 	);techDisplays
 	techDerivedLayers(
		( xynum 30000 ( numbers 'and GRID ) )
	);techDerivedLayers
);layerDefinitions
;********************************