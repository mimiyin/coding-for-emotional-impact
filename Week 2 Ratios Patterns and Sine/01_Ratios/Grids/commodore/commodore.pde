// Size of window, keep it square
int s = 400;

// Initialize the text to be nothing.
String text = "";

// Set font-size to 20
int tSize = 20;

// Modulo Thresholds
int[] ints = new int[4];

void setup() {

  // Create a window 400 pixels wide by 400 pixels tall
  size (s, s);

  // Set the text color to white
  fill(255);

  // Set textsize 
  textSize(tSize);
  textAlign(CENTER, CENTER);
  randomSeed(0);
  for (int i = 0; i < ints.length; i++) {
    ints[i] = int(random(1, 20));
  }
  println("Use mouse position to control number of cols and rows."); 
  println("Use 1,q | 2,w | 3,e | 4,r to adjust intervals.");
}

void draw() {
  background(0);
  // Display text in a grid
  // Start off-screen and end off-screen
  // by amounts based on text-size
  for (int x = 0; x <= width; x+=tSize/(mouseX*.01)) {
    for (int y = 0; y <= height; y +=tSize/(mouseY*.01)) {

      // calculate col and row position of text
      int col = (int) x / tSize;
      int row = (int) y / tSize;

      // Use modulo to play with different text

      // write "=" every 42nd column
      if (col%ints[0] == 0)
        text = "=";

      // Or write "^" every 18th row
      else if (row%ints[1] == 0)
        text = "^";

      // Or write ")" every 37th column
      else if (col%ints[2] == 0)
        text = ")";

      // Or write "(" every 6th row
      else if (row%ints[3] == 0)
        text = "(";

      // Otherwise write ">"
      else
        text = ">";

      text(text, x, y);
    }
  }
}

void keyPressed() {

  if (key == '1') {
    ints[0]++;
  }
  else if (key == 'q') {
    ints[0]--;
  }

  else if (key == '2') {
    ints[1]++;
  }
  else if (key == 'w') {
    ints[1]--;
  }
  else if (key == '3') {
    ints[2]++;
  }
  else if (key == 'e') {
    ints[2]--;
  }
  else if (key == '4') {
    ints[3]++;
  }
  else if (key == 'r') {
    ints[3]--;
  }

  for (int i = 0; i < ints.length; i++) {
    ints[i] = constrain(ints[i], 1, s);
    print(i + ": " + ints[i] + "\t");
  }
  print("\n");
  
}

