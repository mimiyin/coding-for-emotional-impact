PVector wave;
PVector beat;

boolean isOn;
float duration;
float count;

float d = 10;

float freq, amp, offset;
float margin = 30;

void setup() {
  // Size the window to fit 2 complete cycles of the sine wave
  size(int(720), 400);

  // Settings for sine wave
  freq = 5;
  amp = height/6;
  offset = calcOffset();
  
  // Draw waveform
  wave = new PVector(0, 0);

  // Draw beat 3/4 down the screen in the middle
  beat = new PVector(width*0.5, width*0.5);

  // Draw background  
  zero();
  
  println("Use UP/DOWN to affect amplitude. RIGHT/LEFT to affect frequency.");
}


void draw() {

  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////// DRAW THE SINE WAVE //////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  // Why is amplitude negative here?
  wave.y = sine(radians(wave.x), freq, amp, amp+margin);

  // Start over
  if (wave.x > width) {
    wave.x = 0;
    zero();
  }

  // Draw the sine wave
  fill(0, 128);
  ellipse(wave.x, wave.y, 1, 1);

  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////// TOGGLE BEAT ACCORDING TO SINE WAVE //////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  // Draw background for bottom half
  fill(255);
  rect(0, height*0.5, width, height*0.5);

  // Turn beat on/off 
  if (isOn && count > duration) {
    wave.x++;
    duration = int(sine(radians(wave.x), freq, amp/10, amp/10));
    isOn = false;
    count = 0;
  }
  else if (!isOn && count > duration) {
    isOn = true;
    count = 0;
  }  

  // Draw beat when on
  if (isOn) {
    fill(0);
    rect(beat.x, beat.y, d, d);
  }

  // Keep counting
  count++;
}

// Calculate sine values
float sine(float t, float f, float a, float o) {
  return sin(f*t)*a + o;
}

void zero() {
  background(200);
  stroke(0, 64);
  line(0, offset, width, offset);
  noStroke();
}

float calcOffset() {
  return amp*2 + margin;
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    amp++;
    break;
  case DOWN:
    amp--;
    break;
  case RIGHT:
    freq++;
    break;
  case LEFT:
    freq--;
    break;
  } 

  if (freq < 1)
    freq = 1;
  if (amp < 0)
    amp = 0;

  offset = calcOffset();
  
  println("AMPLITUDE: " + amp + "\t\tFREQUENCY: " + freq);
}

