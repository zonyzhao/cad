import os

# FIXME: if fifo pipe does not exist create it
# os.system(mkfifo pipe)

skillCmd = "foo=makeInstance('shape)"

osCmd = "echo \""+skillCmd+"\"> pipe"
os.system(osCmd)
