procedure(padLayout( )

  let( ( libN chipN pad )

    Fld1 = hiCreateStringField(
           ?name           'lib
           ?prompt         "Library  "
    )

    Fld2 = hiCreateStringField(
           ?name           'chip
	   ?prompt         "Chip Name  "
    )

    Fld3 = hiCreateRadioField(
           ?name           'type 
           ?choices        list("RF" "DC")
           ?prompt         "RF or DC "
    )

    Pad_Form = hiCreateAppForm(
                ?name   'Pad_Form
                ?fields list( Fld3 )
                ?dialogStyle    'modal
		?callback "rfcPadCB( )"
    )

    hiDisplayForm(Pad_Form)

  )
)


procedure(rfcPadCB( )
 
  let( (shape newchipN cv ncv pad)    

    cv = geGetWindowCellView()
    libN=cv~>libName
    chipN=cv~>cellName
    padType=Pad_Form->type->value
    
    if( ddGetObj(libN chipN "layout") then
    
      cv = geGetWindowCellView()
;      cv = dbOpenCellViewByType( libN chipN "layout" nil "r" ) 
      sprintf( newchipN "%s_%spadcenters" chipN lowerCase(padType) )
      sprintf( pad "%spad" padType )

      ncv = dbCopyCellView(cv libN newchipN "layout" "" nil t)
      dbSave( ncv )
;      dbClose( cv )

      ncv = dbOpenCellViewByType( libN newchipN "layout" nil "a" ) 

      foreach( inst ncv~>instances
        dbFlattenInst(inst 10 t)
      )

      
      foreach(shape ncv~>shapes
        unless( ( shape~>layerName=="GRID" || shape~>layerName=="via" ||
	          shape~>layerName==pad || shape~>layerName=="bridge" ||
	          shape~>layerName=="thick" )
          dbDeleteObject( shape )

	)
      )
      dbSave( ncv )
      dbClose( ncv )
    )
  )
)


        	

	


      
    

    

