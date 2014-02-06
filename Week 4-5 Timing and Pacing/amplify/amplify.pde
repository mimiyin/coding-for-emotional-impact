import ddf.minim.*;

Minim minim;
AudioPlayer player;

boolean on;

int mode = 0;
int modes = 3;

float t = 0;
float x = 0;

void setup() {
  size(800, 400);
  background(0);

  minim = new Minim(this);
  player = minim.loadFile("noise.mp3");
  player.play();
}

void draw() {
  if (mode > 0) {
    float value = mode == 0 ? power() : sine();
    player.setGain(value-40);
    
    // Draw amplify graph
    background(0);
    x+=0.5;
    fill(255);
    ellipse(x, height-value, 5, 5);
  }

  else if (on) {
    background(255);
    player.play();
  }
  else {
    background(0);
    player.pause();
  }
}


float power() {
  t+=0.000875;
  return pow(t, 20);
}

float sine() {
  t+=.01;
  return sin(t);
}

void keyPressed() {

  if (key == 32) {
    on = !on;
  }

  switch(keyCode) {
  case UP:
    mode++;
    break;
  case DOWN:
    mode--;
    break;
  }

  mode = constrain(mode, 0, modes);
}

