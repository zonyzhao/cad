##########################################################################
# Makefile runs virtuoso regression testing of skill scripts
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
#
#########################################################################
class = "point2"
#########################################################################
#  Package Name
#########################################################################
package = skilldev
#########################################################################
#  Scripts Directory
#########################################################################
sdir = "/users/1127110/cad/scripts/"
#########################################################################
# Class Directory
#########################################################################
cdir = $(sdir)/$(package)/$(class)
#########################################################################
# test Directory
#########################################################################
testdir = $(cdir)/regression
#########################################################################
tests = ut0 
#########################################################################
header = "header.il"
footer = "footer.il"
########################################################################
dependencies = cadObj coord2
########################################################################
.phony: paths
paths:
	@echo REFLIBDIR is $$REFLIBDIR 
	@echo PROCLIBDIR is $$PROCLIBDIR
	@echo CDS_HOME is $$CDS_HOME
	@echo PATH is $$PATH
	@echo CDS_LIC_FILE is $$CDS_LIC_FILE

devTest: test check

.phony: dry
dry:
	touch $(testdir)/test.il
	rm  $(testdir)/test.il
	touch $(testdir)/test.il
	cat $(header) >> $(testdir)/test.il
	$(foreach var, $(tests), cat $(testdir)/$(var).il >>  $(testdir)/test.il;)
	cat $(footer) >>  $(testdir)/test.il
	$(foreach var, $(dependencies), cat $(sdir)/$(package)/$(var)/$(var).ils >>  $(testdir)/dependencies.ils;)
	cat $(cdir)/$(class).ils >>  $(testdir)/dependencies.ils

.phony: test
test:
	touch $(testdir)/test.il
	rm  $(testdir)/test.il
	touch $(testdir)/test.il
	cat $(header) >> $(testdir)/test.il
	$(foreach var, $(tests), cat $(testdir)/$(var).il >>  $(testdir)/test.il;)
	cat $(footer) >>  $(testdir)/test.il
	$(foreach var, $(dependencies), cat $(sdir)/$(package)/$(var)/$(var).ils >>  $(testdir)/dependencies.ils;)
	cat $(cdir)/$(class).ils >>  $(testdir)/dependencies.ils
	virtuoso -nograph -restore $(testdir)/dependencies.ils -replay $(testdir)/test.il

.phony: check
check:
	$(foreach var, $(tests), diff $(testdir)/$(var).out $(testdir)/golden/$(var).out > $(testdir)/$(var).diff || echo \* $(class) class regression testing Failed! \*;) 

.phony: clean
clean:
	touch $(testdir)/foo.out
	touch $(testdir)/foo.diff
	cd $(testdir)
	rm *.out
	rm *.diff