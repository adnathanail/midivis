import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

ParticleSystem ps;
PImage sprite;  

public class MidiReceiver { 
    void noteOn(int channel, int pitch, int velocity) {
        //Receive a noteOn
        println();
        println("Note On:");
        println("--------");
        println("Channel:" + channel);
        println("Pitch:" + pitch);
        println("Velocity:" + velocity);
        ps.addParticle(new PVector((pitch - 45) * 30, 100));
    }

    void noteOff(int channel, int pitch, int velocity) {
        //Receive a noteOff
        println();
        println("Note Off:");
        println("--------");
        println("Channel:" + channel);
        println("Pitch:" + pitch);
        println("Velocity:" + velocity);
    }
}

void setup() {
    size(400, 400);
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
