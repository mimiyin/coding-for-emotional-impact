float x, y, t, f, a, o;

void setup() {
  size(800, 400);
  background(255);
  f = 1;
  a = height/4;
  o = height/2;
  
  println("Use UP/DOWN to affect amplitude. RIGHT/LEFT to affect frequency.");
}


void draw() {
  if (x > width) {
    x = 0;
    background(255);
  }
  x++;
  t+=f/100;
  y = sin(t)*a + o;
  ellipse(x, y, 1, 1);
}


void keyPressed() {
  switch(keyCode) {
  case UP:
    a++;
    break;
  case DOWN:
    a--;
    break;
  case RIGHT:
    f++;
    break;
  case LEFT:
    f--;
    break;
  }
  
  f = constrain(f, 1, 100);
  a = constrain(a, 0, height/2);
  
  println("AMP: " + a + "\t\tFREQ: " + f);
}

