;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Check for object Existence
;       and construction
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'listfun )
lis = makeInstance( 'listfun )
classp( lis 'listfun)
classOf(lis)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: Test getting head of a list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(0 1 2 3 4 5 6 7 8 9)
n=4
lis = makeInstance( 'listfun )
setElems(lis a)
head(lis n)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: Test getting tail of a list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(0 1 2 3 4 5 6 7 8 9)
n=4
lis = makeInstance( 'listfun )
setElems(lis a)
tail(lis n)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Test list element replacement
;       using a integer elements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lis = makeInstance( 'listfun )
a=list(1 2 3 4 5 6 7 8 9)
setElems(lis a)
n=6
val=10
replace(lis ?ind n ?val val)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-4: Test list element replacement
;       using a vertex elements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(list(0.0 0.0) list(0.0 100.0) list(100.0 100.0) list(100.0 0.0))
n=1
val=list(100.0 100.0)
lis = makeInstance( 'listfun )
setElems(lis a)
replace(lis ?ind n ?val val)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-5: Test index out of range
;       guard rail
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(list(0.0 0.0) list(0.0 100.0) list(100.0 100.0) list(100.0 0.0))
n=4
val=list(100.0 100.0)
lis = makeInstance( 'listfun )
setElems(lis a)
replace(lis ?ind n ?val val)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-6: Get the list length
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(list(0.0 0.0) list(0.0 100.0) list(100.0 100.0) list(100.0 0.0))
lis = makeInstance( 'listfun )
setElems(lis a)
getLen(lis)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-7: Test list element insertion
;       using integer elements
;	Inserts after the zero indexed
;       value
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a='(0 1 2 3 4 5 6 7 8 9)
n=4
val=10
lis = makeInstance( 'listfun )
setElems(lis a)
insert(lis ?ind n ?val val)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-8: Test list element insertion
;       using a vertex elements
;       Inserts after the zero indexed
;       value
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
a=list(list(0.0 0.0) list(0.0 100.0) list(100.0 100.0) list(100.0 0.0))
n=1
val=list(100.0 100.0)
lis = makeInstance( 'listfun )
setElems(lis a)
insert(lis ?ind n ?val val)
lis->elems
lis->len

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-9: Test recursive list 
;       flattening
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00_bias2"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
layers = getLayers(cell)
list = makeInstance( 'listfun )
setElems(list layers)
getElems(list)
flattenRecursive(list)
;Direct call to recursive method
;flattenRecurseList(list ?hlist layers ?flist '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-10: Test recursive list 
;       flattening (second case)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="XYnumbers"
name="asml_1_cd_cross_1X_A"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
layers = getLayers(cell)
list = makeInstance( 'listfun )
setElems(list layers)
getElems(list)
flattenRecursive(list)
;Direct call to recursive method
;flattenRecurseList(list ?hlist layers ?flist '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-11: Test list redundancy  
;       removal
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lib="pa0715"
name="pa715_0p_chip_00_bias2"
cv = dbOpenCellViewByType( lib name "layout" "maskLayout")
cell = makeInstance( 'cv )
setRef(cell cv)
setView(cell "layout")
setName(cell name)
setLib(cell lib)
layers = getLayers(cell)
list = makeInstance( 'listfun )
setElems(list layers)
getElems(list)
flist = flattenRecursive(list)
removeRedundant(list)
;Direct call to recursive method
removeRedundantItems(list ?elist flist ?rlist '())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-12: Test adding and removing
;        object references from a 
;        list 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
list = makeInstance( 'listfun )
items = list( makeInstance('shape) makeInstance('shape) makeInstance('shape) )  
setElems(list items)
getElems(list)
remItem = nth(1 items)
removeElem(list remItem)


;#########################################
;#########################################
; Experimental Code
;#########################################
;#########################################
list='("PLL80BTech" "PLL80Tech" "PLL_80" "PLL_80A" "PLL_80B"
    "PLL_80B_PCELLS" "XYnumbers" "am0105" "fooTech" "p80b_wafer_map"
    "pa0715" "test" "xynumTech"
)
len=sub1(length(list))
ind = 5
val = "ASML"
tmp0='()
for( i 1 ind+1
     tmp0 = cons(popf(list) tmp0)
);for
tmp0=reverse(tmp0)


tmp0=reverse(cons(val tmp0))

tmp1=rplaca(nthcdr(ind list) val)
tmp0='()
for( i 1 ind
     tmp0 = cons(popf(list) tmp0)
);for
tmp0=reverse(tmp0)
list->elems = append(tmp0 tmp1)

list='(0 1 2 3 4 5 6 7 8 9 10)