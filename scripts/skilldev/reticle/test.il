;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'reticle )
ret = makeInstance( 'reticle )
classp( ret 'reticle)
classOf(ret)
superclassesOf(classOf(ret))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Primary Reticle Resolution Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p"
view  = "layout"
cv = dbOpenCellViewByType( lib name view "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
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
; UT-5: Initial Processing of a 
;       Reticle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 1.) Reticle Dimension Checks
; Step 2.) Copy primary reticle into "_shifturq" cell view
; Step 3.) Shift Reticle to URQ 
; Step 4.) Identify Chips and Coupons via Number Pads
; Step 5.) Locate Intra Reticle Chip and Coupon Origins
; Step 6.) Create a list of Chip, Coupon and their respective pad origins
; Step 7.) Print out a Reticle Chip and Coupon List 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 1.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p"
view  = "layout"
cvr = dbOpenCellViewByType( lib name view "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cvr)
setRes(ret 10.0)
setMaxDim(ret 20000.0)
setOverlap(ret 4.0)
setSrGrid(ret 0.1)
checkDim(ret)
checkRes(ret)
checkGrid(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 2.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cell = makeInstance( 'cv )
setRef(cell cvr)
setName(cell name)
setLib(cell lib)
setView(cell view)
copyName = strcat(getName(cell) "_shifturq")
Copy(cell copyName)
;dbClose(cvr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 3.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
view = "layout"
cvc = dbOpenCellViewByType( lib copyName view "maskLayout" "r")
bb = makeInstance( 'bbox )
setRef(bb cvc)
retShift = shiftURQ(bb)
dbClose(cvc)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Step 4.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib = "pd0164"
name  = "pd0164_0p"
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
;setShiftUrq(ret retShift)
setPadChipName(ret "pd0164_0_xyPad_SLA")
setPadCouponName(ret "pd0164_0_xyPad_SLB")
findXynPads(ret)
getChipList(ret)
getCouponList(ret)
isEmpty(ret->chips)
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

;#################################################

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Raster an array of primary 
;       reticles in a cellview 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getLib(ret)
getName(ret)
getView(ret)
setOrigin(ret list(0.0 0.0))
name = "wafer"
cvm = dbOpenCellViewByType(getLib(ret) name getView(ret) "maskLayout" "w")
cv = makeInstance( 'cv )
setRef(cv cvm)
i=0
j=0
orient = "R0"
orig = getOrigin(ret)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
;Second reticle
i=1
j=0
orient = "R0"
rx = xCoord(orig) + 18000.0
ry = yCoord(orig)
orig =list(rx ry)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
;Third reticle
i=2
j=0
rx = xCoord(orig) + 18000.0
ry = yCoord(orig)
orig =list(rx ry)
createInstance2(cv getRef(ret) sprintf( nil "reticle_%d_%d" i j) orig orient)
dbSave(cvm)
dbClose(cvm)

