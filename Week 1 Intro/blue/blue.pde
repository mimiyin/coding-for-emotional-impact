import ddf.minim.*;

int mode = 0;
int modes = 2;

Minim minim;
AudioPlayer [] players = new AudioPlayer [modes];
AudioPlayer player;

PImage [] images = new PImage [modes];
PImage img;

boolean play;
float volume, mult, alpha;
float x, xspeed, xf;

ArrayList <PVector> graph;

void setup() {
  size(800, 600);

  //x-factor to stretch sound wave across screen
  xf = float(width)/1024;

  minim = new Minim(this);

  // Load image
  for (int m = 0 ; m < modes; m++) {
    images[m] = loadImage(m + ".jpg");
    // Resize it to fill out screen
    float ratio = images[m].width/images[m].height;
    images[m].resize(width, int(width*ratio));

    // Load audio file
    players[m] = minim.loadFile(m + ".mp3");
  }

  // Initialize players
  reset();
  
  println("Press SPACEBAR to play/pause. TAB to switch modes.");
}

void draw() {
  background(0);
  tint(255, alpha);
  image(img, 0, -height/3);

  if (play) {
    wave();
  }

  // Draw interpreted graph of piece
  for (PVector pv : graph) {
    ellipse(pv.x, pv.y, 1, 1);
  }
}

void wave() {

  // Draw wave form
  float newVolume = 0;
  float amp = 30;
  for (int i = 0; i < player.bufferSize() - 1; i++) {
    newVolume += (abs(player.left.get(i)) + abs(player.right.get(i))); 
    stroke(255, 100);
    line(i*xf, amp + player.left.get(i)*amp, i*xf, amp + player.left.get(i+1)*amp);
    line(i*xf, amp*2 + player.right.get(i)*amp, i*xf, amp*2 + player.right.get(i+1)*amp);
  }

  if (mode == 1) { 
    // How far along are we in the piece?
    float progress = x/width;

    // Slowly inch up the multiplier for alpha
    // until 80%, then crank it up.
    mult = progress > .8 ? mult*1.01 : 128;    
    alpha = progress*mult;

    println("PROGRESS: " + progress + "\tMULT: " + mult + "\tALPHA: " + alpha);
  }
  else {
    // Calculate direction and magnitude of change in sound
    float delta = newVolume-volume;

    //If getting softer, reset multiplier
    if (delta < 0) mult = 0;

    // Gain speed faster than you lose it
    mult += (delta > 0 ? delta : 1)*0.001;
    float aspeed = volume*mult;

    // How quickly does alpha decay all by its onesies?
    alpha*=.9;

    // Give alpha a boost, just for
    // making progress across the screen
    alpha += aspeed + x*.01;
    if (alpha < 1)
      alpha = 1;
    println("MULT: " + mult + "\tALPHA: " + alpha + "\tASPEED: " + aspeed);
  }

  // Move the ball across the screen
  x += xspeed;

  // Map alpha to height to calculate the y-position of the ball
  float y = map(alpha, 0, 255, 0, height);
  fill(255);
  ellipse(x, y, 10, 10);

  // Add location to graph arraylist
  graph.add(new PVector(x, y));

  noStroke();
  volume = newVolume;
}

void reset() {

  // Reset
  background(0);
  x = 0;
  mult = 0;
  alpha = 0;
  
  player = players[mode];
  img = images[mode];
  
  if (play) player.play();

  // Base the progression of white ball
  // on duration of music
  float duration = player.length()/1000;
  xspeed = (width/duration)/frameRate;
  
  // Empty out graph arraylist
  graph = new ArrayList<PVector>();
}

void keyPressed() {
  // Play/pause with spacebar
  if (key == 32) {
    play = !play;
    if (play) {    
      player.play();
      alpha = 0;
    }
    else {
      player.pause();
    }
  }

  switch(keyCode) {
  case TAB: 
    mode++;
    mode%=modes;
    player.pause();
    reset(); 
    break;
  }
  
  println("MODE: " + mode);
}

