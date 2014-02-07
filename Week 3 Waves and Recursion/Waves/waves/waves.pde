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
  
  // Run the wave to calculate the next y-position
  // to pass it into the display function to draw it
  
  // If modulating both freq and amp
  if (isModFreq && isModAmp) {
    display(waves.get(base).mod(waves.get(freq).run(), waves.get(amp).run()));
  }
  // If only modulating frequency
  else if (isModFreq) {
    display(waves.get(base).mod(waves.get(freq).run(), -1));
  }
  // If only modulating amplitude
  else if (isModAmp) {
    display(waves.get(base).mod(-1, waves.get(amp).run()));
  }
  // If not modulating at all
  else {
    display(waves.get(base).run());
  }
  
  // Draw label
  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);
  text("PRESS 1-5 TO PICK FREQ \t\t\t 0-6 TO PICK AMP \t\t\t SPACEBAR TO CYCLE THROUGH THE BASE WAVE", 10, 20);
  text("BASE: " + (base >= 0 ? types[base] : base) + "\t\tFREQ: " + (freq >= 0 ? types[freq] : freq) + "\t\tAMP: " + (amp >= 0 ? types[amp] : amp), 10, 40);
}

void display(float y) {
  pushMatrix();
  translate(0, height/2);
  line(x, 0, x, y);
  popMatrix();
}

void keyPressed() {
  // SPACEBAR
  if (key == 32) {
    base++;
    base%=5;
  } 
  // Turn off modulating frequency
  else if (key == '`') {
    isModFreq = false;
    freq = -1;
  } 
  // Turn off modulating amplitude
  else if (key == '-') {
    isModAmp = false;
    amp = -1;
  }
  else {
    // Turn key chars into ints
    int num = key == '0' ? 9 : parseInt(key)-49;
    if (num >=0) {
      // 1-5 selects a wave type to modulate frequency
      // Automatically turns on modulating frequency
      if (num < 6) {
        isModFreq = true;
        freq = num;
      }
      // 6,7,8,9 selects a wave type to module amplitude
      // Automatically turns on modulating amplitude
      else if (num < 10) {
        isModAmp = true;
        amp = 9-num;
      }
    }
  }
}

