float y, threshold, rx, ry;

void setup() {
  size(200, 800);
  background(255);
  y = height/2;
  drawLines();
}


void draw() {
  rx = random(width);
  if (random(1) < threshold) {
    ry = random(0, height/2);
  }
  else {
    ry = random(height/2, height);
  }
  noStroke();
  fill(0);
  ellipse(rx, ry, 10, 10);
}


void keyPressed() {
  if (keyCode == ENTER) {
    y = height/2; 
    drawLines();
  }

  if (keyCode == UP || keyCode == DOWN) {
    switch(keyCode) {
    case UP:
      y--;
      break;
    case DOWN:
      y++;
      break;
    }
    if (y > height)
      y = 0;
    else if (y < 0)
      y = height;

    threshold = y / height;
    drawLines();
  }
}

void drawLines() {
  background(255);
  strokeWeight(5);
  stroke(0);
  line(0, height/2, width, height/2);
  strokeWeight(1);
  stroke(255, 0, 0);
  line(0, y, width, y);
}  

