float t = 0;
float f = .01;
float a = 50;
float o = 0;

float x, y;

int freq = -1;
int amp = -1;
int base = 0;

String [] types = { "SIN", "COS", "TAN", "SQU", "SAW" };
ArrayList<Wave>waves = new ArrayList<Wave>();
boolean isModFreq, isModAmp;

void setup() {
  size(800, 600);
  background(255);
  waves.add(new Sine(t, f, a, o));
  waves.add(new Cosine(t, f, a, o));
  waves.add(new Tan(t, f, a, o));
  waves.add(new Square(t, f, a, o));
  waves.add(new Sawtooth(t, f, a, o));
}

void draw() {
  x+=.5;
  if(x > width) {
     background(255);
     x = 0; 
  }

  if (isModFreq && isModAmp) {
    display(height/2, waves.get(base).mod(waves.get(freq).run(), waves.get(amp).run()));
  }
  else if (isModFreq) {
    display(height/2, waves.get(base).modFreq(waves.get(freq).run()));
  }
  else if (isModAmp) {
    display(height/2, waves.get(base).modAmp(waves.get(amp).run()));
  }
  else {
    display(height/2, waves.get(base).run());
  }

  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);
  text("PRESS 1-5 TO PICK FREQ \t\t\t 0-6 TO PICK AMP \t\t\t SPACEBAR TO CYCLE THROUGH THE BASE WAVE", 10, 20);
  text("BASE: " + (base >= 0 ? types[base] : base) + "\t\tFREQ: " + (freq >= 0 ? types[freq] : freq) + "\t\tAMP: " + (amp >= 0 ? types[amp] : amp), 10, 40);
}

void display(float yoff, float y) {
  pushMatrix();
  translate(0, yoff);
  line(x, 0, x, y);
  popMatrix();
}

void keyPressed() {
  // SPACEBAR
  if (key == 32) {
    base++;
    base%=5;
  } 
  else if (key == '`') {
    isModFreq = false;
    freq = -1;
  } 
  else if (key == '-') {
    isModAmp = false;
    amp = -1;
  }
  else {
    int num = key == '0' ? 9 : parseInt(key)-49;
    if (num >=0) {
      if (num < 6) {
        isModFreq = true;
        freq = num;
      }
      else if (num < 10) {
        amp = 9-num;
      }
    }
  }
}

