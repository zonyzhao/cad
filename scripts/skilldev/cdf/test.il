;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for class existence
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'cdf )
cmp = makeInstance( 'cdf )
classp(cmp 'cdf)
classOf(cmp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Dump a target CDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp = makeInstance( 'cdf )
setLib(cmp "analogLib")
setFile(cmp "./res.cdf")
setCell(cmp "res")
writeCdf(cmp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Add a child parameter to the 
;       container list, populated the
;       child parameter object and 
;       read it back. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp = makeInstance( 'cdf )
setParams(cmp list("wid" "len"))
genParamObjList(cmp)
cmp->paramObjList
nth(0 cmp->paramObjList)->name
nth(1 cmp->paramObjList)->name

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Populate the len and wid
;       parameter objects 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp = makeInstance( 'cdf )
setLib(cmp "P80B_components")
setCell(cmp "res_mesa")
setFile(cmp "./res_mesa")
setParams(cmp list("wid" "len" "mesaresval"))
genParamObjList(cmp)
cmp->paramObjList
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
param0=nth(0 cmp->paramObjList)
param0->type="float"
param0->storeDefault="no"
param0->prompt="wid"
param0->defValue=1.0
param0->display="artParameterInToolDisplay('w)"
param0->editable->""
param0->callback="res_mesa_CB( )"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
param1=nth(1 cmp->paramObjList)
param1->type="float"
param1->storeDefault="no"
param1->prompt="len"
param1->defValue=1.0
param1->display="artParameterInToolDisplay('l)"
param1->editable->""
param1->callback="res_mesa_CB( )"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
param2=nth(2 cmp->paramObjList)
param2->type="float"
param2->storeDefault="no"
param2->prompt=""
param2->defValue=10.0
param2->display=""
param2->editable->""
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Spot Read them back
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(0 cmp->paramObjList)->name
nth(0 cmp->paramObjList)->type
nth(0 cmp->paramObjList)->callback
nth(1 cmp->paramObjList)->name
nth(1 cmp->paramObjList)->type
nth(1 cmp->paramObjList)->callback
nth(2 cmp->paramObjList)->name
nth(2 cmp->paramObjList)->type
nth(2 cmp->paramObjList)->callback


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Populate the len and wid
;       parameter objects using
;       string params and create
;       a new CDF save it 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp = makeInstance( 'cdf )
setLib(cmp "P80B_components")
setCell(cmp "res")
setFile(cmp "./res_orig.cdf")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Dump the existing CDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dmpCdf(cmp)
setFile(cmp "./res.cdf")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create A New CDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getCdf(cmp)
deleteCdf(cmp)
;;;dmpCdf(cmp)
newCdf(cmp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Set Up CDF Parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setParams(cmp list("w" "l"))
genParamObjList(cmp)
cmp->paramObjList
cmp->cdfDataId
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(0 cmp->paramObjList)->name
param0=nth(0 cmp->paramObjList)
param0->type="string"
param0->parseAsNumber="yes"
param0->units="lengthMetric"
param0->parseAsCell="yes"
param0->storeDefault="no"
param0->prompt="width"
param0->defValue="10u"
param0->display="artParameterInToolDisplay('w)"
param0->editable="cdfgData->maskLayoutViewName->..."
param0->callback="res_mesa_CB( )"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(1 cmp->paramObjList)->name
param1=nth(1 cmp->paramObjList)
param1->type="string"
param1->parseAsNumber="yes"
param1->units="lengthMetric"
param1->parseAsCell="yes"
param1->storeDefault="no"
param1->prompt="length"
param1->defValue="10u"
param1->display="artParameterInToolDisplay('l)"
param1->editable="cdfgData->maskLayoutViewName->..."
param1->callback="res_mesa_CB( )"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Spot Read them back
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nth(0 cmp->paramObjList)->name
nth(0 cmp->paramObjList)->type
nth(0 cmp->paramObjList)->cdfDataId
nth(0 cmp->paramObjList)->callback
nth(1 cmp->paramObjList)->name
nth(1 cmp->paramObjList)->type
nth(1 cmp->paramObjList)->cdfDataId
nth(1 cmp->paramObjList)->callback
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Create All the CDF Parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
createCdfParams(cmp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Save the new CDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
saveCdf(cmp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Dump the new CDF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dmpCdf(cmp)

;#############################################
; Experimental Code
;#############################################
libName="analogLib"
fileName="./res.cdf"
cellName="res"
level='base

cdfDump(libName)
cdfDump(libName fileName ?cellName cellName ?level level ?edit nil)

; When using CDF callbacks, always use the global variable "cdfgData" to
; access information about parameter values and default values
cdfgData->paramName->defValue
cdfgData->paramName->value
;
; Also use the "cdfgData" to set and reset the parameter values
;
cdfgData->paramName->value = 10
cdfgData->paramName->value = cdfgData->paramName->defValue


FUNCTION cdfGetInstCDf(hnlCurrentInst)->myPrefix->value


