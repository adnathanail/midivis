import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

ParticleSystem ps;
PImage sprite;

int MIN_NOTE = 36;
int MAX_NOTE = 88;
float note_range = float(MAX_NOTE - MIN_NOTE);

int MIN_VELOCITY = 9;
int MAX_VELOCITY = 90;
float velocity_range = float(MAX_VELOCITY - MIN_VELOCITY); 

int MARGIN = 25;

float COLOUR_COUNTER_RANGE = 1000.0;
float colour_counter = 0;

// So the colour timer will start at a consistent point
boolean first_note_received = false;

color mapNumberToColor(float value) {
    float r = sin(PI * value) * 255;
    float g = sin(PI * (value + 1 / 3.0)) * 255;
    float b = sin(PI * (value + 2 / 3.0)) * 255;

    return color(r, g, b);
}

public class MidiReceiver {
    void noteOn(int channel, int pitch, int velocity) {
        if (!first_note_received) {
          first_note_received = true;
        }
        //Receive a noteOn
        println();
        println("Pitch:" + pitch);
        println("Velocity:" + velocity);
        float normalised_pitch = float(pitch - MIN_NOTE) / note_range;
        float x = normalised_pitch * (width - (2 * MARGIN)) + MARGIN;
        float normalised_velocity = float(velocity - MIN_VELOCITY) / velocity_range;
        ps.addParticle(new PVector(x, 100), normalised_velocity * 16, mapNumberToColor(colour_counter / COLOUR_COUNTER_RANGE));
    }

    void noteOff(int channel, int pitch, int velocity) {
        ////Receive a noteOff
        //println();
        //println("Note Off:");
        //println("--------");
        //println("Channel:" + channel);
        //println("Pitch:" + pitch);
        //println("Velocity:" + velocity);
    }
}

void setup() {
    size(432, 784);
    background(0);

    MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

    MidiReceiver receiver = new MidiReceiver();
    myBus = new MidiBus(receiver, "Bus 2", "Logic Pro Virtual In");
    
    ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
    background(0);
    ps.run();
    if (first_note_received) {
      colour_counter += 1;
      colour_counter = colour_counter % (COLOUR_COUNTER_RANGE - 50);
    }
}
