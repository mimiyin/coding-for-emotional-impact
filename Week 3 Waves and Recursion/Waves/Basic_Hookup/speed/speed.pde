float x, y;
float xspeed;
Wave xsWave = new Wave(0, .1, 10, 0);

void setup() {
  size(400, 400);
  background(0);
  y = height/2;
}

void draw() {
  xspeed = xsWave.wave();  
  x += xspeed;
  ellipse(x, y, 5, 5);
}

