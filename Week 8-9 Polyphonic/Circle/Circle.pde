// Starting freq and amp for waves
float frequency = 0.005;
float amplitude = 10;

// Selected type of wave
int type;

// Wave types
String [] types = { 
  "SIN", "COS", "TAN", "SQU", "SAW"
};

int max = 5; // Total number of "voices"

// Chorus of voices
ArrayList<Voice> voices = new ArrayList<Voice>();
// Selected voice
Voice voice = new Voice(-1);

// The Circle
float sW, cW, cH;
PVector circle = new PVector (0, 0);

void setup() {
  size(800, 600);
  background(255);

  // Create max number of Voices
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i));
  }
}

void draw() {
  background(0);

  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    float value = 0;
    if (thisVoice.on) {
      value = thisVoice.run();
      switch(i) {
      case 0:
        value = map(value, 0, height, 0, width);
        circle.x = value;
        break;
      case 1:
        circle.y = value;
        break;
      case 2:
        cW = value;
        break;
      case 3:
        cH = value;
        break;
      case 4:
        sW = value;
        break;
      }
    }
  }
  
  // Draw the Circle
  strokeWeight(sW);
  fill(circle.y, circle.x, cH);
  stroke(circle.x, circle.y, cW);
  ellipse(circle.x, circle.y, cW, cH);
  strokeWeight(1);
  stroke(0);

  // Draw label
  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);

  String waveTypes = "";
  String [] properties = { "x", "y", "width", "height", "strokeWeight" };
  for (int i = 0; i < voices.size(); i++) {
    waveTypes += properties[i] + ": " + voices.get(i).getType() + "\t\t";
  }
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t(mouseY)\tAMP: " + amplitude + "\t\t\t(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Pres NUM KEY to turn on VOICE: " + waveTypes + "\t\t\tSelected Voice: " + properties[voice.index >= 0 ? voice.index : 0], 10, 40 );
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
  }

  if (key == 32) {
    type++;
    type%=types.length;
  }
}

