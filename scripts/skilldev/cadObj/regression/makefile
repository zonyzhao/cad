##########################################################################
# This makefile runs the ivVerify command at the command line in order to
# verify the correctness of a target drc deck in a target library. The 
# verification of the verification code is executed on a target regression
# layout library. 
#
# <target_process> 
# <target drc deck>
# <target library>
#
# This makefile sets up Linux environment variables in the Bourne shell 
# environment, and should be executed after invoking the sh command (if sh
# is not running natively). The reason for running in the Bourne shell
# is that the ivVerify script that sets up the environment for the ivVerify.exe
# script was written as a Bourne script.
#########################################################################
# The following environmental variables need to be set in order to 
# run ivVerify in the Raytheon enviroment
#########################################################################
export REFLIBDIR=/nfs/layout/reflibs
export PROCLIBDIR=/nfs/layout/procLib
export CDS_LIC_FILE=5280@eand-idslnxlic01.and.us.ray.com:5280@emar-lnxlic01.mrl.us.ray.com:5280@epts-lnxlic01.pts.us.ray.com:5280@mklic01.rsc.raytheon.com
export CDS_ROOT=/apps/cadence/IC5141_usr5/tools/dfII/bin
export PATH := /apps/cadence/IC5141_usr5/tools/bin:/apps/cadence/IC5141_usr5/tools/dfII/bin:${PATH}
#########################################################################
ivPath = "/apps/cadence/IC5141_usr5/tools/dfII/bin/"
#########################################################################
# Local SVN Repository Location
#############################
drPath = "/users/1127110/project/diva/p80b/trunk/"
#drName = "divaDRC.rul"
#drName = "divaDRC_sfw_v1p0.rul"
#drName = "NEW_2_GaN_divaDRC.rul"
drName = "P80B_divaDRC_keysight.rul"
#drName = "RRFC_2metal_divaDRC.rul"
#############################
# CAD Location
#############################
#drPath = "/users/39540-cad/procLib/Rule_Files/"
#drName = "NEW_2_GaN_divaDRC.rul"
#########################################################################
c51Path = "/users/1127110/cad_layout_51"
#########################################################################
# Switch List
#########################################################################
#swList = "SelectiveDielectric"
swList = ""
#########################################################################

.phony: syspaths
syspaths:
	@echo REFLIBDIR is $$REFLIBDIR 
	@echo PROCLIBDIR is $$PROCLIBDIR
	@echo CDS_LIC_FILE is $$CDS_LIC_FILE
	@echo CDS_ROOT is $$CDS_ROOT
	@echo PATH is $$PATH

mesa:  tst_mesa_010p01_p1p0 tst_mesa_010p01_n1p0 tst_mesa_010p02_p1p0 tst_mesa_010p02_n1p0  tst_mesa_010p03_p1p0 tst_mesa_010p03_n1p0

###########################################################################################################################################################################
# Mesa
###########################################################################################################################################################################

.phony: tst_mesa_010p01_p1p0
tst_mesa_010p01_p1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p01_p1p0 layout -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p01_p1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p01_p1p0.out
	diff tst_mesa_010p01_p1p0.flt golden/tst_mesa_010p01_p1p0.flt > diffres/tst_mesa_010p01_p1p0.diff || echo \* tst_mesa_010p01_p1p0 Failed! \*
	cd $(c51Path) && sh $(ivPath)/ivVerify extract mesa_010p01_p1p0 layout -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout ext.txt > run.ext

.phony: tst_mesa_010p01_n1p0
tst_mesa_010p01_n1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p01_n1p0 layout  -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p01_n1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p01_n1p0.out
	diff tst_mesa_010p01_n1p0.flt golden/tst_mesa_010p01_n1p0.flt > diffres/tst_mesa_010p01_n1p0.diff || echo \* tst_mesa_010p01_np10 Failed! \*

.phony: tst_mesa_010p02_p1p0
tst_mesa_010p02_p1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p02_p1p0 layout  -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p02_p1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p02_p1p0.out
	diff tst_mesa_010p02_p1p0.flt golden/tst_mesa_010p02_p1p0.flt > diffres/tst_mesa_010p02_p1p0.diff || echo \* tst_mesa_010p02_p1p0 Failed! \*

.phony: tst_mesa_010p02_n1p0
tst_mesa_010p02_n1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p02_n1p0 layout  -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p02_n1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p02_n1p0.out
	diff tst_mesa_010p02_n1p0.flt golden/tst_mesa_010p02_n1p0.flt > diffres/tst_mesa_010p02_n1p0.diff || echo \* tst_mesa_010p02_n1p0 Failed! \*

.phony: tst_mesa_010p03_p1p0
tst_mesa_010p03_p1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p03_p1p0 layout  -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p03_p1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p03_p1p0.out
	diff tst_mesa_010p03_p1p0.flt golden/tst_mesa_010p03_p1p0.flt > diffres/tst_mesa_010p03_p1p0.diff || echo \* tst_mesa_010p03_p1p0 Failed! \*

.phony: tst_mesa_010p03_n1p0
tst_mesa_010p03_n1p0:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc mesa_010p03_n1p0 layout  -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt
	cd $(c51Path) && cp drc.out /users/1127110/project/gmake/ivVerify/trunk/tst_mesa_010p03_n1p0.out
	/users/1127110/project/python/diva/trunk/ivVerifyResFilt.py tst_mesa_010p03_n1p0.out
	diff tst_mesa_010p03_n1p0.flt golden/tst_mesa_010p03_n1p0.flt > diffres/tst_mesa_010p03_n1p0.diff || echo \* tst_mesa_010p03_n1p0 Failed! \*

.phony: keysight
keysight:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc test_bridges layout -set $(swList) -echo -full -lib p80a_drc_sfw -ru $(drPath)/$(drName) -drcout test.txt > run.txt


cellName = "airbridge_short"
libName = "p80a_drc_sfw"
.phony: tst_tab
tst_tab:
	cd $(c51Path) && sh $(ivPath)/ivVerify drc $(cellName) layout -set $(swList) -echo -full -lib $(libName) -ru $(drPath)/$(drName) -drcout drc.txt > run.drc
	cd $(c51Path) && sh $(ivPath)/ivVerify extract $(cellName) layout -set $(swList) -echo -full -lib $(libName) -ru $(drPath)/$(drName) -drcout ext.txt > run.ext

###########################################################################################################################################################################
# SD
###########################################################################################################################################################################

.phony: clean
clean:
	touch foo.err
	touch foo.out
	touch foo.flt
	touch diffres/foo.diff
	rm *.err
	rm *.out
	rm *.flt
	rm diffres/*