boolean zoom;

void setup() {
  size(200, 200);
  fill(0);
}

void draw() {
  background(255);

  if (zoom) {
    int x = int(random(0, width*10));
    x = x-x%width;  
    int y = int(random(0, height*10));
    y=y-y%height;
    rect(x, y, width, height);
  }
  else {
    int x = int(random(0, width));
    int y = int(random(0, height));
    rect(x, y, 10, 10);
  }
}


void keyPressed() {
  zoom = !zoom;
}

