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

// Likelihood of do nothing
float ceilingFactor;

void setup() {
  size(800, 600);
  background(255);

  // Base amplitude on window height
  amplitude = height/(max*2);
  // Calculate ground location
  ground = height-(amplitude*max*2*scale);

  // Create 3 Voices
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i));
  }
  
  ceilingFactor = 1;
}

void draw() {
  // Move the graph along
  if (x > width) {
    background(255);
    x = 0;
  }
  x+=.5;

  // Draw background for the "sketch"
  noStroke();
  fill(0);
  rect(0, 0, width, ground);

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
      graph(value, offset, thisVoice.col);
      offset += value;
      values[i] = value;
    }
    else {
      values[i] = 0;
    }
    offsets[i] = offset;
  }

  // Pick a voice
  // Adjust amount of room for nothing to happen
  float ceiling = offset;
  int i = fire(0, ceiling, offsets);
  if (i >=0) {
    float y = values[i];
    float yoff = offsets[i] - y;
    graph(y, yoff, color(255, 0, 0, 100));
  }

  // Set acceleration and score for SLOW, MEDIUM and FAST cars
  switch(i) {
  case 0:
    println("DAY-O");
    break;
  case 1:
    println("DAY-AY-AY-AY-O");
    break;
  case 2:
    println("DAYLIGHT COMES AND ME WANNA GO HOME");
    break;
  }
  
 
  // Draw label
  label();
}

// Pick a voice
int fire(float min, float max, float[] zones) {
  float dart = random(min, max); 
  for (int i = 0; i < zones.length; i++) {
    if ( dart < zones[i]) {
      return i;
    }
  }
  return -1;
}

// Draw the graph
void graph(float y, float yoff, color col) {
  pushMatrix();
  translate(0, height-(yoff*scale));
  stroke(col);
  line(x, 0, x, (-y*scale));
  noStroke();
  popMatrix();
}

void score(float s) {
  // Draw the score
  stroke(255);
  strokeWeight(10);
  fill(255, 0, 0);
  ellipse(width/2, height-s, 20, 20);
  strokeWeight(1);
}


void label() {
  noStroke();
  fill(0);
  rect(0, 0, width, 50);

  String waveTypes = "";
  for (int i = 0; i < voices.size(); i++) {
    waveTypes += (i+1) + ": " + voices.get(i).getType() + "\t\t";
  }
  fill(255);
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t(mouseY)\tAMP: " + amplitude + "\t\t\t(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Pres NUM KEY to turn on VOICE: " + waveTypes + "\t\t\tSelected Voice: " + (voice.index+1) + "\t\t\tCeiling Factor: " + ceilingFactor, 10, 40);
}

void mouseMoved() {
  amplitude = map(mouseY, 0, height, 0, height/2);
  frequency = map(mouseX, 0, width, 0.001, 0.1);

  if (voice.on) {
    voice.mod();
  }
}

void keyPressed() {
  // Toggle Voices on and off
  int index = parseInt(key)-49;
  if (index >=0 && index < max) {
    voice = voices.get(index);
    voice.toggle(type);
    if (!voice.on) voice = new Voice(-1);
  }

  switch(keyCode) {
  case TAB:
    type++;
    type%=types.length;
    break;
  case UP:
    ceilingFactor+=10;
    break;
  case DOWN:
    ceilingFactor-=10;
    break;
  }

  ceilingFactor = constrain(ceilingFactor, 1, 100);
  
  if (key == 32) {
    type++;
    type%=types.length;
  }
}

