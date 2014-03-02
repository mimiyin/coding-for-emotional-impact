// X-position of line
float x;
// Time position along noise curve
float t;

// Octaves determines number of noise functions you add together
int manOct;

// Falloff is relative strength of each additional octave
float manFall;

String mode = "Preset";
Line [] lines = new Line[4];
int bg = 24;


void setup() {
  size(800, 400);
  background(bg);
  noiseSeed(0);
  noStroke();

  for (int i = 0; i < lines.length; i++) {
    lines[i] = new Line(i);
  }
}


void draw() {
  // Wrap around when you get to the right edge of window
  if (x > width) {
    background(bg);
    x = 0;
  }

  // Keep moving across the window
  x++;

  // Keep moving along the noise function
  t+=.01;

  // Draw noise lines
  for (Line l : lines) {
    l.update();
    l.display();
  }
}

void keyPressed() {

  mode = "Preset";
  if (keyCode == UP || keyCode == DOWN ||keyCode == RIGHT || keyCode == LEFT) {
    switch(keyCode) {
    case UP:
      manOct++;
      mode = "Octaves";
      break;
    case DOWN:
      manOct--;
      mode = "Octaves";
      break;
    case RIGHT:
      manFall+=.1;
      mode = "Falloff";
      break;
    case LEFT:
      manFall-=.1;
      mode = "Falloff";
      break;
    }

    manOct = constrain(manOct, 1, 20);
    manFall = constrain(manFall, 0.01, 1);

    // Update all of the lines
    for (Line l : lines) {
      l.modulate(manOct, manFall);
    }

  }
}

