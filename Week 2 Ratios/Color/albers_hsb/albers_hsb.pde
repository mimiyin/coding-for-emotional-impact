Area background;
Area foreground;
int range = 100; // Range of HSB values
boolean back; // Affect background or foreground

void setup() {
  size(600, 600);  
  noStroke();
  rectMode(CENTER);
  colorMode(HSB, range);

  // Initialize ares with random colors and speed
  PVector hsb = new PVector(random(range), 50, 50);
  PVector speed = new PVector(.1, 0, 0);  
  background = new Area(hsb, speed);

  // How would you start out the foreground to be
  // a complementary color to the background?
  PVector fhsb = new PVector(hsb.x, hsb.y, hsb.z);
  foreground = new Area(fhsb, speed);

  println("h/g to +/- hue\t\ts/a to +/- saturation\t\tb/v to +/- brightness.");
  println("Press TAB to affect foreground or background.\t\tENTER to reset.");
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
  
  PVector gap = new PVector(0, 0, 0);
  
  if (key == 'h') gap.x = 1;
  else if(key == 'g') gap.x = -1;
  else if (key == 's') gap.y = 1;
  else if(key == 'a') gap.y = -1;
  else if (key == 'b') gap.z = 1;
  else if(key == 'v') gap.z = -1;
  else if(keyCode == ENTER) foreground.reset(background.hsb);
  else if(keyCode == TAB) back = !back;
  
  if(back) background.update(gap);
  else foreground.update(gap);
  
  println("BACKGROUND HUE: " + background.hsb.x + "\tSATURATION: " + background.hsb.y + "\tBRIGHTNESS: " + background.hsb.z);
  println("FOREGROUND HUE: " + foreground.hsb.x + "\tSATURATION: " + foreground.hsb.y + "\tBRIGHTNESS: " + foreground.hsb.z + "\n");
}

