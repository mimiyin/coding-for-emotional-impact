float x, y;
float t, speed, a, o;

void setup() {
  size(800, 400);
  // How would we calculate speed so that
  // we always do 1 complete sine wave
  // across the width of the screen?
  speed = 0.01;
  a = 100;
  
  background(255);
  fill(0);
  
}


void draw() {
  x++;
  t+=speed;
  // What would happen if we changed the speed?
  // What would happen if we changed amplitude?
  
  y = sin(t)*a + o;
  ellipse(x, y + height/2, 10, 10);
}

