float t = 0;
float speed = .1;
float scale = 50;
Curve curve = new Bounce(t, speed, scale);

void setup() {
  size(400, 400);
}


void draw() {
  float value = curve.run();
  println("VALUE: " + value);
  
  // Using a curve instead of figuring out your timing
  // by comparing frameCount to carefully calibrated numbers...
  // Try different timing curves.
  // Try different speeds and scales with each timing curve.
  // How does the timing change, even though your hard-coded numbers don't change?
  if (value < 100) {
    println("DO THIS FIRST");
  } 
  else if (value < 200) {
    println("DO THIS SECOND");
  }
  else if (value < 300) {
    println("DO THIS THIRD");
  }
}

