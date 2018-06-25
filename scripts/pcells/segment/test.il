;#############################################
;# UT-0: Analyzing the new pcell 
;#############################################
cell = makeInstance( 'layCell )
cell->library = "pa0715"
cell->cellName = "segment"
cell->viewName = "layout"

getbBox(cell)
getDim(cell)
cell->bbwidth
cell->bbheight
getAttrList(cell)
getAttrValueByKey(cell "isParamCell")
props = getAttrValueByKey(cell "prop")
prop0 = nth(0 props)
prop0->??
prop1 = nth(1 props)
prop1->??
pr=prop1->prop
pr0=nth(0 pr)
pr0->??

getAttrValueByKey(cell "cellView")
getAttrValueByKey(cell "objType")
getAttrValueByKey(cell "lib")
getAttrValueByKey(cell "libName")
getAttrValueByKey(cell "cellName")
getAttrValueByKey(cell "cell")
getAttrValueByKey(cell "cellViewType")
getAttrValueByKey(cell "cellType")

getAttrValueByKey(cell "")


;nil group
getAttrValueByKey(cell "instHeaders")
getAttrValueByKey(cell "instHeaderRefs")
getAttrValueByKey(cell "instanceMasters")
getAttrValueByKey(cell "subMasters")
getAttrValueByKey(cell "superMasters")
getAttrValueByKey(cell "conns")
getAttrValueByKey(cell "groupMembers")
getAttrValueByKey(cell "groups")