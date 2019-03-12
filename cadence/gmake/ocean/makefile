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
# Ocean Script Directory
#########################################################################
dir = "/users/1127110/cad/cadence/ocean/"
#########################################################################
# Ocean Script
#########################################################################
filename = "basic.ocn"
#########################################################################
# Sample Script Directory
#########################################################################
sdir = "/net/nfs-n501/ANFS01/apps/cadence/IC617/tools.lnx86/dfII/samples/artist/OCEAN/"
#########################################################################
# Object Names
#########################################################################
.phony: ocn
ocn:
	ocean -nograph -replay $(dir)/$(filename) -log  $(dir)/$(filename).log

.phony: lint
lint:
	sklint -file $(dir)/$(filename)

.phony: ui
ui:
	ocean -replay $(sdir)/helpful/helpfulUI.ocn 