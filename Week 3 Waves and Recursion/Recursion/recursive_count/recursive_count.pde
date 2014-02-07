
float limit = 0;
float x, y;
float interval = 20;

void setup() {
  size(800, 800);  
  background(255);
  noStroke();
  fill(0);
  
  println("Press RIGHT/LEFT to increase/decrease levels of recursion.");
}


void draw() {
  
  // Only count 2x a second
  if (frameCount % 30 == 0) {
    count(0);

    // Start a new row every frame
    x = 0;

    // Scooch down 1 row
    y += interval;
    if (y > height) {
      background(255);
      y = 0;
    }
  }
 
}

void count(int c) {
  // If we've reached the limit, stop counting
  if (c > limit) return;

  // What happens if you comment out the forloop
  // And replace i with c in the text() function?
  for (int i = 0; i < c; i++) {
    float tSize = interval*(1-(c*0.1));
    x += tSize;
    textSize(tSize);
    text(i, x, y);
  }

  // Count again
  count(c+1);
}

void keyPressed() {

  switch(keyCode) {
  case RIGHT:
    limit++;
    break;
  case LEFT:
    limit--;
    break;
  } 
  limit = constrain(limit, 0, 10);
  println("LIMIT: " + limit);
}

