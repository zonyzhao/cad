;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'logFile )
log = makeInstance( 'logFile )
classp( log 'logFile)
classOf(log)
superclassesOf(classOf(log))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-1 Open, Write Header, and Close File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
log = makeInstance( 'logFile )
setName(log "Test")
setPath(log "/users/1127110/cad/scripts/skilldev/logFile")
setDesign(log "Foo")
setApp(log "FooBar")
setId(log "A01")
openLog(log)
writeLogHeader(log)
closeLog(log)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-2 Open, 
;      Write Header, 
;      Add a log string
;      Close File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
log = makeInstance( 'logFile )
setName(log "Test")
setPath(log "/users/1127110/cad/scripts/skilldev/logFile")
setDesign(log "Foo")
setApp(log "FooBar")
setId(log "A01")
openLog(log)
writeLogHeader(log)
writeLog(log "INFO: This is an awesome application")
writeLog(log "INFO: The output is perfect!")
closeLog(log)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3 Create an output log list 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lst = '(0 1 2 3 4 5 6 7 8 9 10)
log = makeInstance( 'logFile )
setName(log "TestList")
setPath(log "/users/1127110/cad/scripts/skilldev/logFile")
setDesign(log "Foo")
setApp(log "FooBar")
setId(log "A01")
openLog(log)
writeLogList(log lst)
closeLog(log)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-3 Create an output log DPL 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lst = '(0 1 2 3 4 5 6 7 8 9 10)
log = makeInstance( 'logFile )
setName(log "TestDpl")
setPath(log "/users/1127110/cad/scripts/skilldev/logFile")
setDesign(log "Foo")
setApp(log "FooBar")
setId(log "A01")
openLog(log)
writeDpl(log lst)
closeLog(log)