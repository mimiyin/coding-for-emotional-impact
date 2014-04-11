import ddf.minim.*;
Minim minim;
AudioPlayer siren;
float gain = -80;

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

// Likelihood of no cars
float ceilingFactor;

// Cars
ArrayList<Car> cars = new ArrayList<Car>();

// Scoring curves
// 1 for each "speed" of car
Score sloScore = new Score(new Logarithmic(1, 1, 50));
Score medScore = new Score(new Linear(0, 1, 10));
Score fastScore = new Score(new RocketShip(0, 0.1, 200));


void setup() {
  size(800, 600);
  background(255);
  minim = new Minim(this);
  siren = minim.loadFile("siren.aif");
  siren.loop();
  siren.setGain(gain);

  // Base amplitude on window height
  amplitude = height/(max*2);
  // Calculate ground location
  ground = height-(amplitude*max*2*scale);

  // Create 3 Voices
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i));
  }
  
  ceilingFactor = 10;
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
  float ceiling = height*ceilingFactor;
  int i = fire(0, ceiling, offsets);
  if (i >=0) {
    float y = values[i];
    float yoff = offsets[i] - y;
    graph(y, yoff, color(255, 0, 0, 100));
  }

  // Init each car with a location, velocity and acceleration
  PVector location = new PVector(0, random(10, 90));
  PVector velocity = new PVector(1, 0);
  PVector acceleration = new PVector(0, 0); 

  // Set acceleration and score for SLOW, MEDIUM and FAST cars
  switch(i) {
  case 0:
    acceleration.x = random(0.001, 0.01);
    sloScore.update(1);
    break;
  case 1:
    acceleration.x = random(0.01, 0.1);
    medScore.update(1);
    break;
  case 2:
    acceleration.x = random(0.1, 1);
    fastScore.update(1);
    break;
  }

  // Add car
  if (i >=0 ) {
    cars.add(new Car(i, location, velocity, acceleration));
  }



  // Calculate total score
  float s = sloScore.calc() + medScore.calc() + fastScore.calc();
  print("SLOW SCORE: " + sloScore.calc());
  print("\tMED SCORE: " + medScore.calc());
  print("\tFAST SCORE: " + fastScore.calc());
  println("\tTOTAL: " + s);

  // Set threshold to explode car size and make it loud
  if (s > 500) {
    for (Car c: cars) c.setSize(100);
    gain = 10;
  }

  // Drive cars
  pushMatrix();
  translate(0, (height/2)-50);
  fill(255);
  rect(0, 0, width, 100);
  // Run cars
  for (int c = cars.size()-1; c > 0; c--) {
    Car thisCar = cars.get(c);
    if (thisCar.isDead()) {
      int type = thisCar.type;
      switch(type) {
      case 0:
        sloScore.update(-1);
        break; 
      case 1:
        medScore.update(-1);
        break;        
      case 2:
        fastScore.update(-1);
        break;
      }
      cars.remove(c);
    }
    thisCar.run();
  }
  popMatrix();

  // Set gain based on score
  gain = map(s, 0, 500, -80, 0);
  gain = constrain(gain, -80, 10);
  siren.setGain(gain);

  // Display score level
  score(s);

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

