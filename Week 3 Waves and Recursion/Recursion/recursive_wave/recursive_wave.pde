import java.text.DecimalFormat;

float x, y, prevX, prevY; // Location of drawing
float tx, ty; // Translate to middle of screen

float theta;

float limit = 2; // Levels of recursion
float frequency = 1;
float amplitude = 5;
float offset = 0;

// Multipliers for freq and amp
float fm = 1;
float am = 1;

boolean erase; // Erase every frame?
boolean auto; // Auto mode?
float t; // Theta for auto mode

void setup() {
  size(800, 800); 
  background(255);
  fill(0);  
  tx = width/2;
  ty = height/2;
}

void draw() {
  
  if(erase) background(0);
  
  // Advance around the circle
  // Why are we modulo-ing by TWO_PI?
  // What happens if we don't?
  theta += 0.01;
  theta %= TWO_PI;

  // Wrap around the edges
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

  if (auto) {
    t+=0.0001;
    limit += abs((cos(t)*tan(t) + 1)*.01); 
    limit%=3;
  }
  
  // Calculate speed for x and y with recursive wave functions
  float xspeed = wave(theta, frequency, amplitude, offset, limit, 0);
  float yspeed = wave(theta-PI/2, frequency*fm, amplitude*am, offset, limit, 0);
  
  // Graph y-speed  
  //ellipse(theta*100%width, yspeed + (100+(theta*10000/width)), 1, 1);
  
  // Move to draw!
  x += xspeed;
  y += yspeed;

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
  text("Press ENTER to toggle AUTO: " + auto + "\t\t\t\u2B0C LIMIT: " + int(limit) + "\t\t\tf/v FREQ: " + new DecimalFormat("##.##").format(frequency) + "\t\t\ta/z AMP: " + amplitude + "\t\t\t+/_ fm: " + new DecimalFormat("##.##").format(fm) + "\t\t\t=/- am: " + new DecimalFormat("##.##").format(am), 10, 20);
}

//Recursive wave function
float wave(float t, float f, float a, float o, float l, float c) {
  if (c >= l) {
    return sine(t, f, a, o);
  }
  else {
    c++;
    // Calculate freq and amp by calling the recursive wave function
    float _f = wave(t, f, a, o, l, c);
    float _a = wave(t, f, a, o, l, c); 
    return sine(t, _f, _a, o);
  }
}

float sine(float t, float f, float a, float o) {
  return sin(f*t)*a + o;
}

void keyPressed() {
  switch(keyCode) {
  case RIGHT:
    limit++;
    break;
  case LEFT:
    limit--;
    break;
  case TAB:
    erase = !erase;
    break;
  case ENTER:
    auto = !auto;
    break;
  }

  limit = constrain(limit, 0, 5);
  
  if (key == 'f' || key == 'v') {
    frequency += key == 'f' ? 0.01 : -0.01;
    frequency = constrain(frequency, 0.01, PI);
  }
  else if (key == 'a' || key == 'z') {
    amplitude += (key == 'a' ? 1 : -1);
    amplitude = constrain(amplitude, 0, width);
  }
  else if(key == '+' || key =='_') {
    fm += (key == '+' ? 1 : -1)*(int(fm) <= 1 ? .1 : 1);
    fm = constrain(fm, .1, 10);
  }
  else if(key == '=' || key == '-') {
    am += (key == '=' ? 1 : -1)*(int(am) <= 1 ? .1 : 1);
    am = constrain(am, .1, 10);
  }    
}

