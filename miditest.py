import mido

# This will list the available ports 
print(mido.get_output_names())

# Open the midi link to your keyboard
outport = mido.open_output('IAC Driver Bus 2')

# Open the mid file to be played
mid = mido.MidiFile('What Was I Made For.mid', clip=True)

min_note = 1000
max_note = 0

min_velocity = 1000
max_velocity = 0

# Play the file out to your keyboard
for msg in mid.play():
    outport.send(msg)
    print(msg)
    if msg.type == "note_on":
        if msg.note < min_note:
            min_note = msg.note
        if msg.note > max_note:
            max_note = msg.note
        if msg.velocity < min_velocity:
            min_velocity = msg.velocity
        if msg.velocity > max_velocity:
            max_velocity = msg.velocity

print("min_note: ", min_note)
print("max_note: ", max_note)
print("min_velocity: ", min_velocity)
print("max_velocity: ", max_velocity)