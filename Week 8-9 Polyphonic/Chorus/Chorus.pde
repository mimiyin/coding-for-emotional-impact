// MIDI STUFF
import themidibus.*;
MidiBus myBus; 
int [] pitches = { 
  96, 84, 72, 64, 32
};
int channel = 10;
int velocity = 127;
int number = 0;
int value = 90;


// Moving the shark
float x;
int tx, bg;

// Keeping track of voices
int maxVoices = 5;
int numVoices = 0;
Voice[] voices = new Voice[maxVoices];

// Dartboard to control probabilities of
// adding voices and picking wave types
Dartboard vb, wb;


void setup() {
  size(600, 400);
  background(bg);
  noFill();
  
  // Let's run the same set of random numbers every time
  randomSeed(0);

  // Fire-up the midi
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.    
  myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  // Set weights for voices and wave types
  vb = new Dartboard(maxVoices, maxVoices*2);
  wb = new Dartboard(5, -1);
}

void draw() {
  x++;
  if (x > width*(tx+1)) {
    tx++;
    background(bg);
  }

  pushMatrix();
  translate(-width*tx, 0);

  //IF THERE ARE ACTIVE VOICES...
  if (numVoices > 0) {
    //Check each voice to see if it's dead
    for (int i = voices.length-1; i >= 0; i--) { 
      if (voices[i] == null) continue;
      if (voices[i].isDead()) {
        numVoices--;
        cueVoices();
      }
      else {
        if (voices[i].run()) display(i);
      }
    }
  }
  else cueVoices();
  popMatrix();
}

void display(int row) {
  fill(255);
  rect(x, (row+1)*height/(maxVoices+1), 5, 10);
}

void cueVoices() {
  int add = vb.fire();
  if (add > 0) voices = addVoices(add);
}


Voice[] addVoices(int max) {
  int numToAdd = max - numVoices;
  if (numToAdd > 0) {
    for (int v = 0; v < voices.length; v++) {
      if (voices[v] == null || voices[v].isDead()) {
        if (numVoices >= numToAdd) break;
        voices[v] = new Voice(v);
        numVoices++;
        println("NUM ACTIVE VOICES: " + numVoices);
      }
    }
  }
  return voices;
}

