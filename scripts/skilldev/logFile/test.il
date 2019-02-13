;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0: Test Existence and Inheritance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
findClass( 'logFile )
log = makeInstance( 'logFile )
classp( log 'logFile)
classOf(log)
superclassesOf(classOf(log))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; UT-0 Open, Write Header, and Close File
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
; UT-1 Open, 
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
