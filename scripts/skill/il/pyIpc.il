;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start a Python IPC
;;;;;;;;;;;;;;;;;;;;;;;;;;
procedure( startPythonIpc()
  let( (ip)
    ip = makeInstance( 'ipc )
    setCmd(ip "/users/1127110/project/python/ipc/trunk/asyncPyfifo.py")
    system("mkfifo /users/1127110/project/python/ipc/trunk/pipe")
    startIpcAsync(ip) 
    ip
  );let
);procedure

;;;;;;;;;;;;;;;;;;;;;;;;
; End a Python IPC
;;;;;;;;;;;;;;;;;;;;;;;;
procedure( endPythonIpc( ip )
    killIpc(ip)
    system("rm /users/1127110/project/python/ipc/trunk/pipe")
);procedure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
