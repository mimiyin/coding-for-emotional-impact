float x, y;
int baseline;

float frequency = 0.005;
float amplitude;

int type;
String [] types = { 
  "SIN", "COS", "TAN", "SQU", "SAW"
};

int max = 5;
ArrayList<Voice> voices = new ArrayList<Voice>();

boolean show;

void setup() {
  size(800, 600);
  background(255);
  baseline = height;
  amplitude = height/(max*2);
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i, 0));
  }
}

void draw() {
  
  x+=0.5;

  if (x > width) {
    background(255);
    x = 0;
  }

  

  float offset = 0;
  float [] values = new float [voices.size()];
  float [] offsets = new float [voices.size()];

  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    if (thisVoice.on) {
      float value = thisVoice.run();
      if (show) {
        display(value, offset, thisVoice.col);
      }
      offset += value;
      values[i] = value;
    }
    else {
      values[i] = 0;
    }
    offsets[i] = offset;
  }

  int i = fire(0, height-50, offsets);
  if (i < 0) {
    display(height-offset, offset, color(255, 0, 0, 10));
  }
  else {
    float y = values[i];
    float yoff = offsets[i] - y;
    display(y, yoff, color(255, 0, 0, 100));
  }

  label();
}

int fire(float min, float max, float[] zones) {
    float dart = random(min, max); 
    for (int i = 0; i < zones.length; i++) {
      if ( dart <= zones[i]) {
        return i;
      }
    }
    return -1;
  }

void display(float y, float yoff, color col) {
  pushMatrix();
  translate(0, baseline-yoff);
  stroke(col);
  line(x, 0, x, -y);
  popMatrix();
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
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t\u2B06(mouseY)\tAMP: " + amplitude + "\t\t\t\u2B05(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Press NUM KEY to turn on VOICE: " + waveTypes, 10, 40);
}

void keyPressed() {
  // Toggle Voices on and off
  int index = parseInt(key)-49;
  if (index >=0 && index < max) {
    voices.get(index).toggle(type);
  }
  
  int buffer = 10;
  switch(keyCode) {
  case UP:
    amplitude = constrain(map(mouseY, height-buffer, buffer, 0, height/2), 10, height/2);
    break;
  case LEFT:
    frequency = constrain(map(mouseX, buffer, width-buffer, 0.001, .1), 0, .1);
    break;
  case TAB:
    type++;
    type%=types.length;
    break;
  case ENTER:
    show = !show;
    break;
  }

}

