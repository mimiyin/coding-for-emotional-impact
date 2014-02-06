float y1, y2, px, py;

void setup() {
  size(800, 400);
  background(255);
  y1 = height/2;
  y2 = height/2;
}


void draw() {
  line(0, y1, width, y2);

  float m = (y2-y1)/width;
  px = random(width);
  py = m*px + y1;

  if (random(1) > .5) {
    py = random(0, py);
  } 
  else {
    py = random(py, height);
  }
  fill(0, 100);
  ellipse(px, py, 10, 10);
}


void keyPressed() {
  background(255);


  switch(keyCode) {
  case UP:
    y1--;
    break;
  case DOWN:
    y1++;
    break;
  case RIGHT:
    y2--;
    break;
  case LEFT:
    y2++;
    break;
  }
}

