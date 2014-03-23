
// power controls how steep the spike is
// bspeed controls how long it takes to spike
float x, y;
float base, speed, power, n;

int mode = 0;
int modes = 6;

boolean down;

void setup() {
  size(800, 400);
  reset();
}

void draw() {
  x++;
  float value = curv();
  y = down ? value : height-value;
  noStroke(); 
  fill(255);
  ellipse(x, y, 10, 10);
  label();
}

float curv() {
  switch(mode) {
  case 1:
    return geometric();
  case 2:
    return exponential();
  case 3:
    return logarithmic();
  case 4:
    return sigmoid();
  case 5:
    return bounce();
  default:
    return linear();
  }
}

void label() {
  String label = "MODE: " + mode + "\ndown: " + down + "\nBASE: " + base + "\nSPEED: " + speed + "\npower: " + power;
  int tw = 100;
  fill(0);
  rect(width-tw, 0, tw, 120);
  fill(255);
  textAlign(LEFT);
  text(label, width-tw, 20);
}

float linear() {
  float m = (float)height/(float)width;
  return m*x;
}

float geometric() {
  power+=speed;
  return pow(base, power);
}

float exponential() {
  base += speed;
  return pow(base, power);
}

float logarithmic() {
  n+=speed;
  return log(n)*50;
}

float sigmoid() {
  base += speed;
  return height/(1+exp(-base));
}

float bounce() {
  n = sin(x*0.1)*200 + 200;
  return log(n)*50;
}

void reset() {
  background(0);
  x = 0;
  base = 0;

  switch(mode) {
  case 1:
    base = 20; // how soon curve ascends (timing)
    power = 1;
    speed = 0.01; // rate of ascent (pacing)
    break;
  case 2:
    speed = 0.005;
    power = 20;
    break;
  case 3:
    n = 0;
    speed = 10;
    break;
  case 4:
    base = -7.5;
    speed = 0.025;
    break;
  case 5:
    speed = 0.01;
    power = 20;
    break;
  }
}


void keyPressed() {

  switch(keyCode) {
  case RIGHT:
    mode++;
    break;
  case LEFT:
    mode--;
    break;
  case UP:
    down = false;
    break;
  case DOWN:
    down = true;
    break;
  }

  if (mode >= modes || mode < 0) {
    mode = (modes + mode%modes)%modes;
  }

  reset();
}

