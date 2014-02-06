// Growing balloon
// Hook it up to a nature of code example for seeking
// Sound example
// Generic event

float sz, t;

void setup() {
  size(800, 400);
  background(255);
  
  
}


void draw() {
  t+=.01;
  sz=noise(t)*100;
  ellipse(width/2, height/2, sz, sz);
  
}
