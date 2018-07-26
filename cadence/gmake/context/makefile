##########################################################################
# Makefile runs cdbToOa converter from the command line
#########################################################################
# The following environmental variables need to be set in order to 
# run cadence command line tools (ex. ivVerify) in the Raytheon enviroment
#########################################################################
export HOME $home
export setenv ganLibVer "current"
export REFLIBDIR=/net/nfs-n501/LNFS01/MET/layout/reflibs
export PROCLIBDIR=/users/39540-cad/procLib
export CDS_AUTO_64BIT=ALL
export CDS_LOAD_ENV=CWD
export CDS_LIC_FILE=5280@eand-idslnxlic01.and.us.ray.com:5280@esud-lnxlic01.sud.us.ray.com:5280@epts-lnxlic01.pts.us.ray.com:27338@cadence-license01-gbs.app.ray.com
export CDS_HOME=/apps/cadence/IC616
export INSTALLDIR=/apps/cadence/IC616
export PATH :=/apps/python/python27/bin:/apps/cadence/IC616/tools/bin:/apps/cadence/IC616/tools/dfII/bin:${PATH}
#########################################################################
# Main Directories
#########################################################################
localDesDir = $(HOME)/"/deslibs_oa/"
localMemsDesDir = $(HOME)/"/deslibs_oa_mems/"
localCadDir = $(HOME)/"/cad_layout_61/"
cadenceDefault = "/net/nfs-n501/ANFS01/apps/cadence/IC616/share/cdssetup/"
avTech = "/apps/assura/ASSURA616_04.14.101/tools/assura/etc/avtech/avTech"
defaultOaTechDir = "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa"
#########################################################################
# Individual Designs
#########################################################################
desName = "pd0164"
#########################################################################
testReticles = ln0246 ln0255 pa0715_sfw 
#########################################################################
# MEMS Lib Directory
#########################################################################
memsLibDir = "/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cdslib/"
#########################################################################
# MEMS LIBS
#########################################################################
memsLibs = D91 cpwStructures cpwSwitches highFreqChip \
           impedanceTuner mechStructures relStructures \
           uStripStructures xBandPhaseShifter cadTest
#########################################################################
# Mulitple design library names
#########################################################################
desNames = impedanceTuner highFreqChip cpwSwitches uStripStructures \
           cpwStructures mechStructures relStructures
#########################################################################
techfiles = RRFC_2metal D91
#########################################################################
# MPSS Test Cases
#########################################################################
# P46:  ln0267 
# P80C: sw0081, pa0739 
# P80B: pa0732,pa0735
# P85:  am0131,pa0733,am0131 
# P81:  pd0177,pa0737 
# P87:  pa0738,pa0740 
# P60:  tr0060,tr0061.tr0062(Multi-Image),sw0078
#########################################################################
mpssLibs =  am0131 tr0062 pa0735 ln0267 sw0081 pa0732 pa0733 \
            am0131 pa0737 pa0740 tr0062 tr0060 tr0061 sw0078 \
            pa0739 pd0177 pa0738
#########################################
# Display Environmental Paths
#########################################
.phony: paths
paths:
	@echo HOME is $$HOME
	@echo REFLIBDIR is $$REFLIBDIR 
	@echo PROCLIBDIR is $$PROCLIBDIR
	@echo CDS_HOME is $$CDS_HOME
	@echo PATH is $$PATH
	@echo CDS_LIC_FILE is $$CDS_LIC_FILE
	@echo ganLibVer is $$ganLibVer
	@echo cdsLib Location is $(cdbDrop)
	@echo oaLib Location is $(oaLibPath)

.phony: timestamp
timestamp:	
	date +"Now time is +%FT%T%z"

.phony: defaultTech
defaultTech:
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/cds.lib
	touch $(localCadDir)/cds.lib
	touch $(localCadDir)/.cdsenv
	touch $(localCadDir)/.cdsinit
	rm $(localCadDir)/.cdsenv
	rm $(localCadDir)/.cdsinit
	ln -s  /users/1127110/project/cadence/dotfiles/trunk/.cdsenv $(localCadDir)/.cdsenv
	ln -s  /users/1127110/project/cadence/dotfiles/trunk/.cdsinit $(localCadDir)/.cdsinit
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
	echo "INCLUDE " $(defaultOaTechDir)/cds.lib >> $(localCadDir)/cds.lib
	echo "INCLUDE " $(localDesDir)/cds.lib >> $(localCadDir)/cds.lib
	echo "DEFINE avTech " $(avTech) >> $(localCadDir)/cds.lib

.phony: defaultTechRevD
defaultTechRevD:
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/cds.lib
	touch $(localCadDir)/cds.lib
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
#	echo "INCLUDE " $(defaultOaTechDir)/cds.lib >> $(localCadDir)/cds.lib
	echo "DEFINE avTech " $(avTech) >> $(localCadDir)/cds.lib

.phony: divaDRC
divaDRC:
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/cds.lib
	touch $(localCadDir)/cds.lib
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
	echo "INCLUDE " $(defaultOaTechDir)/cds.lib >> $(localCadDir)/cds.lib
	echo "DEFINE p80a_drc_base_regression /scratch/oaConversion/oaConversion/designs/oaLibs/p80a_drc_base_regression" >> $(localCadDir)/cds.lib
	echo "DEFINE p80a_dev_base_regression /scratch/oaConversion/oaConversion/designs/oaLibs/p80a_drc_dev_regression" >> $(localCadDir)/cds.lib
	echo "DEFINE p80a_drc_sfw /scratch/oaConversion/oaConversion/designs/oaLibs/p80a_drc_sfw" >> $(localCadDir)/cds.lib

.phony: experimental
experimental:
	touch $(localCadDir_exp)/cds.lib
	rm $(localCadDir_exp)/cds.lib
	touch $(localCadDir_exp)/cds.lib
	touch $(localCadDir_exp)/.cdsenv
	touch $(localCadDir_exp)/.cdsinit
	rm $(localCadDir_exp)/.cdsenv
	rm $(localCadDir_exp)/.cdsinit
	ln -s /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/cadence/env/default/.cdsenv $(localCadDir_exp)/.cdsenv
	ln -s /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/cadence/env/default/.cdsinit $(localCadDir_exp)/.cdsinit
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
	echo "INCLUDE /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa2/cds.lib" >> $(localCadDir)/cds.lib
	echo "DEFINE avTech " $(avTech) >> $(localCadDir)/cds.lib
	/net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/cadence/startup

.phony: mpss
mpss:
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/cds.lib
	touch $(localCadDir)/cds.lib
	touch $(localCadDir)/.cdsenv
	touch $(localCadDir)/.cdsinit
	rm $(localCadDir)/.cdsenv
	rm $(localCadDir)/.cdsinit
	ln -s  /users/1127110/project/cadence/dotfiles/trunk/.cdsenv $(localCadDir)/.cdsenv
	ln -s  /users/1127110/project/cadence/dotfiles/trunk/.cdsinit $(localCadDir)/.cdsinit
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
#	echo "INCLUDE " $(defaultOaTechDir)/cds.lib >> $(localCadDir)/cds.lib
	echo "DEFINE avTech " $(avTech) >> $(localCadDir)/cds.lib

.phony: addTestReticles
addTestReticles:
	$(foreach var, $(testReticles), echo "DEFINE " $(var) " "$(localDesDir)/$(var) >> $(localCadDir)/cds.lib;)

.phony: mems
mems:
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/cds.lib
	touch $(localCadDir)/cds.lib
	rm $(localCadDir)/.cdsenv
	rm $(localCadDir)/.cdsinit
	ln -s /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/cadence/env/default/.cdsenv $(localCadDir)/.cdsenv
	ln -s /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa3/cad/cadence/env/default/.cdsinit $(localCadDir)/.cdsinit
	echo "INCLUDE " $(cadenceDefault)/cds.lib > $(localCadDir)/cds.lib
	echo "DEFINE avTech " $(avTech) >> $(localCadDir)/cds.lib
	echo "INCLUDE " $(localMemsDesDir)/cds.lib  >> $(localCadDir)/cds.lib
#	$(foreach var, $(memsLibs), echo "DEFINE " $(var) " "$(memsLibDir)/$(var) >> $(localCadDir)/cds.lib;)

#############################################################################################################################################
# Individual technology library and cellviews
# Make sure you set the techfile to the bridge in Cadence 5p1
#############################################################################################################################################
#######################################################
# Adding single library targets to the cds.lib file
#######################################################

.phony: single
single:
	echo "DEFINE " $(desName) " "$(cdbDesDrop)/$(desName) > $(cdbDesDrop)/cds.lib
	cdb2oa -lib $(desName) -cdslibpath $(cdbDesDrop) -oalibpath $(oaDesConv)/$(desName) -ignorelocks -abspath -report -log $(logFile)_$(desName)  

#######################################################
# Adding multiple library targets to the cds.lib file
#######################################################
multi:
	touch ./cds.lib
	rm ./cds.lib
	touch ./cds.lib
	$(foreach var, $(BRIDGES), echo $(var); ls $(oaLibPath)/$(var); echo "DEFINE " $(var) " "$(oaLibPath)/$(var) > ./cds.lib;)
	rm $(cdbDesDrop)/cds.lib
	touch  $(cdbDesDrop)/cds.lib
	$(foreach var, $(BRIDGES), echo $(var); ls $(cdbDrop)/$(var); echo "DEFINE " $(var) " "$(cdbDrop)/$(var) > $(cdbDesDrop)/cds.lib;)
	$(foreach var, $(desNames), echo "DEFINE " $(var) " "$(cdbDesDrop)/$(var) >> $(cdbDesDrop)/cds.lib;)
	$(foreach var, $(desNames), cdb2oa -lib $(var) -cdslibpath $(cdbDesDrop) -oalibpath $(oaDesConv)/$(var) -ignorelocks -abspath -report -log $(logFile)_$(var) -appendlog;)

##############################################################################################################################################
# clean up final release area - can't execute in target directoy ...
##############################################################################################################################################
##############################################################################################################################################
releaseTechCleanup: 	
	$(foreach var, $(RMTECHLIBS), touch /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/$(var); rm -rf /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/$(var);)


releaseCommCleanup: 	
	$(foreach var, $(COMMLIBS), touch /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/$(var); rm -rf /net/rfctest/vol/vol13/eng/lib/oaLibs/oaTest/oa/$(var);)

.phony: cleanLogs
cleanLogs:
	rm ./cdb2oa*.log*

.phony: cdsLib
cdsLib:
	echo "DEFINE RRFC_2metal /scratch/oaConversion/oaConversion/techlibs/oaLibs/RRFC_2metal" > cds.lib

.phony: help
help:
	cdb2oa -help

.phony: clean
clean:
	touch ./$(logFile)
	rm ./$(logFile)
	touch tmpCphMsg
	rm tmpCphMsg

.phony: clobber
clobber:
	touch ./$(logFile)
	rm ./$(logFile)
	touch ./cds.lib
	rm ./cds.lib
	touch tmpCphMsg
	rm tmpCphMsg