import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

ParticleSystem ps;
PImage sprite;

int MIN_NOTE = 36;
int MAX_NOTE = 88;
int range = MAX_NOTE - MIN_NOTE;

int MARGIN = 25;

public class MidiReceiver {
    void noteOn(int channel, int pitch, int velocity) {
        //Receive a noteOn
        //println();
        //println("Note On:");
        //println("--------");
        //println("Channel:" + channel);
        println("Pitch:" + pitch);
        println("Velocity:" + velocity);
        float normalised_pitch = float(pitch - MIN_NOTE) / float(range);
        float x = normalised_pitch * (width - (2 * MARGIN)) + MARGIN;
        ps.addParticle(new PVector(x, 100));
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
    size(500, 500);
    background(0);

    MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

    MidiReceiver receiver = new MidiReceiver();
    myBus = new MidiBus(receiver, "Bus 2", "Logic Pro Virtual In");
    
    ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
    background(0);
    ps.run();
}
