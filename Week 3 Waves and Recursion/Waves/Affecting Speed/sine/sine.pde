// Use sine wave to determine speed and direction of moving object

PVector wave;
PVector mover;
PVector speed;
float theta;

float d = 10;
float freq, amp, offset;

void setup() {
  // Size the window to fit 2 complete cycles of the sine wave
  size(int(720), 400);

  // Settings for sine wave
  freq = 1;
  amp = height/6;
  offset = height/4;
  
  wave = new PVector(0,0);

  // Draw ball half-way down the window
  mover = new PVector(0, height*0.5);
  speed = new PVector(0,0);

  // Draw y=0 line for sine wave
  zero();

  println("Use UP/DOWN to affect amplitude. RIGHT/LEFT to affect frequency.");
}


void draw() {

  // Move around the "circle" 1-degree at a time
  theta+=TWO_PI/360;


  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////// DRAW THE SINE WAVE //////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////


  // Why is amplitude negative here?
  wave.y = sine(theta, freq, -amp, offset);
  wave.x++; 

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
  ///////////////////// MOVE THE BALL ACCORDING TO SINE WAVE /////////////////////
  ////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////

  // Draw background for bottom half
  fill(255);
  rect(0, height*0.5, width, height*0.5); 

  // Affect speed with the sine wave
  // Try both versions, what's the difference?
  speed.x = sine(theta, freq, amp, 0); 
  //speed.x = sine(theta, freq, amp, amp); 

  if (mover.x > width) {
    mover.x = 0;
  }
  else if (mover.x < 0) {
    mover.x = width;
  }

  // Move the rect
  mover.add(speed);

  // Draw the sine wave
  fill(0);
  rect(mover.x, mover.y, d, d);
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

  // Don't let freq and amp go below zero
  if (freq < 1)
    freq = 1;
  if (amp < 0)
    amp = 0;

  println("AMPLITUDE: " + amp + "\t\tFREQUENCY: " + freq);
}

