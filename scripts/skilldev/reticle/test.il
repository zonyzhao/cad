;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'reticle )
ret = makeInstance( 'reticle )
classp( ret 'reticle)
classOf(ret)
superclassesOf(classOf(ret))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Primary Reticle Checking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.)Dimension
; 2.)Resolution
; 3.)Grid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p"
view  = "layout"
mlview = "maskLayout"
cv = dbOpenCellViewByType( lib name view mlview "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Primary Reticle Resolution Testing - shifted reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p_xyn"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10.0)
setMaxDim(ret 20000.0)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Secondary Reticle Resolution Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0s"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Primary Reticle Resolution Testing - shifted reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0s_xyn"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Dimension Comparison
;       Check of Primary and 
;       Secondary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
; PRIMARY
name  = "pd0164_0p"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
retp = makeInstance( 'reticle )
setRef(retp cv)
setRes(retp 10)
setMaxDim(retp 20000)
setOverlap(retp 4.0)
setSrGrid(retp 0.1)
checkDim(retp)
checkRes(retp)
; SECONDARY
name  = "pd0164_0s"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
rets = makeInstance( 'reticle )
setRef(rets cv)
setRes(rets 10)
setMaxDim(rets 20000)
setOverlap(rets 4.0)
setSrGrid(rets 0.1)
checkDim(rets)
checkRes(rets)
; Full final check of primary and secondary
if( getDimValid(retp) && getResValid(retp) then
  println("INFO: Valid Primary")
  if(getDimValid(rets) && getResValid(rets) then
    println("INFO: Valid Secondary")		       
    if(getWidth(retp) == getWidth(rets) &&  getHeight(retp) == getHeight(rets) then
       printf(" INFO: Secondary Dimensions Match Primary: Width %8.1f, Height %8.1f\n" float(getWidth(retp)) float(getHeight(retp)) )
    else
       printf(" ERROR: Secondary Dimensions   DO NOT MATCH   Primary: Width %8.1f, Height %8.1f\n" float(getWidth(retp)) float(getHeight(retp)) )  
       printf("                                           Secondary: Width %8.1f, Height %8.1f\n" float(getWidth(rets)) float(getHeight(rets)) )
    );if
  else
    println("ERROR: Invalid Primary")
  );if
else
  println("ERROR: Invalid Secondary")
);if
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Initial Processing of a 
;       Reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 1.) Reticle Dimension Checks
; Step 2.) Copy primary reticle into "_shifturq" cell view
; Step 3.) Shift Reticle to URQ 
; Step 4.) Identify Chips and Coupons via Number Pads
; Step 5.) Perform scrible line integrity checks
; Step 6:) Perform intra-reticle die site periodicity checks
; Step 6.) Locate Intra Reticle Chip and Coupon Origins
; Step 8.) Create a list of Chip, Coupon and their respective pad origins
; Step 9.) Print out a Reticle Chip and Coupon List 
;;;;;;;;;
; Step 1.
;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p"
view  = "layout"
mlview = "maskLayout"
cvr = dbOpenCellViewByType( lib name view mlview "r")
ret = makeInstance( 'reticle )
setRef(ret cvr)
setRes(ret 10.0)
setMaxDim(ret 20000.0)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
;;;;;;;;
; Step 2.
;;;;;;;;
cell = makeInstance( 'cv )
setRef(cell cvr)
setName(cell name)
setLib(cell lib)
setView(cell view)
copyName = strcat(getName(cell) "_shifturq")
Copy(cell copyName)
;dbClose(cvr)
;;;;;;;;
; Step 3.
;;;;;;;;
lib = "pd0164"
view = "layout"
cvc = dbOpenCellViewByType( lib copyName view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cvc)
retShift = shiftURQ(bb)
dbClose(cvc)
;;;;;;;;
; Step 4.
;;;;;;;;
lib = "pd0164"
name = "pd0164_0p"
view = "layout"
copyName = strcat(name "_shifturq")
;copyName = strcat(name "_xyn")
cvc = dbOpenCellViewByType( lib copyName view "maskLayout" "r")
ret = makeInstance( 'reticle )
setLib(ret lib)
setName(ret copyName)
setView(ret view)
setRef(ret cvc)
setRes(ret 10.0)
setMaxDim(ret 20000.0)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
setNumRetChips(ret 8)
setNumRetOverhead(ret 1)
;setShiftUrq(ret retShift)
setPadChipName(ret "pd0164_0_xyPad_SLA")
setPadOverheadName(ret "pd0164_0_xyPad_SLB")
setPadCouponName(ret "pd0164_0_xyPad_SLC")
findXynPads(ret)
checkSum(ret)
getChipList(ret)
getOverheadList(ret)
getCouponList(ret)
isEmpty(ret->chips)
isEmpty(ret->overhead)
isEmpty(ret->coupons)
getLen(ret->chips)
getName(getItem(ret->chips 0))
getName(getItem(ret->chips 1))
getName(getItem(ret->chips 2))
getName(getItem(ret->chips 3))
getName(getItem(ret->chips 4))
getName(getItem(ret->chips 5))
getName(getItem(ret->chips 6))
getName(getItem(ret->chips 7))

getName(ret)
getLib(ret)
getView(ret)

chip0 = getItem(ret->chips 0)
getName(chip0)
getOrient(chip0)
getBbx(getBbx(chip0))
getWidth(getBbx(chip0))
getHeight(getBbx(chip0))
getOrigin(getBbx(chip0))

getName(chip0->numpad)
getOrient(chip0->numpad)
getBbx(getBbx(chip0->numpad))
getWidth(getBbx(chip0->numpad))
getHeight(getBbx(chip0->numpad))

chip1 = getItem(ret->chips 1)
getName(chip1)
getOrient(chip1)
getBbx(getBbx(chip1))
getWidth(getBbx(chip1))
getHeight(getBbx(chip1))
getOrigin(getBbx(chip1))

getName(chip1->numpad)
getBbx(getBbx(chip1->numpad))
getWidth(getBbx(chip1->numpad))
getHeight(getBbx(chip1->numpad))

chip2 = getItem(ret->chips 2)
getName(chip2)
getOrient(chip2)
getBbx(getBbx(chip2))
getWidth(getBbx(chip2))
getHeight(getBbx(chip2))
getOrigin(getBbx(chip2))

getName(chip2->numpad)
getBbx(getBbx(chip2->numpad))
getWidth(getBbx(chip2->numpad))
getHeight(getBbx(chip2->numpad))

chip3 = getItem(ret->chips 3)
getName(chip3)
getOrient(chip3)
getBbx(getBbx(chip3))
getWidth(getBbx(chip3))
getHeight(getBbx(chip3))
getOrigin(getBbx(chip3))

getName(chip3->numpad)
getBbx(getBbx(chip3->numpad))
getWidth(getBbx(chip3->numpad))
getHeight(getBbx(chip3->numpad))

chip4 = getItem(ret->chips 4)
getName(chip4)
getOrient(chip4)
getBbx(getBbx(chip4))
getWidth(getBbx(chip4))
getHeight(getBbx(chip4))
getOrigin(getBbx(chip4))

getName(chip4->numpad)
getBbx(getBbx(chip4->numpad))
getWidth(getBbx(chip4->numpad))
getHeight(getBbx(chip4->numpad))

chip5 = getItem(ret->chips 5)
getName(chip5)
getOrient(chip5)
getBbx(getBbx(chip5))
getWidth(getBbx(chip5))
getHeight(getBbx(chip5))
getOrigin(getBbx(chip5))

getName(chip5->numpad)
getBbx(getBbx(chip5->numpad))
getWidth(getBbx(chip5->numpad))
getHeight(getBbx(chip5->numpad))

chip6 = getItem(ret->chips 6)
getName(chip6)
getOrient(chip6)
getBbx(getBbx(chip6))
getWidth(getBbx(chip6))
getHeight(getBbx(chip6))

getName(chip6->numpad)
getOrigin(getBbx(chip6))
getBbx(getBbx(chip6->numpad))
getWidth(getBbx(chip6->numpad))
getHeight(getBbx(chip6->numpad))

chip7 = getItem(ret->chips 7)
getName(chip7)
getOrient(chip7)
getBbx(getBbx(chip7))
getWidth(getBbx(chip7))
getHeight(getBbx(chip7))
getOrigin(getBbx(chip7))

getName(chip7->numpad)
getBbx(getBbx(chip5->numpad))
getWidth(getBbx(chip5->numpad))
getHeight(getBbx(chip5->numpad))

;######

getName(chip0)
getOrigin(getBbx(chip0))
getName(chip0->numpad)
getOrigin(getBbx(chip0->numpad))

getName(chip1)
getOrigin(getBbx(chip1))
getName(chip1->numpad)
getOrigin(getBbx(chip1->numpad))

getName(chip2)
getOrigin(getBbx(chip2))
getName(chip2->numpad)
getOrigin(getBbx(chip2->numpad))

getName(chip3)
getOrigin(getBbx(chip3))
getName(chip3->numpad)
getOrigin(getBbx(chip3->numpad))

getName(chip4)
getOrigin(getBbx(chip4))
getName(chip4->numpad)
getOrigin(getBbx(chip4->numpad))

getName(chip5)
getOrigin(getBbx(chip5))
getName(chip5->numpad)
getOrigin(getBbx(chip5->numpad))

getName(chip6)
getOrigin(getBbx(chip6))
getName(chip6->numpad)
getOrigin(getBbx(chip6->numpad))

getName(chip7)
getOrigin(getBbx(chip7))
getName(chip7->numpad)
getOrigin(getBbx(chip7->numpad))
getbBox(ret)
getDim(ret)

;;;;;;;;
; Step 5.
;;;;;;;;
checkInnerStreets(ret)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Raster an sequence of primary 
;       reticles in a cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getLib(ret)
getName(ret)
getView(ret)
setOrigin(ret list(0.0 0.0))
name = "raster"
cvm = dbOpenCellViewByType(getLib(ret) name getView(ret) "maskLayout" "w")
cv = makeInstance( 'cv )
setRef(cv cvm)
i=0
j=0
orient = "R0"
dx = getWidth(ret)-getOverlap(ret)
dy = getHeight(ret)-getOverlap(ret)
rx = 0.0
ry = 9.9
orig = list(rx ry)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
;Second reticle
i=1
j=0
rx = rx + dx
ry = 0.0
orig =list(rx ry)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
;Third reticle
i=2
j=0
rx = rx + dx
ry = 0.0
orig =list(rx ry)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
dbSave(cvm)
dbClose(cvm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Raster a 3x3 array of primary 
;       reticles in a cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getLib(ret)
getName(ret)
getView(ret)
setOrigin(ret list(0.0 0.0))
name = "raster2d"
cvm = dbOpenCellViewByType(getLib(ret) name getView(ret) "maskLayout" "w")
cv = makeInstance( 'cv )
setRef(cv cvm)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

rows = 3
cols = 3
orient = "R0"
rx = 0.0
ry = 0.0
orig = list(rx ry)
dx = getWidth(ret)-getOverlap(ret)
dy = getHeight(ret)-getOverlap(ret)
for(i 0 rows-1
    ry = i*dy
  for(j 0 cols-1
      rx = j*dx
      orig = list(rx ry)
      createInstance2(cv getRef(ret) sprintf( nil "r%d%d" i j) orig orient)
  );for
);for

dbSave(cvm)
dbClose(cvm)
dbClose(cvm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Create Numbers at the pad
;       locations in the reticle
;       array created in UT-6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1.) Create cell view with a GRID layer representing the bbox of the reticle
; 2.) Add the inclusion ring on the text layer of the cell view in step 1.)
; 3.) Perform an TBD "overlaps" on the two layers
; 4.) If the reticle layer is NOT inside mark that reticle site as partial
; 5.) Repeat steps 1-4 for the entire reticle array
; 6.) Save the number of non-partial (full) reticles
; 7.) Delete the inclusion ring layer from the cell view
;
; Repeat steps 2-7 stepping x and y by S&R intervals
; Choose x and y offsets that maximize the number of full reticles
; Use TBD "enclosed" method to check if a chip is a partial or full
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Step 1. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create reticle bbox shape
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name = "pd0164_0p_shifturq"
view = "layout"
cvr = dbOpenCellViewByType(lib name view "maskLayout" "r")  
ret = makeInstance( 'reticle )
setRef(ret cvr)
getbBox(ret)
bbv = bb2vert(ret->bbx)
shp = makeInstance( 'shape )
setLayer(shp "GRID")
setPurpose(shp "drawing")
setVertices(shp->transform bbv) 
dbClose(cvr)
lay = makeInstance( 'techLayer )
layName = "GRID"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getName(lay)
getLayer(shp)
addShape(lay shp)
name="retBBox"
lib="pd0164"
view = "layout"
cvrc = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(lay cvrc)
renderShapesOnLayer(lay)
dbSave(cvrc)
dbClose(cvrc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Step 2. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Add the inclusion ring layer to the retBBox cellview positioned
; in the URQ of the cell view
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Capture the layer shapes in a cellview
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
name="Wafer_4"
lib="reticle"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout")
lay = makeInstance( 'techLayer )
setRef(lay cv)
layName = "resistor"
layPurp = "drawing"
setName(lay layName)
setPurpose(lay layPurp)
getShapesOnLayer(lay)
shapes = lay->shapes->list->elems
dbClose(cv)
geom = makeInstance( 'geometry )
num=length(shapes)
for(i 0 num-1
  temp = makeInstance( 'transform2 )
  setVertices(temp getItem(getShapes(lay) i)->vertices)
  
  shiftURQ(temp->rtran) 
  addTransform(geom temp)
)
; Shift transform to URQ
shiftURQ(

; Open a cv for write and rendor the target layer
name="inclusionRing"
lib="pd0164"
view = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "w")
setRef(geom cv)
render(geom)
dbSave(cv)
dbClose(cv)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Checking for pad names in library
;       FIXME: This should be part of initial reticle checks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name = getPadChipName(ret)
view = "layout"
cvchippad = dbOpenCellViewByType( lib name view "maskLayout" "r")
if(!null(cvchippad) then
    printf("INFO: XYN CHIP PAD FOUND IN RETICLE LIBRARY!: %s\n" cvchippad~>cellName)
  else
    printf("WARNING: XYN CHIP PAD NOT FOUND IN RETICLE LIBRARY!: %s\n" name)
);if
dbClose(cvchippad)

name = getPadCouponName(ret)
cvcouppad = dbOpenCellViewByType( lib name view "maskLayout" "r")
if(!null(cvchippad) then
    printf("INFO: XYN COUPON PAD FOUND IN RETICLE LIBRARY!: %s\n" cvcouppad~>cellName)
  else
    printf("WARNING: XYN COUPON PAD NOT FOUND IN RETICLE LIBRARY!: %s\n" name)
);if
dbClose(cvcouppad)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-11: Print out the reticle heirarchy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name = getName(ret)
view = "layout"
cvr = dbOpenCellViewByType( lib name view "maskLayout" "r")
; look through them manually
length(cvr~>instHeaders)
nth(0 cvr~>instHeaders)~>cellName
nth(1 cvr~>instHeaders)~>cellName
nth(2 cvr~>instHeaders)~>cellName
nth(3 cvr~>instHeaders)~>cellName
nth(4 cvr~>instHeaders)~>cellName
nth(5 cvr~>instHeaders)~>cellName
nth(6 cvr~>instHeaders)~>cellName
nth(7 cvr~>instHeaders)~>cellName
nth(8 cvr~>instHeaders)~>cellName
nth(9 cvr~>instHeaders)~>cellName
nth(10 cvr~>instHeaders)~>cellName


nth(0 cvr~>instances)~>cellName
nth(1 cvr~>instances)~>cellName
nth(2 cvr~>instances)~>cellName
nth(3 cvr~>instances)~>cellName
nth(4 cvr~>instances)~>cellName
nth(5 cvr~>instances)~>cellName
nth(6 cvr~>instances)~>cellName
nth(7 cvr~>instances)~>cellName
nth(8 cvr~>instances)~>cellName
nth(9 cvr~>instances)~>cellName
nth(10 cvr~>instances)~>cellName

; Drilling down into the "CHIP0HP" instance to find the XYN PAD NAME
nth(10 cvr~>instHeaders)~>?  
nth(10 cvr~>instHeaders)~>instances
nth(0 nth(10 cvr~>instHeaders)~>instances)~>cellName
nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader
nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader~>master
nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader~>master~>?
nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader~>master~>instances

nth(0 nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader~>master~>instances)~>cellName
; ERROR BAD XYN NAME
nth(1 nth(0 nth(10 cvr~>instHeaders)~>instances)~>instHeader~>master~>instances)~>cellName


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-12: Print out the reticle heirarchy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
getbBox(ret)
bbv = bb2vert(ret->bbx)
;;;;;;;;;;;;;;;;;;;;;;;;;;;
retcp = makeInstance( 'reticle )
clone(ret retcp)
getbBox(retcp)
bbv = bb2vert(retcp->bbx)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-13: Clone a reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name = "pd0164"
view = "layout"
type = "maskLayout"
cv = dbOpenCellViewByType( lib name view type "r")
ret = makeInstance( 'reticle )
setName(ret name)
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
getName(ret)
; Clone object
retcp = makeInstance( 'reticle )
cloneRet(ret retcp)
getName(retcp)
getRef(retcp)



