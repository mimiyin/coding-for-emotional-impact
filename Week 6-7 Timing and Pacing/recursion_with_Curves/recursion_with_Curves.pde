
// Where we are and where we were
float x, y, prevX, prevY;
// Where to translate so we can be seen on the screen
float tx, ty;

// How many times are we recursing
float limit = 0;

// Basic stuff for wave functions
float frequency = 0.01;
float amplitude = 5;
float offset = 0;

Cursor xCursor = new Cursor(PI/2, frequency, amplitude, offset);
Cursor yCursor = new Cursor(0, frequency, amplitude, offset);

// Keep track of wave types for leach level of recursion
int [] indices = { 
  0, 1, 3, 2, 4
};


// Timer Curve
Curve curve = new Sigmoid(-7.5, 0.025);
float duration;
int count;

void setup() {
  size(800, 600); 
  background(255);
  tx = width/2;
  ty = height/2;
}

void draw() {
  // erase
  background(0);
  
   if (count >= duration) {
    duration = calc();
    change();
    count = 0;
  }
  count++;
  
  // Wrap
  if (x > tx || x < -tx || y > ty || y < -ty) {
    if (x > tx) {
      x = -tx;
    }   
    else if (x < -tx) {
      x = tx;
    } 
    if (y > ty) { 
      y = -ty;
    }
    else if (y < -ty) {
      y = ty;
    }
    prevX = x;
    prevY = y;
  }
  
  
  
  

  // Calculate speed
  float xspeed = xCursor.run(0);
  float yspeed = yCursor.run(0);

  // Calculate new location
  x += xspeed;
  y += yspeed;

  // Draw line
  pushMatrix();
  translate(tx, ty);
  strokeWeight(10);
  stroke(255, 200, 0);
  line(x, y, prevX, prevY);
  noStroke();
  popMatrix();
  
  // Store location for next frame
  prevX = x;
  prevY = y;
}

void change() {
  limit+= random(-1, 5);
  if(limit > 5) limit = 0;
  if(limit < 0) limit = 5;
  reset();  
}

float calc() {
  return map(curve.run(), 0, height, 0, 360);
}

// You need to call this if you're going to change the limit variable
void reset() {
  limit = constrain(limit, 0, indices.length-1);
  xCursor.reset();
  yCursor.reset();
}

