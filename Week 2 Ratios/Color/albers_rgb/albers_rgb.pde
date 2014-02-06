Area background;
Area foreground;
float range = 255;
boolean back;

void setup() {
  size(600, 600);  
  noStroke();
  rectMode(CENTER);
  
  // Initialize ares with random colors and speed
  
  float speed = 1;
  PVector rgb = new PVector(0, 0, 0);
  PVector ratios = new PVector(1, .5, 1);
  background = new Area(rgb, ratios, speed); 
  foreground = new Area(rgb, ratios, speed);
  
  println("r/e to +/- red\t\tg/f to +/- green\t\tb/v to +/- blue.");
  println("Press TAB to affect foreground or background.");
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
  
  if (key == 'r') gap.x = .1;
  else if(key == 'e') gap.x = -.1;
  else if (key == 'g') gap.y = .1;
  else if(key == 'f') gap.y = -.1;
  else if (key == 'b') gap.z = .1;
  else if(key == 'v') gap.z = -.1;
  else if(keyCode == TAB) back = !back;
  
  if(back) background.update(gap);
  else foreground.update(gap);
  
  println("BACKGROUND RED: " + background.r.r + "\tGREEN: " + background.g.r + "\t\tBLUE: " + background.b.r);
  println("FOREGROUND RED: " + foreground.r.r + "\tGREEN: " + foreground.g.r + "\t\tBLUE: " + foreground.b.r + "\n");
  
}

