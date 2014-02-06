/*
* Taken from processing.org/learning
 */


float x;
float y;
float easing = 0.05;

void setup() {
  size(640, 360);
  textAlign(CENTER); 
  noStroke();
}

void draw() { 
  background(51);

  float targetX = mouseX;
  float dx = targetX - x;
  if (abs(dx) > 1) {
    x += dx * easing;
  }

  float targetY = mouseY;
  float dy = targetY - y;
  if (abs(dy) > 1) {
    y += dy * easing;
  }

  ellipse(x, y, 66, 66);
  text("PRESS UP/DOWN key to adjust easing.", width/2, 20);
  text("EASING FACTOR: " + easing, width/2, 40);
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    easing+=0.001;
    break;
  case DOWN:
    easing-=0.001;
    break;
  }   
  easing = constrain(easing, 0, 1);
}

