
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


void setup() {
  size(800, 600); 
  background(255);
  tx = width/2;
  ty = height/2;
}

void draw() {
  // erase
  background(0);
  
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
  
  float plimit = limit;
  // Change the limit slowly with some randomness
  limit += random(-0.01, 0.01);
  
  if(limit >= indices.length-1) limit = 0;
  else if(limit < 0) limit = indices.length-1;

  // If the limit has changed
  if(int(limit) < int(plimit)) reset();
  

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

// You need to call this if you're going to change the limit variable
void reset() {
  limit = constrain(limit, 0, indices.length-1);
  xCursor.reset();
  yCursor.reset();
}

