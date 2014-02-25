//Using noise to change boundaries
float sz, t;
int octaves;
float falloff;

void setup() {
  size(800, 400);
  background(255);
  
  println("UP/DOWN to adjust octaves. RIGHT/LEFT to adjust falloff");
}


void draw() {
  t+=.01;
  noiseDetail(octaves, falloff);
  
  // Change size of ellipse according to noise function
  sz=noise(t)*width;
  ellipse(width/2, height/2, sz, sz);
  
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    octaves++;
    break;
  case DOWN:
    octaves--;
    break;
  case RIGHT:
    falloff+=.1;
    break;
  case LEFT:
    falloff-=.1;
    break;
  }

  octaves = constrain(octaves, 1, 20);
  falloff = constrain(falloff, 0.01, 1);
  
  println("OCTAVES: " + octaves + "\t\tFALLOFF: " + falloff);
}
