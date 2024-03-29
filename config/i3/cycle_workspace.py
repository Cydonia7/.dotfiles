#!/usr/bin/env python
 
import i3ipc
import pprint

i3 = i3ipc.Connection()

pp = pprint.PrettyPrinter(indent=4)

outputs = i3.get_outputs()
workspaces = i3.get_workspaces()

# figure out what is on, and what is currently on your screen.
workspace = list(filter(lambda s: s.focused, workspaces))
output = list(filter(lambda s: s.active, outputs))

# figure out the other output name
other_output = list(filter(lambda s: s.name!=workspace[0].output, output))

# send current to the no-active one
i3.command('move workspace to output '+other_output[0].name)
