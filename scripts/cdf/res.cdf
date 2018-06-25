
/****************************************************/
 LIBRARY = "P80B_components"
 CELL    = "res"
/****************************************************/

let( ( libId cellId cdfId )
    unless( cellId = ddGetObj( LIBRARY CELL )
        error( "Could not get cell %s." CELL )
    )
    when( cdfId = cdfGetBaseCellCDF( cellId )
        cdfDeleteCDF( cdfId )
    )
    cdfId  = cdfCreateBaseCellCDF( cellId )

    ;;; Parameters
    cdfCreateParam( cdfId
        ?name           "w"
        ?prompt         "width"
        ?units          "lengthMetric"
        ?defValue       "10u"
        ?type           "string"
        ?callback       "res_mesa_CB( )"
        ?parseAsNumber  "yes"
        ?parseAsCEL     "yes"
    )
    cdfCreateParam( cdfId
        ?name           "l"
        ?prompt         "length"
        ?units          "lengthMetric"
        ?defValue       "10u"
        ?type           "string"
        ?callback       "res_mesa_CB( )"
        ?parseAsNumber  "yes"
        ?parseAsCEL     "yes"
    )

    ;;; Properties
    cdfId->formInitProc            = ""
    cdfId->doneProc                = ""
    cdfId->buttonFieldWidth        = 340
    cdfId->fieldHeight             = 35
    cdfId->fieldWidth              = 350
    cdfId->promptWidth             = 175
    cdfSaveCDF( cdfId )
)
