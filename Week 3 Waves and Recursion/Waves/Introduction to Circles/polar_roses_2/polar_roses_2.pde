float x, y; // Location x and y
int xa, ya; // Amplitude for x and y
int xf, yf; //  Frequency for x and y

// Changing the radius for x and y
float rx, ry; 
int rxa, rya; 
int rxf, ryf;

float t; //Radians - where are we along the circumference of the circle?

// Modes for the controls
int mode;
String [] modes = {
  "X", "Y", "RX", "RY"
};

void setup() {
  size(600, 600);
  background(255);
  noStroke();
  fill(255, 0, 0);

  xf = 1;
  yf = 1;
  xa = 10;
  ya = 10;
  rxa = 10;
  rya = 10;
  

  println("Press TAB to cycle thought adjusting X, Y, RX, RY. ENTER to clear screen.");
  println("UP/DOWN to adjust amplitude.\tRIGHT/LEFT to adjust frequency.");
}


void draw() {
  // Keep moving around the circle
  t+=0.01; 
  // Calculate location with sin and cos
  rx = cos(rxf*t)*rxa;
  ry = cos(ryf*t)*rya;
  x = cos(t*xf)*xa*rx;
  y = sin(t*yf)*ya*ry; 
  // Translate to the center of the window
  translate(width/2, height/2);
  // Draw!
  ellipse(x, y, 3, 3);
  
}

void adjustAmp(int adjustment) {
  switch(mode) {
  case 0:
    xa+=adjustment;
    break;
  case 1:
    ya+=adjustment;
    break;
  case 2:
    rxa+=adjustment;
    break;
  case 3:
    rya+=adjustment;
    break;
  } 

  xa = constrain(xa, 0, width);
  ya = constrain(ya, 0, width);
  rxa = constrain(rxa, 0, width);
  rya = constrain(rya, 0, width);
}

void adjustFreq(int adjustment) {
  switch(mode) {
  case 0:
    xf+=adjustment;
    break;
  case 1:
    yf+=adjustment;
    break;
  case 2:
    rxf+=adjustment;
    break;
  case 3:
    ryf+=adjustment;
    break;
  }

  xf = constrain(xf, 0, 100);
  yf = constrain(yf, 0, 100);
  rxf = constrain(rxf, 0, 100);
  ryf = constrain(ryf, 0, 100);
}

void keyPressed() {
  switch(keyCode) {
  case UP:
    adjustAmp(1);
    break;
  case DOWN:
    adjustAmp(-1);
    break;
  case RIGHT:
    adjustFreq(1);
    break;
  case LEFT:
    adjustFreq(-1);
    break;
  case TAB:
    mode++;
    if (mode >= modes.length) mode = 0;
    else if (mode < 0) mode = modes.length-1;
    break;
  case ENTER:
    background(255);
    break;
  }

  println("ADJUSTING " + modes[mode]);
  println("X-AMP: " + xa + "\t\tY-AMP: " + ya + "\t\tX-FREQ: " + xf + "\t\tY-FREQ: " + yf);
  println("RX-AMP: " + rxa + "\t\tRY-AMP: " + rya + "\t\tRX-FREQ: " + rxf + "\t\tRY-FREQ: " + ryf + "\n");

}

