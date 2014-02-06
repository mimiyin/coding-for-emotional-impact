float range = 10;
float t;

int mode = 0;
int modes = 3;

void setup() {
  size(400, 400);
  noStroke();
  fill(255);
}


void draw() {
  background(0);
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

  float rx = random(-range, range);
  float ry = random(-range, range);

  float x = width/2 + rx;
  float y = height/2 + ry;
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
  if (mode > modes || mode < 0) {
    mode = (modes + abs(mode))%modes;
  }
}

