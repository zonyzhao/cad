; pcSegment.il
; Compile code for segment Pcell 
pcDefinePCell(list(ddGetObj("pa0715") "segment" "layout") 
             ((Radius float 5.0) 
	      (Grid float 0.025) 
	      (Layer string "sd"))
	      let(( pcParameters pcParamProp layer purpose cir poly)
		    pcParameters = pcCellView->parameters->value
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Radius")))
		    Radius = pcParamProp->value
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Grid"))) 
		    Grid = pcParamProp->value 
		    pcParamProp = car(exists(prop pcParameters (prop~>name == "Layer")))
		    layer = pcParamProp->value
		    dbReplaceProp( pcCellView "viewSubType" "string" "maskLayoutParamCell") 
		    cir = makeInstance( 'circle )
		    cir->radius=Radius
		    cir->grid=Grid
		    generate(cir)
		    purpose = "drawing" 
		    dbCreatePolygon(pcCellView 
			            list(Layer purpose)
			            cir->vertices)
		);let
);pcDefineCell

;lib = "pa0715"
;name = "segment"
;view = "layout"