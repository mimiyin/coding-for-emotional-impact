Wave dWave = new Wave(0, 1, 100, 100);
float duration;
boolean isOn;
int count;

void setup() {
  size(400, 400);
  rectMode(CENTER);
}


void draw() {
  background(0); 
  count ++;
  if (count > duration) {
    count = 0;
    isOn = !isOn; 
    duration = dWave.wave();
  }
  if (isOn) rect(width/2, height/2, 100, 100);
}

