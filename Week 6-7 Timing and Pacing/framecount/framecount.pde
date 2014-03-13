void setup() {
  size(400, 400);
}


void draw() {
  if (frameCount < 360) {
    println("DO THIS FIRST");
  } 
  else if (frameCount < 720) {
    println("DO THIS SECOND");
  }
  else if (frameCount < 1080) {
    println("DO THIS THIRD");
  }
}

