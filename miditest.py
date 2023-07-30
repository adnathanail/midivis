import mido

# This will list the available ports 
print(mido.get_output_names())

# Open the midi link to your keyboard
outport = mido.open_output('IAC Driver Bus 2')

# Open the mid file to be played
mid = mido.MidiFile('testmidifile.mid', clip=True)

# Play the file out to your keyboard
for msg in mid.play():
    outport.send(msg)
