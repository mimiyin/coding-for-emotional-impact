// Constrain range of random in 3 different ways
float range = 100;

// Theta for trig functions
float t;

// Keep track of modes
int mode = 0;
int modes = 3;

void setup() {
  size(400, 400);
  noStroke();
  fill(255);
}


void draw() {
  background(0);
  
  // Calculate range differently
  // depending on which mode you're in
  switch(mode) {
  case 1:
    t+=0.01;
    range = sin(t)*width*2 + ((width*2)+1);
    break;
  case 2:
    t+=0.05;
    range = tan(t)*width*2;
    range = constrain(range, 1, width*2);
    break;
  default:
    break;
  }
  
  // Select random x, y locations according to range
  float x = random(-range, range);
  float y = random(-range, range);
  translate(width/2, height/2);
  
  // Draw ellipse at x,y
  // Scale size to range - gives illusion of 3D
  ellipse(x, y, range, range);
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
    mode = (modes + abs(mode))%modes;
  }
  
  println("MODE: " + mode);
}

