/*
* Taken from processing.org/learning
 */


PVector loc = new PVector(0, 0);
float easing = 0.05;

void setup() {
  size(640, 360);
  textAlign(CENTER); 
  noStroke();
}

void draw() { 
  background(51);

  PVector target = new PVector(mouseX, mouseY);
  PVector diff = PVector.sub(target, loc);
  if(diff.mag() > 1) {
    diff.mult(easing);
    loc.add(diff);
  }
  
  ellipse(loc.x, loc.y, 66, 66);
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

