// Number of Rays
int numRays;

// Center of the Sun
float centerX, centerY;

// Angle of rotation for animation
float a;


void setup() {
  size(600, 600); 
  a = 0; 
  numRays = 100;
  centerX = width/2;
  centerY = height/2;
}

void draw() {
  background(0);
  stroke(255);
  a--;
  translate(centerX, centerY);
  rotate(a);
  for (int i = 0; i < numRays; i++) {
    //Evenly divide the circle by the number of rays you want
    //And rotate by the resulting angle
    rotate(TWO_PI/numRays);
    line(0, 0, 100, 0);
  }
}

