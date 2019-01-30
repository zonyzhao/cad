;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: test existence and constructor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'ipc )
ip = makeInstance( 'ipc )
classp( ip 'ipc)
classOf(ip)
ip->cid
ip->oid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ip = makeInstance( 'ipc )
setCmd(ip "/users/1127110/project/python/skillIpc/trunk/upper.py")
startIpc(ip)
setWrStr(ip "hello python\n")
writeIpc(ip)
readIpc(ip)
getRdStr(ip)
killIpc(ip)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ip = makeInstance( 'ipc )
setCmd(ip "/users/1127110/project/python/ipc/trunk/pyfifo.py")
setWrStr(ip "ack/n")
startIpc(ip)

; terminal shell commands
echo "foo = makeInstance('shape)" > pipe

;;;;;;;;;;;;;;;;
readIpc(ip)    ;
execute(ip)    ;LOOP
writeIpc(ip)   ;
readIpc(ip)    ;
;;;;;;;;;;;;;;;;

killIpc(ip)
system("rm /users/1127110/project/python/ipc/trunk/pipe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3: Asynch 
; Uses the pySkillConsol.py script
; to interact with the fifo.
; One way communication from Python
; to Cadence via skill commands 
; "driving commands into Cadence from Python"
; Steps to running:
; 1.) Execute the code up to "startIpcAsync(ip)
; 2.) In a Python terminal execute code in
;     pySkillConsole.py
; 3.) Enter commands in parenthesis: "foo = makeInstance('shape)"
; 4.) To exit the Pyhon Script and the Cadence IPC process: "exit"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ip = makeInstance( 'ipc )
setCmd(ip "/users/1127110/project/python/ipc/trunk/asyncPyfifo.py")
; No acks required for async comms
;setWrStr(ip "ack")
system("mkfifo /users/1127110/project/python/ipc/trunk/pipe")
;system("mkfifo /users/1127110/project/python/ipc/trunk/pypipe")
startIpcAsync(ip)
;FIXME: simplex communication - need two fifos for half duplex
; skfifo (python to skill)  and pyfifo (skill to python)
; skill script creates the pyfifo and python script creates skfifo
; attempting to write an "ack" back to Python "asyncPyfifo.py"
; script, but I don't think it is listening for acks right now
;writeIpc(ip)   
killIpc(ip)
system("rm /users/1127110/project/python/ipc/trunk/pipe")
;system("rm /users/1127110/project/python/ipc/trunk/skpipe")

;
; procedures for starting and stopping the Python IPC
;
procedure( startPythonIpc()
  let( (ip)
    ip = makeInstance( 'ipc )
    setCmd(ip "/users/1127110/project/python/ipc/trunk/asyncPyfifo.py")
    system("mkfifo /users/1127110/project/python/ipc/trunk/pipe")
    startIpcAsync(ip) 
    ip
  );let
);procedure

procedure( endPythonIpc( ip )
    killIpc(ip)
    system("rm /users/1127110/project/python/ipc/trunk/pipe")
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;;
; Skill terminal CIW example
; start
pyIpc = startPythonIpc()
; end
endPythonIpc(pyIpc)

;;;;;;;;;;;;;;;;;;;;;;;;;;
; terminal shell commands
echo "foo = makeInstance('shape)" > skpipe
echo <pyfifo

;#############################################################
;#IMPORTANT NOTE:
:# You can initialize the child python process
;# buy passing  a command line argument 
:# sprintf(pycmd "/users/1127110/project/python/skillIpc/trunk/upper.py \"arg\" ")
;# the python child process needs to be set up to accept command line args
;#############################################################
;##########################################
; Experimental code
;##########################################

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-: 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( pyIpc()
  prog( (ip)
	ip = makeInstance( 'ipc )
	setWrStr(ip "ack\n")
	setCmd(ip "/users/1127110/project/python/ipc/trunk/pyfifo.py")
	startIpc(ip)
	println("Python-IPC Started")
	while(readIpc(ip) != "exit" 
	  if(ip->rdStr != "" then
;      	  while(ip->rdStr == "" readIpc(ip));while
	    println("Python Command Received")
      	    execute(ip)
      	    printf("Command Executed: \"%s\"" ip->rdStr)
	    writeIpc(ip)
	    when(readIpc(ip) == "ack received"
	      printf("%s\n" ip->rdStr)
	    );when
	  );if   	  
	);while
	killIpc(ip)
  );prog
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
strncmp( readIpc(ip) "" 1)
strncmp( "" "" 1)
strncmp("foo=makeInstance('shape)\n" "" 1)
;;;;;;;;;;;;;;;;;;
; while loop test:
i=0
while( (i <= 10) printf("%d\n" i++))
sprintf(pycmd "/users/1127110/project/python/skillIpc/trunk/upper.py")
cid = ipcBeginProcess( pycmd )
ipcWaitForProcess( cid )
;####### write/read cycle ##############
;# have to have the newline character in
;# string or the line will not be read on
;# the python side
;#######################################
;# Do a write to python
ipcWriteProcess(cid "hello python\n")
;# Read back from python
x=ipcReadProcess(cid 1)
when(x printf("New string: %s", x))
;####### write/read cycle ##############
;# Do a write to python
ipcWriteProcess(cid "skill and python working together is good\n")
;# Read back from python
x=ipcReadProcess(cid 1)
when(x printf("New string: %s", x))
;####### close connection ##############
;# exit loop on python side
ipcWriteProcess(cid "foo\n")
;####### write/read cycle ##############
;# Do a write to python
ipcWriteProcess(cid "are you alive?\n")
;# Read back from python
x=ipcReadProcess(cid 1)
when(x printf("New string: %s", x))
;########## skill kill #################
ipcKillProcess( cid )

;###############################################
;# MPSS IPC commands
;###############################################

;### Skill
; IPC command sent to external process
sprintf(mpss_cmd "/net/nfs-n501/ANFS01/apps/python/python27/bin/python /users/1127110/project/python/buildMPSS/trunk/buildMPSS.py %s %s" file multiCMD)
; begin the process and assign to variable
forked = ipcBeginProcess( mpss_cmd "")
; this signals that process has been spawned
ipcWaitForProcess( forked )
; give the user a little feedback
printf( "Building MPSS Report from release photo file: %s ... \n" file)
;IPC will wait for return - is there a watchdog timer of this??
ipcWait(forked)
;Return an output signature from the end of the external process
output = ipcReadProcess(forked)
; Give the user feedback on the return
printf("%s" output)
if( (output != "MPSS complete, check release folder\n") then
    printf("IPC ERROR: Unable to build MPSS, see above error message for details\n")
else
    printf("IPC INFO: MPSS build completed\n")
);if

;#### Python
sys.stderr
sys.stdout
sys.stdin
sys.exit
sys.stdout.write("MPSS complete, check release folder\n")
buffer=sys.stdin.read()
sys.stdout.flush()
sys.stdin.flush()

;###############################################
;# Driving commands from emacs directly into 
;# cadence from the emacs log file
;###############################################
procedure(socketHandler(ipcId data) 
  let( (inPort 
        nextline) 
	inPort=infile(data) 
	when(inPort 
	  while(
		gets(nextLine inPort) 
	        printf("\n%s \n" nextLine)
	  );while
	);when          
	close(inPort) 
 	inPort=infile(data)  
	when(inPort 
	  while(gets(nextLine inPort) 
	        return(print(evalstring(nextLine)))
	  );while
        );when
        close(inPort) 
  );let
);procedure 

; IPC Call 							      
ipcBeginProcess("emacs ~/Skill/my-log.txt" "" 'socketHandler)  

;###############################################
;#
;###############################################
Two additional channels are open 3:write 4:read
print(3,buff)

# using channels 3 and 4
import sys
import os

sys.stdout.flush()

os.write(3,"println(\"Hello World\")")
os.write(3,"(3+3)")

val = os.read(4,4096)

# must be started on the skill side with the following:

cid = ipcSkillProcess(pycmd)


#############################################
# Handler Procedure Definitions
#############################################

Skill:
pyIpc = ipcBeginProcess("my.py" "" 'myIpcDataHandler 'myIpcErrHandler 'myIpcFinishHandler "/tmp/py.log")
procedure(myIpcDataHandler(ipcId data)
  let((result)
    ;printf("in myIpcDataHandler with %L\n" data)
    foreach(d parseString(data "\n")
        unless(errset(result=evalstring(d))
             printf("ERROR: %L\n" errset.errset)
             ipcWriteProcess(ipcId sprintf(nil "ERROR %L\n" errset.errset))
        ) ; unless
    )
  )
)

procedure(myIpcErrHandler(ipcId data)
    println(list("ERROR: myIpcErrHandler called with:" ipcId data))
)

procedure(myIpcFinishHandler(ipcId data)
  let((exitStatus)
    printf("Finished at %s: %L %L  " getCurrentTime() ipcId data)
    exitStatus = ipcGetExitStatus(ipcId)
    printf("Return value = %L\n" exitStatus)
    if(exitStatus==0 then
        printf("The IPC call has finished!!\n")
    else
        printf("**ERROR: operation failed\n")
    )
  )
)

procedure(mySkillCommand(data)
    println(data)
    ipcWriteProcess(pyIpc "Skill says hello")
)

Python file my.py:
import sys
data = 'Hello from the Python world'
sys.stdout.write('mySkillCommand("%s")\n' % data)
sys.stdout.flush()
returnData = sys.stdin.readline()
#Write to a file since stdout goes to Cadence
outFile = open('/tmp/myPy.out','w')    
outFile.writelines( returnData )
outFile.close()

