import ddf.minim.*;
Minim minim;
// Drawing the graph
float x, y;

// Starting freq and amp for waves
float frequency = 0.005;
float amplitude = 10;

// Selected type of wave
int type;

// Wave types
String [] types = { 
  "SIN", "COS", "TAN", "SQU", "SAW"
};

int max = 3; // Total number of "voices"
float scale = 0.1; // Scale down the visualization so it doesn't take up the whole screen
float ground; // y-value for "ground" of landscape

// Chorus of voices
ArrayList<Voice> voices = new ArrayList<Voice>();
// Selected voice
Voice voice = new Voice(-1);

Rain rain;
Thunder thunder;
Flock flock;

void setup() {
  size(800, 600);
  background(255);
  minim = new Minim(this);
  rain = new Rain();
  thunder = new Thunder();
  flock = new Flock();

  // Base amplitude on window height
  amplitude = height/(max*2);
  // Calculate ground location
  ground = height-(amplitude*max*2*scale);

  // Create 3 Voices
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i));
  }
}

void draw() {
  // Draw background for the "sketch"
  noStroke();
  fill(100);
  rect(0, 0, width, ground);

  // Move the graph along
  if (x > width) {
    background(255);
    x = 0;
  }
  x+=.5;

  // Calculate offset to graph voices
  float offset = 0;

  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    float value = 0;
    if (thisVoice.on) {
      value = thisVoice.run();
      display(value, offset, thisVoice.col);
      switch(i) {
      case 0:
        for (int r = 1; r < value*0.01; r++) {
          rain.drop();
        }
        break;
      case 1:
        thunder.roll(value);
        break;
      case 2:
        println(value);
        for (int b = 1; b < value*.01; b++) {
          flock.release(new Boid(width, random(height)));
        }
        break;
      }
    }
  }

  // Keep it raining
  rain.run();
  thunder.run();
  flock.run();
  // Draw label
  label();
}

// Pick a voice
int fire(float min, float max, float[] zones) {
  float dart = random(min, max); 
  for (int i = 0; i < zones.length; i++) {
    if ( dart <= zones[i]) {
      return i;
    }
  }
  return -1;
}

// Draw the graph
void display(float y, float yoff, color col) {
  pushMatrix();
  translate(0, height-(yoff*scale));
  stroke(col);
  line(x, 0, x, (-y*scale));
  noStroke();
  popMatrix();
}


void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);

  String waveTypes = "";
  for (int i = 0; i < voices.size(); i++) {
    waveTypes += (i+1) + ": " + voices.get(i).getType() + "\t\t";
  }
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t(mouseY)\tAMP: " + amplitude + "\t\t\t(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Pres NUM KEY to turn on VOICE: " + waveTypes + "\t\t\tSelected Voice: " + voice.index+1, 10, 40 );
}

void mouseMoved() {
  amplitude = map(mouseY, 0, height, 0, height/2);
  frequency = map(mouseX, 0, width, 0.001, 0.1);
  
  if(voice.on) {
    voice.mod();
  }
}

void keyPressed() {
  // Toggle Voices on and off
  int index = parseInt(key)-49;
  if (index >=0 && index < max) {
    voice = voices.get(index);
    voice.toggle(type);
    if(!voice.on) voice = new Voice(-1);
  }

  switch(keyCode) {
  case TAB:
    type++;
    type%=types.length;
    break;
  }

  if (key == 32) {
    type++;
    type%=types.length;
  }

}

