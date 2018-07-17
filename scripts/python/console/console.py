# Console module provide 'copen' method for opeing interactive
# python shell in the runtime
import code
import readline
import rlcompleter

#opens interactive console with current execution state
#call it with console.open(globals(),locals())
def open(_globals,_locals):
    context = _globals.copy()
    context.update(_locals)
    readline.set_completer(rlcompleter.Completer(context).complete)
    readline.parse_and_bind("tab: complete")
    shell = code.InteractiveConsole(context)
    shell.interact()
