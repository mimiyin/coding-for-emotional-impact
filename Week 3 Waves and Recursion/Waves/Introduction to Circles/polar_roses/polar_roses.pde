
float x, y; // Location x and y
float xa, ya; // Amplitude for x and y
float xf, yf; //  Frequency for x and y
float t; //Radians - where are we along the circumference of the circle?

boolean adjustX; // Whether we're adjusting X or Y frequency/amplitude

void setup() {
  size(600, 600);
  background(255);
  noStroke();
  fill(255, 0, 0);
  
  xf = 1;
  yf = 1;
  xa = 10;
  ya = 10;
  
  println("Press TAB to switch between adjusting X and Y. ENTER to clear screen.");
  println("UP/DOWN to adjust amplitude.\tRIGHT/LEFT to adjust frequency.");  
}


void draw() {
  // Keep moving around the circle
  t+=0.01; 
  // Calculate location with sin and cos
  x = cos(t*xf)*xa*10;
  y = sin(t*yf)*ya*10; 
  // Translate to the center of the window
  translate(width/2, height/2);
  // Draw!
  ellipse(x, y, 1, 1);
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    if(adjustX) xa++; else ya++;
    break;
  case DOWN:
    if(adjustX) xa--; else ya--;
    break;
  case RIGHT:
    if(adjustX) xf++; else yf++;
    break;
  case LEFT:
    if(adjustX) xf--; else yf--;
    break;
  case TAB:
    adjustX = !adjustX;
    println("ADJUSTING " + (adjustX ? "X" : "Y"));
    break;
  case ENTER:
    background(255);
    break;
  }

  xa = constrain(xa, 0, width);
  ya = constrain(ya, 0, width);
  xf = constrain(xf, 0, 10);
  yf = constrain(yf, 0, 10);
  
  println("X-AMP: " + xa + "\t\tY-AMP: " + ya + "\t\tX-FREQ: " + xf + "\t\tY-FREQ: " + yf); 
}

