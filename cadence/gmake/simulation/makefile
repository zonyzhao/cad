##########################################################################
# Makefile runs virtuoso in nograph mode for testing skill scripts
#########################################################################
# The following environmental variables need to be set in order to 
# run ivVerify in the Raytheon enviroment
#########################################################################
export setenv TERM "konsole"
export setenv CDS_CMI_COMPLEVEL 0
export setenv QRC_ENABLE_EXTRACTION t



export REFLIBDIR=/nfs/layout/reflibs
export PROCLIBDIR=/nfs/layout/procLib
export CDS_AUTO_64BIT=ALL
export CDS_LOAD_ENV=CWD
export CDS_LIC_FILE=5280@eand-idslnxlic01.and.us.ray.com:5280@esud-lnxlic01.sud.us.ray.com:5280@epts-lnxlic01.pts.us.ray.com:27338@cadence-license01-gbs.app.ray.com
export CDS_HOME=/apps/cadence/IC617
export INSTALLDIR=/apps/cadence/IC616
export PATH :=/apps/python/python27/bin:/apps/cadence/IC616/tools/bin:/apps/cadence/IC616/tools/dfII/bin:${PATH}
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
oname2 = "container"
oname3 = "techfile"
oname4 = "library"
oname5 = "lib"
oname6 = "layCell"
oname7 = "cell2png"
oname8 = "reticle"
# FIXME - need shape package
oname9  = "point2"
oname10 = "rotation2"
oname11 = "vertex2"
oname12 = "polygon2"
oname13 = "transform2"
oname14 = "shape"
# FIXME: - need geometry package
oname15 = "geometry"
oname16 = "geom"
oname17 = "circle"
oname18 = "rectangle"
oname19 = "triangle"
oname20 = "capsule"
oname21 = "trirect"
# FIXME: - need CDF package
oname22 = "cdfParam"
oname23 = "cdfSimOpt"
oname24 = "cdf"
# FIXME: - need Pcell Package
oname25 = "generic"
oname26 = "PcellParam"
oname27 = "CORE"
oname28 = "RING"
oname29 = "WRAP"
oname30 = "pcell"
oname31 = "mesaResistor"
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