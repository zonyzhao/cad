##########################################################################
# Makefile runs virtuoso in nograph mode for testing skill scripts
#########################################################################
# The following environmental variables need to be set in order to 
# run ivVerify in the Raytheon enviroment
#########################################################################
export SONNET_DIR=/apps/sonnet/sonnet14
export REFLIBDIR=/nfs/layout/reflibs
export PROCLIBDIR=/nfs/layout/procLib
export CDS_AUTO_64BIT=ALL
export CDS_LOAD_ENV=CWD
export CDS_LIC_FILE=5280@eand-idslnxlic01.and.us.ray.com:5280@esud-lnxlic01.sud.us.ray.com:5280@epts-lnxlic01.pts.us.ray.com:27338@cadence-license01-gbs.app.ray.com
export CDS_HOME=/apps/cadence/IC617
export INSTALLDIR=/apps/cadence/IC616
export PATH :=/apps/python/python27/bin:/apps/cadence/IC616/tools/bin:/apps/cadence/IC616/tools/dfII/bin:/apps/sonnet/sonnet14/bin${PATH}
#########################################################################
# Main Directory
#########################################################################
dir = "/users/1127110/project/skill++/"
#########################################################################
# Restore Directory
#########################################################################
rdir = ""
#########################################################################
# Specific file to restore
#########################################################################
filename = ""
#########################################################################
# Object Names
#########################################################################
oname0 = "cadObj"
oname1 = "listfun"
oname2 = "collection"
oname3 = "container"
oname4 = "techfile"
oname5 = "library"
oname6 = "lib"
oname7 = "cv"
oname8 = "instance"
oname9 = "cell2png"
oname10 = "reticle"
# FIXME - need shape package
oname11 = "coord2"
oname12 = "point2"
oname13 = "points2"
oname14 = "transformation2"
oname15 = "line2"
oname16 = "vector2"
oname17 = "rotation2"
oname18 = "vertex2"
oname19 = "lineSegment2"
oname20 = "edge2"
oname21 = "polygon2"
oname22 = "geometry"
oname23 = "transform2"
oname24 = "rectTran"
oname25 = "rectTrans"
oname26 = "shape"
oname27 = "layer"
oname28 = "stackup"
oname29 = "assembly"
oname30 = "component"
oname31 = "bbox"
# FIXME: - need geometry package
#oname29 = "geom"
oname32 = "circle"
oname33 = "rectangle"
oname34 = "triangle"
oname35 = "capsule"
oname36 = "trirect"
oname37 = "numeric"
# FIXME: - need CDF package
oname38 = "cdfParam"
oname39 = "cdfSimOpt"
oname40 = "cdf"
# FIXME: - need Pcell Package
oname41 = "generic"
oname42 = "PcellParam"
oname43 = "CORE"
oname44 = "RING"
oname45 = "WRAP"
oname46 = "pcell"
oname47 = "mesaResistor"
# FIXME: Need a IPC package
oname48 = "ipc"
oname49 = "system"
oname50 = "graphical"
# FIXME: Need a FET assemblies package
oname51 = "gatePad"
oname52 = "gateStem"
oname53 = "gate"
oname54 = "pcgate"
#########################################################################
# Class Name
#########################################################################
packName = "standard"
#########################################################################

.phony: paths
paths:
	@echo REFLIBDIR is $$REFLIBDIR 
	@echo PROCLIBDIR is $$PROCLIBDIR
	@echo CDS_HOME is $$CDS_HOME
	@echo PATH is $$PATH
	@echo CDS_LIC_FILE is $$CDS_LIC_FILE

.phony: nograph
nograph:
	cat $(dir)/$(oname0)/trunk/$(oname0).ils >  $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname1)/trunk/$(oname1).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname2)/trunk/$(oname2).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname3)/trunk/$(oname3).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname4)/trunk/$(oname4).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname5)/trunk/$(oname5).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname6)/trunk/$(oname6).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname7)/trunk/$(oname7).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname8)/trunk/$(oname8).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname9)/trunk/$(oname9).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname10)/trunk/$(oname10).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname11)/trunk/$(oname11).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname12)/trunk/$(oname12).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname13)/trunk/$(oname13).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname14)/trunk/$(oname14).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname15)/trunk/$(oname15).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname16)/trunk/$(oname16).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname17)/trunk/$(oname17).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname18)/trunk/$(oname18).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname19)/trunk/$(oname19).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname20)/trunk/$(oname20).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname21)/trunk/$(oname21).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname22)/trunk/$(oname22).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname23)/trunk/$(oname23).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname24)/trunk/$(oname24).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname25)/trunk/$(oname25).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname26)/trunk/$(oname26).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname27)/trunk/$(oname27).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname28)/trunk/$(oname28).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname29)/trunk/$(oname29).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname30)/trunk/$(oname30).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname31)/trunk/$(oname31).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname32)/trunk/$(oname32).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname33)/trunk/$(oname33).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname34)/trunk/$(oname34).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname35)/trunk/$(oname35).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname36)/trunk/$(oname36).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname37)/trunk/$(oname37).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname38)/trunk/$(oname38).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname39)/trunk/$(oname39).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname40)/trunk/$(oname40).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname41)/trunk/$(oname41).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname42)/trunk/$(oname42).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname43)/trunk/$(oname43).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname44)/trunk/$(oname44).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname45)/trunk/$(oname45).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname46)/trunk/$(oname46).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname47)/trunk/$(oname47).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname48)/trunk/$(oname48).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname49)/trunk/$(oname49).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname50)/trunk/$(oname50).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname51)/trunk/$(oname51).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname52)/trunk/$(oname52).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname53)/trunk/$(oname53).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	cat $(dir)/$(oname54)/trunk/$(oname54).ils >> $(dir)/packages/$(packName)/trunk/$(packName).ils
	virtuoso -nograph -restore $(dir)/packages/$(packName)/trunk/$(packName).ils 

.phony: nographE
nographE:
	virtuoso -nographE -restore $(dir)/$(filename) 

.phony: nographRestore
nographRestore:
	virtuoso -nograph -restore $(rdir)/$(filename) 

.phony: run
run:
	virtuoso -restore $(dir)/$(filename)

.phony: clean
clean:
	touch foo.err
	rm fail.lst

.phony: help
help:
	virtuoso -h