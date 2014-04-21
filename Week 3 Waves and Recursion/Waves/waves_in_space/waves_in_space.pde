Wave xWave, yWave;
float reset = 0;

void setup() {
  size(400, 400);
  // Try calling different wave functions here
  xWave = new Tan(0, 0.05, width, width);
  yWave = new Sine(0, 0.01, height, height);
  noFill();
}

void draw() {
  background(255);
  // Un-comment this line back if you want it to animate
  reset+=0.01;
  xWave.reset(reset);
  yWave.reset(reset);
  
  // Create a grid
  for (int x = 0; x < width; x+=20) {
    for (int y = 0; y < height; y+=20) {
      // Try each of these one at a time...
      
      line(x, y, xWave.run(), yWave.run());
      //rect(x, y, xWave.run(), yWave.run());
      //ellipse(x, y, xWave.run(), yWave.run());
    }
  }
}

