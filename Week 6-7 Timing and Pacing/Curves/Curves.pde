// Keep track of which Curve we're using
int mode = 0;
int modes = 6;
Curve curve;

// Keep track of intervals
boolean isOn;
float duration;
int count;

// To draw the curve
float x, y;

// Diameter of circle, tied to timing curve
int diameter;

void setup() {
  size(800, 400);
  reset();
}

void draw() {

  if (isOn) fill(255, 0, 0);
  else fill(255);
  ellipse(width/2, height/2, diameter, diameter);

  if (count >= duration*0.01) {
    duration = calc();
    diameter++;
    isOn = !isOn;
    count = 0;
    display();
  }
  count++;
}

void display() {
  x++;
  y = height-duration;
  noStroke(); 
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);
}

float calc() {
  return map(curve.run(), 0, height, 0, 360);
}

void reset() {
  background(0);
  diameter = 0;
  x = 0;
  
  float t, speed, scale;

  switch(mode) {
  case 0:
    t = 0;
    speed = 1;
    scale = (float)height/(float)width;
    curve = new Linear(t, speed, scale);  
    break;  
  case 1:
    t = 0;
    speed = 0.01; // rate of ascent (pacing)
    scale = 10; // how soon curve ascends (timing)
    curve = new Geometric(t, speed, scale);
    break;
  case 2:
    t = 0;
    speed = 0.005;
    scale = 20; // sharpness of spike
    curve = new Exponential(t, speed, scale);
    break;
  case 3:
    t = 0;
    speed = 1;
    scale = 50; // height of asymptote
    curve = new Logarithmic(t, speed, scale);
    break;
  case 4:
    t = -7.5;
    speed = 0.025;
    scale = 0;
    curve = new Sigmoid(t, speed, scale);
    break;
  case 5:
    t = 0;
    speed = 0.1; 
    scale = 50;   
    curve = new Bounce(t, speed, scale);
    break;
  }  

  println("MODE: " + curve.getClass());
}


void keyPressed() {

  switch(keyCode) {
  case RIGHT:
    mode++;
    break;
  case LEFT:
    mode--;
    break;
  }

  if (mode >= modes || mode < 0) {
    mode = (modes + mode%modes)%modes;
  }

  reset();
}

