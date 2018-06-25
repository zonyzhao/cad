name="mymos"
lib="test"
tcCellView = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")

;
; Create "CMOS" device class
;
tcCreateDeviceClass( "symbolic" "CMOS"
  ; class parameters
  ( ( diffLayer "mesa" ) ( gate "gateStem" )
    ( diffExt 1.0 ) ( gateExt 1.0 ) )
  ; formal parameters
    ( ( width 4.0 ) ( length 0.250 ) )
  ; geometry
    dbCreateRect(tcCellView gate list(-length/2:-width/2 length/2:width/2))
    dbCreateRect(tcCellView diffLayer list(-length/2:-width/2 length/2:width/2))
    gu=dbCreateRect(tcCellView gate list(-length/2:width/2 length/2:width/2+gateExt))
    gl=dbCreateRect(tcCellView diffLayer list(-length/2-diffExt:-width/2-length/2:width/2))
    ss=dbCreateRect(tcCellView diffLayer list(-length/2-deffExt:-width/2-length/2:width/2))
    dd=dbCreateRect(tcCellView diffLayer list(length/2:-width/2 length/2+diffExt:width/2))
    ; Define nets, pins, and terminals
    gNet = dbMakeNet(tcCellView "g")
    dbCreateTerm(gNet "g" "inputOutput")
    dbCreatePin(gNet gu "u")
    dbCreatePin(gNet gl "l")
    sNet = dbMakeNet(tcCellView "s")
    dbCreateTerm(sNet "s" "inputOutput")
    dbCreatePin(sNet ss)
    dNet = dbMakeNet(tcCellView "d")
    dbCreateTerm(dNet "d" "inputOutput")
    dbCreatePin(dNet dd)
);tcCreateDeviceClass
;
; End of "CMOS" device class
;
