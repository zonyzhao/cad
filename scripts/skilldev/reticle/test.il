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
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
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
ret->srRes = 10
ret->maxDim = 20000
checkDim(ret)
checkRes(ret)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Secondary Reticle Resolution Testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib   = "pd0164"
name  = "pd0164_0p"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
ret = makeInstance( 'reticle )
setRef(ret cv)
setRes(ret 10)
setMaxDim(ret 20000)
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
ret->srRes = 10
ret->maxDim = 20000
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
checkDim(retp)
checkRes(retp)
; SECONDARY
name  = "pd0164_0s"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout" "r")
rets = makeInstance( 'reticle )
setRef(rets cv)
setRes(rets 10)
setMaxDim(rets 20000)
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