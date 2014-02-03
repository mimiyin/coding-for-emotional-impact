//Import the library
import themidibus.*; 
MidiBus myBus; // The MidiBusint 
int channel = 10;
int velocity = 127;
int pitch = 96;

float x, y, prevX, xPos;

float w = 1;
float h = 10;

float d;
float interval = 1;
float f = 0.1;
float a = 20;

int mode = 0;
String [] modes = { 
  "RANDOM", "SINE", "TAN", "MANUAL"
};

boolean sound;

void setup() {
  size(800, 400);
  background(255);
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.    
  myBus = new MidiBus(this, -1, "Java Sound Synthesizer"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  println("Press TAB to change modes.");
  println("Use UP/DOWN to adjust intervals in manual mode.");
  println("Press ENTER to toggle sound mode.");
  delay(5000);
}

void draw() {

  if (x-prevX >= interval) {
    fill(0);
    rect(x, y, w, h);
    interval = calc(mode);
    prevX = x;

    // SOUND VERSION
    if (sound) {
      myBus.sendNoteOff(channel, pitch, velocity);
      myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    }
  }
  if (sound) x++;
  else x+=interval;

  // WRAP AROUND
  if (x > width) {
    y += h;
    x = -(x-width);
    prevX = x;
  }

  if (y > height) {
    background(255);
    x = 0;
    y = 0;
  }

  println("MODE: " + modes[mode] + "\t\tAMP: " + a + "\tFREQ: " + f + "\t\tINTERVAL: " + interval);
}

// Calculate interval differently
// depending on which mode you're in
float calc(int m) {

  d+=f;

  switch(m) {
  case 0:
    return random(a);
  case 1:
    return sin(d)*a/2 + a/2;
  case 2:
    return abs(tan(d/50))*a;
  default:
    return interval;
  }
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    interval++;
    break;
  case DOWN:
    interval--;
    break;
  case ENTER:
    sound = !sound;
    break;
  case TAB:
    mode++;
    mode%=modes.length;
    break;
  }

  if (key == 'f' || key == 'v') {
    f += (key == 'f' ? 0.001 : -0.001);
    f = constrain(f, 0.001, PI);
  }
  else if (key == 'a' || key == 'z') {
    a += (key == 'a' ? 10 : -10);
    a = constrain(a, 0, width);
  }

  interval = constrain(interval, 0, width);
  mode = constrain(mode, 0, modes.length-1);
}

