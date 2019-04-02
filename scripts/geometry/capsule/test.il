;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'capsule )
cap = makeInstance( 'capsule )
classp( cap 'capsule)
classOf(cap)
getWidth(cap)
getHeight(cap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Generate and render unit 
;       capsule and its rectTran
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
generate(cap)
setLayer(cap "text")
lib = "test"
name = "capsuleTest"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cap cv)
render(cap)
; FIXME: bbox disabled
;setRef(cap->rtran cv)
;render(cap->rtran)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Generate a capsule and 
;       render it
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setHeight(cap 50.0)
setWidth(cap 25.0)
generate(cap)
setLayer(cap "text")
setPurpose(cap "drawing")
name="capsuleTest2"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cap cv)
render(cap)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Generate a capsule and 
;       and rotate it by 90 degrees
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setHeight(cap 25.0)
setWidth(cap 50.0)
generate(cap)
setLayer(cap "sd")
setPurpose(cap "drawing")
rotate(cap 90.0)
name="capsuleRotTest2"
lib="test"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setRef(cap cv)
render(cap)
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Generate Rectangle 
;       Vertices using different
;       width and length
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setWidth(cap 100.0)
setLength(cap 50.0)
genCapsule(cap)
cap->shapes->list->elems
cap->layers->list->elems

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Generate Capsule, 
;       pass it to a shape ojbect
;       and render it in a cell view
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cap = makeInstance( 'capsule )
setWidth(cap 25.0)
setLength(cap 50.0)
shp = makeInstance( 'shape )
setVertices(shp genCapsule(cap))
lib = "test"
name = "capsule"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setCvRef(shp cv)
setLayer(shp "sd")
setPurpose(shp "drawing")
render(shp)
dbSave(shp->cvRef)
dbClose(shp->cvRef)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Generate a mesa resistor device
;       layout using mesa and sd 
;       pass it to a shape ojbect
;       and render it in a cell view
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Class Parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sdEnc = 0.25
sdConLen = 2.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Formal Parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wid = 5.0
len = 10.0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Calculations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sdConWid = wid-2.0*sdEnc
; Contact Transforms
cptrn = -1.0*len/2.0+sdConLen/2.0+sdEnc
cntrn = -1.0*cptrn
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mesaFilm = makeInstance( 'rectangle )
setWid(mesaFilm wid)
setLen(mesaFilm len)
sdContact = makeInstance( 'rectangle )
setWid(sdContact sdConWid)
setLen(sdContact sdConLen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mesa Film Shape
mesaFilmShp = makeInstance( 'shape )
setVertices(mesaFilmShp genRect(mesaFilm))
setLayer(mesaFilmShp "mesa")
setPurpose(mesaFilmShp "drawing")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SD POS Contact Shape
sdConShpP = makeInstance( 'shape )
setVertices(sdConShpP genRect(sdContact))
setLayer(sdConShpP "sd")
setPurpose(sdConShpP "drawing")
; Translate POS Contact to proper position
shapeTranslate(sdConShpP list(cptrn 0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SD NEG Contact Shape
sdConShpN = makeInstance( 'shape )
setVertices(sdConShpN genRect(sdContact))
setLayer(sdConShpN "sd")
setPurpose(sdConShpN "drawing")
; Translate NEG Contact to proper position
shapeTranslate(sdConShpN list(cntrn 0))
;;;;;;;;;;;;;;;;;;;;;;;
; Open the cellview and
; set the shape references
lib = "test"
name = "mesaR"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
setCvRef(mesaFilmShp cv)
setCvRef(sdConShpP cv)
setCvRef(sdConShpN cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render the resitor shapes
sub = render(mesaFilmShp)
cp = render(sdConShpP)
cn =render(sdConShpN)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Add in electrical nets
pNet = dbMakeNet(cv "POS")
dbCreateTerm(pNet "P" "inputOutput")
nNet = dbMakeNet(cv "NEG")
dbCreateTerm(nNet "N" "inputOutput")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Make a pin rectangle
pr = makeInstance( 'rectangle )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Add in POS pin shape
ppShp = makeInstance( 'shape )
setVertices(ppShp genRect(pr))
setLayer(ppShp "sd")
setPurpose(ppShp "net")
; Translate POS Pin Shape to proper position
shapeTranslate(ppShp list(cptrn  0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Add in POS pin shape
pnShp = makeInstance( 'shape )
setVertices(pnShp genRect(pr))
setLayer(pnShp "sd")
setPurpose(pnShp "net")
; Translate POS Pin Shape to proper position
shapeTranslate(pnShp list(cntrn  0))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set the shape references to the
; cv
setCvRef(ppShp  cv)
setCvRef(pnShp  cv)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Render the two pin shapes
pp = render(ppShp)
pn = render(pnShp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Add Electrical Pins to the Pin Shapes
dbCreatePin(pNet pp "pp")
dbCreatePin(nNet pp "pn")
dbSave(cv)
dbClose(cv)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Convert UT-4 to a "main" skill
;       procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "test"
name = "mesaRes"
wid = 5.0
len = 6.0
procedure( main( lib name wid len )
  let( ( sdEnc sdConLen sdConWid cptrn cntrn mesaFilm mesaFilmShp
         sdConShpP sdConShpN cv pNet nNet pr ppShp pnShp pp pn)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Class Parameters
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   sdEnc = 0.25
	   sdConLen = 2.0
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Calculations
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   sdConWid = wid-2.0*sdEnc
	   ; Contact Transforms
	   cptrn = -1.0*len/2.0+sdConLen/2.0+sdEnc
	   cntrn = -1.0*cptrn
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   mesaFilm = makeInstance( 'rectangle )
	   setWid(mesaFilm wid)
	   setLen(mesaFilm len)
	   sdContact = makeInstance( 'rectangle )
	   setWid(sdContact sdConWid)
	   setLen(sdContact sdConLen)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Mesa Film Shape
	   mesaFilmShp = makeInstance( 'shape )
	   setVertices(mesaFilmShp genRect(mesaFilm))
	   setLayer(mesaFilmShp "mesa")
	   setPurpose(mesaFilmShp "drawing")
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; SD POS Contact Shape
	   sdConShpP = makeInstance( 'shape )
	   setVertices(sdConShpP genRect(sdContact))
	   setLayer(sdConShpP "sd")
	   setPurpose(sdConShpP "drawing")
	   ; Translate POS Contact to proper position
	   shapeTranslate(sdConShpP list(cptrn 0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; SD NEG Contact Shape
	   sdConShpN = makeInstance( 'shape )
	   setVertices(sdConShpN genRect(sdContact))
	   setLayer(sdConShpN "sd")
	   setPurpose(sdConShpN "drawing")
	   ; Translate NEG Contact to proper position
	   shapeTranslate(sdConShpN list(cntrn 0))
	   ;;;;;;;;;;;;;;;;;;;;;;;
	   ; Open the cellview and
	   ; set the shape references
	   cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "w")
	   setCvRef(mesaFilmShp cv)
	   setCvRef(sdConShpP cv)
	   setCvRef(sdConShpN cv)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Render the resitor shapes
	   render(mesaFilmShp)
	   render(sdConShpP)
	   render(sdConShpN)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in electrical nets
	   pNet = dbMakeNet(cv "POS")
	   dbCreateTerm(pNet "P" "inputOutput")
	   nNet = dbMakeNet(cv "NEG")
	   dbCreateTerm(nNet "N" "inputOutput")
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Make a pin rectangle
	   pr = makeInstance( 'rectangle )
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in POS pin shape
	   ppShp = makeInstance( 'shape )
	   setVertices(ppShp genRect(pr))
	   setLayer(ppShp "sd")
	   setPurpose(ppShp "net")
	   ; Translate POS Pin Shape to proper position
	   shapeTranslate(ppShp list(cptrn  0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in POS pin shape
	   pnShp = makeInstance( 'shape )
	   setVertices(pnShp genRect(pr))
	   setLayer(pnShp "sd")
	   setPurpose(pnShp "net")
	   ; Translate POS Pin Shape to proper position
	   shapeTranslate(pnShp list(cntrn  0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Set the shape references to the
	   ; cv
	   setCvRef(ppShp  cv)
	   setCvRef(pnShp  cv)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Render the two pin shapes
	   pp = render(ppShp)
	   pn = render(pnShp)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add Electrical Pins to the Pin Shapes
	   dbCreatePin(pNet pp "pp")
	   dbCreatePin(nNet pp "pn")
	   dbSave(cv)
	   dbClose(cv)
  );let
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PCELL version of main with all the pcCEllview reference replacing
; cv
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

procedure( mesaResPcell( cv wid len )
  let( ( sdEnc sdConLen sdConWid cptrn cntrn mesaFilm mesaFilmShp
         sdConShpP sdConShpN pNet nNet pr ppShp pnShp pp pn )
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Class Parameters
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   sdEnc = 0.25
	   sdConLen = 2.0
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Calculations
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   sdConWid = wid-2.0*sdEnc
	   ; Contact Transforms
	   cptrn = -1.0*len/2.0+sdConLen/2.0+sdEnc
	   cntrn = -1.0*cptrn
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   mesaFilm = makeInstance( 'rectangle )
	   setWid(mesaFilm wid)
	   setLen(mesaFilm len)
	   sdContact = makeInstance( 'rectangle )
	   setWid(sdContact sdConWid)
	   setLen(sdContact sdConLen)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Mesa Film Shape
	   mesaFilmShp = makeInstance( 'shape )
	   setVertices(mesaFilmShp genRect(mesaFilm))
	   setLayer(mesaFilmShp "mesa")
	   setPurpose(mesaFilmShp "drawing")
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; SD POS Contact Shape
	   sdConShpP = makeInstance( 'shape )
	   setVertices(sdConShpP genRect(sdContact))
	   setLayer(sdConShpP "sd")
	   setPurpose(sdConShpP "drawing")
	   ; Translate POS Contact to proper position
	   shapeTranslate(sdConShpP list(cptrn 0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; SD NEG Contact Shape
	   sdConShpN = makeInstance( 'shape )
	   setVertices(sdConShpN genRect(sdContact))
	   setLayer(sdConShpN "sd")
	   setPurpose(sdConShpN "drawing")
	   ; Translate NEG Contact to proper position
	   shapeTranslate(sdConShpN list(cntrn 0))
	   ;;;;;;;;;;;;;;;;;;;;;;;
	   ; Open the cellview and
	   ; set the shape references
	   setCvRef(mesaFilmShp cv)
	   setCvRef(sdConShpP cv)
	   setCvRef(sdConShpN cv)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Render the resitor shapes
	   render(mesaFilmShp)
	   render(sdConShpP)
	   render(sdConShpN)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in electrical nets
	   pNet = dbMakeNet(cv "POS")
	   dbCreateTerm(pNet "P" "inputOutput")
	   nNet = dbMakeNet(cv "NEG")
	   dbCreateTerm(nNet "N" "inputOutput")
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Make a pin rectangle
	   pr = makeInstance( 'rectangle )
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in POS pin shape
	   ppShp = makeInstance( 'shape )
	   setVertices(ppShp genRect(pr))
	   setLayer(ppShp "sd")
	   setPurpose(ppShp "net")
	   ; Translate POS Pin Shape to proper position
	   shapeTranslate(ppShp list(cptrn  0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add in POS pin shape
	   pnShp = makeInstance( 'shape )
	   setVertices(pnShp genRect(pr))
	   setLayer(pnShp "sd")
	   setPurpose(pnShp "net")
	   ; Translate POS Pin Shape to proper position
	   shapeTranslate(pnShp list(cntrn  0))
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Set the shape references to the
	   ; cv
	   setCvRef(ppShp  cv)
	   setCvRef(pnShp  cv)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Render the two pin shapes
	   pp = render(ppShp)
	   pn = render(pnShp)
	   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	   ; Add Electrical Pins to the Pin Shapes
	   dbCreatePin(pNet pp "pp")
	   dbCreatePin(nNet pp "pn")
  );let
);procedure


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Convert mesaR to mesaRes
;       master pcell using UT-5
;       "main" skill procdure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Pcell compiler code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pcDefinePCell(list(ddGetObj("test") "mesaResistor" "layout") 
             ( (wid float 5.0) (len float 10.0) )
    	     let(( pcParameters pcParamProp width length lib name)
 		   pcParameters = pcCellView->parameters->value
		   pcParamProp = car(exists(prop pcParameters (prop~>name == "wid")))
		   width = pcParamProp->value
		   pcParamProp = car(exists(prop pcParameters (prop~>name == "len"))) 
		   length = pcParamProp->value 
		   dbReplaceProp( pcCellView "viewSubType" "string" "maskLayoutParamCell")
		   lib = "test"
		   name = "mesaRes"
		   mesaResPcell( pcCellView width length )
	);let
);pcDefinePCell










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-N: Reading in a cellview and 
;       creating rectangle objectfrom 
;       the contents of a rectangle cv
;       Class Dependency: layCell 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cell = makeInstance( 'layCell )
cell->library = "test"
cell->cellName = "rectangle"
cell->viewName = "layout"
attList=getAttrList(cell)
getAttrValueByKey(cell "isParamCell")
propBag = getAttrValueByKey(cell "prop")
inst = getAttrValueByKey(cell "instances")
layHead = getAttrValueByKey(cell "layerHeaders")
layHead->?
layPp = getAttrValueByKey(cell "layerPurposePairs")
layPp->?
shapes = getAttrValueByKey(cell "shapes")
shapes->?
ct = getAttrValueByKey(cell "createTime")
groupMems = getAttrValueByKey(cell "groupMembers")
groups = getAttrValueByKey(cell "groups")
bbox = getAttrValueByKey(cell "bBox")


;##################################
; Experimental Code
; Shape Detection and processing
;##################################
lib="test"
name="rectangle"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
dbHasShape(cv)

bbox=cv->bBox

bbwidth  = caadr( bbox ) - caar( bbox )
bbheight = cadadr( bbox ) - cadar( bbox) 
bborig=list(xCoord(car(bbox)) yCoord(car(bbox)))

bbox2=list(list(-1.0 -1.0) list(3.0 3.0))
bbwidth2  = caadr( bbox2 ) - caar( bbox2 )
bbheight2 = cadadr( bbox2 ) - cadar( bbox2)
bborig2=list(xCoord(car(bbox2)) yCoord(car(bbox2))) 

shapes=dbShapeQuery(cv list("sd" "drawing") bbox2 0 0)


dbGetShapeTwigs(d_shapeId)
; moves a shape to a given cellview with the given transformation
dbMoveShape(shapeId cv list(10.0 10. "R0" 1)
; copie  a shape to a given cellview with the given transformation
dbCopyShape(shapeId cv list(10.0 10. "R0" 1)

dbClose(cv)

dbHasShape(cv)
lt = layerTile(cv list("sd" "drawing") dbShapeQuery(cv list("sd" "drawing") bbox2 0 0))

;###############################################
; Note: from the database alone you cannot get
;       shape vertices. You need to have the layout
;       open and have the layou.ao loaded in an
;       active window AND the object selected
;       in order to acess all its attributes
;###############################################
cv = geGetEditRep()
cv->libName
; "test"
cv->cellName
; "rect"

; WARNING: you can't use this function to select the objects.
;          They must be selected by the mouse in order to 
;          output anything other than the bbox
geSelectAll()

;###################################
;If the shape is a square it just gives
;bbox. You have to reconstruct the
; lowerLeft and UpperRight coords
;###################################
foreach(  obj geGetSelSet()
	  path=obj->bBox	  
)

;###################################
;This one will give me the vertices
;of a selected polygon 
;###################################
foreach(  obj geGetSelSet()
	  path=obj->path	  
)

; Vertices are at this reference
; Cadence calls them "Points"
path->?

;path
;((-15.0 7.85) 
;    (-6.7 7.85) 
;    (-6.7 13.5) 
;    (-15.0 13.5)
;)

;FIXME: This worked once, but I can now only get the bbox out?????
; NO VERTICES!!!!


geSelectAllFig()
objs=geGetSelSet()
