// Keep track of threshold
float yth, threshold;

void setup() {
  size(200, 800);
  background(255);
  
  // Start threshold at 50%
  yth = height/2;
  
  drawLines();
  
  println("Use UP/DOWN to move probability threshold up and down.");
}


void draw() {
  // Pick a random x position
  float x = random(width);
  float y;
  
  // Pick a random y position
  // Weighted by the threshold
  if (random(1) < threshold) y = random(0, height/2);
  else y = random(height/2, height);
 
  noStroke();
  fill(0);
  ellipse(x, y, 10, 10);
}


void keyPressed() {
  
  // Reset threshold
  if (keyCode == ENTER) {
    yth = height/2; 
    drawLines();
  }

  // Move threshold up and down
  if (keyCode == UP || keyCode == DOWN) {
    switch(keyCode) {
    case UP:
      yth--;
      break;
    case DOWN:
      yth++;
      break;
    }
    if (yth > height)
      yth = 0;
    else if (yth < 0)
      yth = height;
      
    drawLines();
  }
}

void drawLines() {
  background(255);
  
  // Calculate new threshold
  threshold = yth / height;

  // Black boundary line
  strokeWeight(5);
  stroke(0);
  line(0, height/2, width, height/2);
  
  // Red threshold line
  strokeWeight(1);
  stroke(255, 0, 0);
  line(0, yth, width, yth); 
}  

