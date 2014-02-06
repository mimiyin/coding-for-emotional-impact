float x, t, manFall;
int manOct;
String mode = "Auto";
Line [] lines = new Line[4];
int bg = 24;


void setup() {
  size(800, 400);
  background(bg);
  noiseSeed(0);
  noStroke();

  for (int i = 0; i < lines.length; i++) {
    lines[i] = new Line(i);
  }
}


void draw() {
  if (x > width) {
    background(bg);
    x = 0;
  }
  x++;
  t+=.01;
  for (int i = 0; i < lines.length; i++) {
    lines[i].update();
    lines[i].display();
  }
}

void keyPressed() {

  mode = "Preset";

  switch(keyCode) {
  case UP:
    manOct++;
    mode = "Octaves";
    break;
  case DOWN:
    manOct--;
    mode = "Octaves";
    break;
  case RIGHT:
    manFall+=.1;
    mode = "Falloff";
    break;
  case LEFT:
    manFall-=.1;
    mode = "Falloff";
    break;
  }

  manOct = constrain(manOct, 1, 20);
  manFall = constrain(manFall, 0.01, 1);
}

