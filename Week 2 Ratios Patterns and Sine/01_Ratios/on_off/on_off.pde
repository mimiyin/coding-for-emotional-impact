import ddf.minim.*;

Minim minim;
AudioPlayer player;

int counter;
int threshold = 60;
boolean on;

// auto mode
boolean auto;

void setup() {
  size(400, 400);
  minim = new Minim(this);
  player = minim.loadFile("0.mp3");
  
  println("Press TAB to toggle auto mode. Press SPACEBAR to maually turn on/off.");
  println("Use UP/DOWN to adjust threshold in auto mode.");
}

void draw() {
  // Count
  counter++;
  // Toggle on/off every x-counts as defined by the variable threshold
  if (auto && counter % threshold == 0) toggle();

  if (on) {
    background(0);
    player.play();
  }
  else {
    background(255);
    player.pause();
  }
}

void toggle() {
   on = !on; 
}

void label() {
  textAlign(CENTER, CENTER);
  textSize(128);
  fill(on ? 255 : 0);
  text(threshold, width/2, height/2);
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    threshold++;
    label();
    break;
  case DOWN:
    threshold--;
    threshold = constrain(threshold, 1, threshold);  
    label();
    break;
  case TAB:
    auto = !auto;
    if(auto) player.pause();
    break;    
  }
  
  // Space turns it on/off if we're in auto mode
  if(key == 32 && !auto) toggle();
  
  println("auto: " + auto + "\t\tTHRESHOLD: " + threshold);
}

