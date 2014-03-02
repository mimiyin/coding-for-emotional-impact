// Left and right positions for boundary line
float yb1, yb2;

void setup() {
  size(800, 400);
  background(255);
  yb1 = height/2;
  yb2 = height/2;
  
  println("Use arrow keys to move left (UP/DOWN) and right (RIGHT/LEFT) ends of the boundary line up and down.");
}


void draw() {
  line(0, yb1, width, yb2);
  
  // Calculate the current "slope" of the boundary
  float m = (yb2-yb1)/width;
  
  // Pick a random x position
  float x = random(width);
  // Calcaulte the y-boundary at "x"
  float y = m*x + yb1;
  
  // Pick a y-position above
  // or below the y-boundary
  if (random(1) > .5) {
    y = random(0, y);
  } 
  else {
    y = random(y, height);
  }
  
  // Draw a circle at randomly selected x and y
  fill(0, 100);
  ellipse(x, y, 10, 10);
}


void keyPressed() {
  background(255);
  
  switch(keyCode) {
  case UP:
    yb1--;
    break;
  case DOWN:
    yb1++;
    break;
  case RIGHT:
    yb2--;
    break;
  case LEFT:
    yb2++;
    break;
  }
}

