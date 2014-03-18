float zenoX, zenoY;
float d = 10;

float graphX;

void setup() {
  size(800, 600);
  zenoY = height/2;

  background(0);
  noStroke();
}


void draw() {
  // Black out Zeno's trail
  fill(0, 200);
  rectMode(CENTER);
  rect(width/2, height/2, width, d); 
  
  // Draw Zeno's location
  fill(255);
  ellipse(zenoX, zenoY, d, d);
  
  // Change Zeno's speed to be 1% of the remaining distance between zeno and wall
  float zenoSpeed = (width - zenoX)*0.01;
  zenoX += zenoSpeed;
  graphX++;

  // Draw graph of Zeno's speed
  ellipse(graphX, height-(zenoSpeed*100), 1, 1);

  // Erase text label area in upper right-hand corner every frame
  fill(0);
  rectMode(CORNER);
  int rightOffset = 240;
  rect(width-rightOffset, 0, rightOffset, 60);
  // Print location and speed to the screen 
  fill(255);
  int leftAlign = width-rightOffset;
  text("ZENO'S X-LOCATION: " + zenoX, leftAlign, 20);
  text("ZENO'S SPEED: " + zenoSpeed, leftAlign, 40);

  // Why is there that black gap in the graph of Zeno's speed?
}

