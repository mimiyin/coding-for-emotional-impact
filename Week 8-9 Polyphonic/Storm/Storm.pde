import ddf.minim.*;
Minim minim;
// Drawing the graph
float x, y;

// Starting freq and amp for waves
float frequency = 0.005;
float amplitude;

// Selected type of wave
int type;
// Wave types
String [] types = { 
  "SIN", "COS", "TAN", "SQU", "SAW"
};

int max = 3; // Total number of "voices"
float scale = 0.1; // Scale down the visualization so it doesn't take up the whole screen
float ground; // y-value for "ground" of landscape
ArrayList<Voice> voices = new ArrayList<Voice>();

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
    voices.add(new Voice(i, 0));
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
  
  // Calculate offsets and values both
  // for graphing and picking a voice
  float offset = 0;
  float [] offsets = new float [voices.size()];
  float [] values = new float [voices.size()];
  
  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    if (thisVoice.on) {
      float value = thisVoice.run();
      display(value, offset, thisVoice.col);
      offset += value;
      values[i] = value;
    }
    else {
      values[i] = 0;
    }
    offsets[i] = offset;
  }
  
  // Pick a voice
  int i = fire(0, height-50, offsets);
  if (i >=0) {
    float y = values[i];
    float yoff = offsets[i] - y;
    display(y, yoff, color(255, 0, 0, 100));
  }
  
  // Conduct sketch based on which voice was chosen
  switch(i) {
  case 0:
    rain.drop(values[i]*0.01);
    break;
  case 1:
    thunder.roll();
    break;
  case 2:
    flock.release(new Boid(width, random(height)));
    break;
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
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t\u2B06(mouseY)\tAMP: " + amplitude + "\t\t\t\u2B05(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Pres NUM KEY to turn on VOICE: " + waveTypes, 10, 40);
}

void keyPressed() {
  // Toggle Voices on and off
  int index = parseInt(key)-49;
  if (index >=0 && index < max) {
    voices.get(index).toggle(type);
  }
  
  int margin = 10;
  switch(keyCode) {
  case UP:
    amplitude = constrain(map(mouseY, height-margin, margin, 0, height/2), 10, height/2);
    break;
  case LEFT:
    frequency = constrain(map(mouseX, margin, width-margin, 0.001, .1), 0, .1);
    break;
  case TAB:
    type++;
    type%=types.length;
    break;
  }

  if (key == 32) {
    type++;
    type%=types.length;
  }

  frequency = constrain(frequency, 0.001, PI);
  amplitude = constrain(amplitude, 0, width);
}

