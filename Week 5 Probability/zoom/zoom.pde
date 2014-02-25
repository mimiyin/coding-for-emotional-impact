boolean zoom;

void setup() {
  size(200, 200);
  fill(0);
  
  println("Press any key to switch between zoom in and zoom out modes.");
}

void draw() {
  background(255);
  
  // Make possible canvas 10x the width and height of window
  // Draw a rect the size of the window
  // Use modulo to make sure the rect "snaps" squarely to the window
  if (zoom) {
    int x = int(random(0, width*10));
    x = x-x%width;  
    int y = int(random(0, height*10));
    y=y-y%height;
    rect(x, y, width, height);
  }
  
  // Pick a random spot to draw a rect
  else {
    int x = int(random(0, width));
    int y = int(random(0, height));
    rect(x, y, 10, 10);
  }
}


void keyPressed() {
  zoom = !zoom;
}

