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
# Scripts Directory
#########################################################################
sdir = "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/scripts/"
#########################################################################
#########################################################################
#  Package File Names
#########################################################################
skillDevPackage = cadObj coord2  point2 points2 polygon2 rectTran \
                  transform2 transformation2 geometry assembly
#########################################################################
assemblyLibraryPackage = rectangle triangle circle    \
                         trirect capsule gatePad gateStem 
#########################################################################
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

allPackages: skilldev assembly

.phony: skilldev
skilldev:
	touch $(sdir)/packages/$(packName).ils
	rm  $(sdir)/packages/$(packName).ils
	touch $(sdir)/packages/$(packName).ils
	$(foreach var, $(skillDevPackage), cat $(sdir)/skilldev/$(var)/$(var).ils >>  $(sdir)/packages/$(packName).ils;)

.phony: assembly
assembly:
	$(foreach var, $(assemblyLibraryPackage), cat $(sdir)/assemblyLibrary/$(var)/$(var).ils >>  $(sdir)/packages/$(packName).ils;)

.phony: nograph
nograph:
	virtuoso -nograph -restore $(sdir)/packages/$(packName).ils 

.phony: nographE
nographE:
	virtuoso -nographE -restore $(sdir)/$(filename) 

.phony: nographRestore
nographRestore:
	virtuoso -nograph -restore $(rdir)/$(filename) 

.phony: run
run:
	virtuoso -restore $(sdir)/$(filename)

.phony: clean
clean:
	touch foo.err
	rm fail.lst

.phony: help
help:
	virtuoso -h