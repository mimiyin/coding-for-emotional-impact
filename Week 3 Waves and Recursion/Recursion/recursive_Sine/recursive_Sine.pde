import java.text.DecimalFormat;

float x, y, prevX, prevY; // Location of drawing
float tx, ty; // Translate to middle of screen

int limit = 2; // Levels of recursion
float frequency = 0.01;
float amplitude = 5;
float offset = 0;

// Multipliers for freq and amp
float fm = 1;
float am = 1;

// Sine objects for x and y speeds
Sine xWave = new Sine(PI/2, frequency, amplitude, offset, fm, am);
Sine yWave = new Sine(0, frequency, amplitude, offset, fm, am);

boolean erase; // Erase every frame?
boolean auto; // Auto-mode
float t; // Theta for auto mode

void setup() {
  size(800, 800); 
  background(255);
  tx = width/2;
  ty = height/2;
  noiseSeed(0);
  noiseDetail(4, .67);
}

void draw() {

  if (erase) background(0);

  // Change levels of recursion automatically
  if (auto) {
    t+=.001;
    limit += noise(t);
    limit = int(limit%3);
  }

  // Wrap line around edges
  if (x > tx || x < -tx || y > ty || y < -ty) {    
    if (x > tx) {
      x = -tx;
      prevX = x;
    }   
    else if (x < -tx) {
      x = tx;
      prevX = x;
    } 
    if (y > ty) { 
      y = -ty;
      prevY = y;
    }
    else if (y < -ty) {
      y = ty;
      prevY = y;
    }
  }

  // Calculate and add speed
  x += xWave.wave(0);
  y += yWave.wave(1);

  // Draw line connecting current position to position in previous frame
  pushMatrix();
  translate(tx, ty);
  strokeWeight(2);
  stroke(255, 200, 0, 128);
  line(x, y, prevX, prevY);
  noStroke();
  popMatrix();

  // Capture x,y for next frame
  prevX = x;
  prevY = y;

  // Draw label
  label();
}


void label() {
  fill(0);
  rect(0, 0, width, 30);
  fill(255);
  text("Press ENTER to toggle AUTO: " + auto + "\t\t\t\u2B0C LIMIT: " + limit + "\t\t\tf/v FREQ: " + new DecimalFormat("##.###").format(frequency) + "\t\t\ta/z AMP: " + amplitude + "\t\t\t+/_ fm: " + new DecimalFormat("##.##").format(fm) + "\t\t\t=/- am: " + new DecimalFormat("##.##").format(am), 10, 20);
}

void reset() {
  limit = constrain(limit, 0, 10);
  xWave.reset();
  yWave.reset();
}

void keyPressed() {

  switch(keyCode) {
  case RIGHT:
    auto = false;
    limit++;
    reset();
    break;
  case LEFT:
    auto = false;
    limit--;  
    reset();
    break;
  case TAB:
    erase = !erase;
    break;
  case ENTER:
    auto = true;
    break;
  }

  if (key == 'f' || key == 'v') {
    frequency += (key == 'f' ? 0.001 : -0.001);
    frequency = constrain(frequency, 0.001, PI);
    xWave.setF(frequency);
    yWave.setF(frequency);
  }
  else if (key == 'a' || key == 'z') {
    amplitude += (key == 'a' ? 1 : -1);
    amplitude = constrain(amplitude, 0, width);
    xWave.setA(amplitude);
    yWave.setA(amplitude);
  }
  else if (key == '+' || key =='_') {
    fm += (key == '+' ? 1 : -1)*(int(fm) <= 1 ? .1 : 1);
    fm = constrain(fm, .1, 10);
    yWave.setFm(fm);
  }
  else if (key == '=' || key == '-') {
    am += (key == '=' ? 1 : -1)*(int(am) <= 1 ? .1 : 1);
    am = constrain(am, .1, 10);
    yWave.setAm(am);
  }
}

