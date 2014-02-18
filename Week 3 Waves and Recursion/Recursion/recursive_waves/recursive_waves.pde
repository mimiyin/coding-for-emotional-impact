// Control how many times to recurse
// Control which wave to use at which level of recursion
// Control whether to modulate freq or amp

float x, y, prevX, prevY;
float tx, ty;

int level;
int limit = 0;
float frequency = 0.01;
float amplitude = 5;
float offset = 0;

// Keep track of wave types for leach level of recursion
int [] indices = { 
  0, 1, 2, 3, 4
};

String [] types = { 
  "SIN", "COS", "SQU", "SAW", "TAN"
};

boolean erase;

Cursor xCursor = new Cursor(PI/2, frequency, amplitude, offset);
Cursor yCursor = new Cursor(0, frequency, amplitude, offset);

void setup() {
  size(800, 600); 
  background(255);
  tx = width/2;
  ty = height/2;
}

void draw() {
  
  if(erase) background(0);

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
  strokeWeight(2);
  stroke(255, 200, 0);
  line(x, y, prevX, prevY);
  noStroke();
  popMatrix();
  
  // Store location for next frame
  prevX = x;
  prevY = y;

  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);
  text("\u2B0C to adjust levels of recursion: " + (limit+1), 10, 20);
  text("Press NUM KEY and \u2B0D to change wave type at each recursion level: (1) " + types[indices[0]] + "\t(2) " + types[indices[1]] + "\t(3) " + types[indices[2]] + "\t(4) " + types[indices[3]] + "\t(5) " + types[indices[4]], 10, 40);
}

void display(float yoff, float y) {
  pushMatrix();
  translate(0, yoff);
  line(x, 0, x, y);
  popMatrix();
}

void reset() {
  limit = constrain(limit, 0, indices.length-1);
  xCursor.reset();
  yCursor.reset();
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    indices[level]++;
    break;
  case DOWN:
    indices[level]--;
    break;
  case RIGHT:
    limit++;
    reset();
    break;
  case LEFT:
    limit--;
    reset();
    break;
  case ENTER:
    erase = !erase;
    break;
  }

  if (keyCode == UP || keyCode == DOWN) {
    indices[level] = constrain(indices[level], 0, indices.length-1);
  }    
  else {
    int k = parseInt(key)-49;
    if (k >=0 && k < indices.length) {
      level = k;
    }
  }
}

