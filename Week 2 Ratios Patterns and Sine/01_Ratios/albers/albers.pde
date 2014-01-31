Area background;
Area foreground;
int top, bottom;

void setup() {
  size(600, 600);  
  noStroke();
  rectMode(CENTER);

  top = 200;
  bottom = 100;
  
  // Initialize ares with random colors and speed
  PVector rgb = new PVector(random(255), random(255), random(255));
  PVector speed = new PVector(random(1), random(1), random(1));  
  background = new Area(rgb, speed);
  
  // Play around with these numbers to change the color 
  // relationship between background and foreground
  rgb.mult(.5);
  speed.mult(.1);
  foreground = new Area(rgb, speed);
  
  println("Affect range of color with arrow keys.");
  println("UP/DOWN to increase/decrease range.");
  println("RIGHT/LEFT to move the range up and down");
}


void draw() { 

  // Get and set the background color
  PVector b = background.run();
  background(b.x, b.y, b.z);

  // Get and set the foreground color
  PVector f = foreground.run();
  fill(f.x, f.y, f.z);

  // Draw the rect
  rect (width/2, height/2, width/2, height/2);
}  
  

void keyPressed() {
  switch(keyCode) {
  case UP:
    top++;
    bottom--;
    break;

  case DOWN:
    top--;
    bottom++;
    break;

  case RIGHT:
    top++;
    bottom++;
    break;

  case LEFT:
    top--;
    bottom--;
    break;
  }

  top = constrain(top, 0, 255);
  bottom = constrain(bottom, 0, 255);
  
  if(top-bottom < 0) {
     int t = top;
     top = bottom;
     bottom = t; 
  }
  
  println("TOP: " + top + "\t\tBOTTOM: " + bottom);
}

