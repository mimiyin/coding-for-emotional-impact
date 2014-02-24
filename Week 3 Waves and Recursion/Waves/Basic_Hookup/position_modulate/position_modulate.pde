float x, y;
float xf = 0.01;
float xa = 1;
float yf = xf;
float ya = yf;

Wave xWave = new Wave(PI/2, xf, xa, 0);
Wave yWave = new Wave(0, xf, xa, 0);

// Waves to modulate the base x-y waves
// Modulating the x and y frequencies
float fa = .05;
Wave xfWave = new Wave(PI/2, xf, fa, fa);
Wave yfWave = new Wave(0, xf, fa, fa);

// Modulating the x and y amplitudes
float aa = 100;
Wave xaWave = new Wave(PI/2, xf, aa, aa);
Wave yaWave = new Wave(0, xf, aa, aa);


void setup() {
  size(400, 400); 
  background(0);
  noStroke();
}

void draw() {
  translate(width/2, height/2);
  
  xf = xfWave.wave();
  xa = xaWave.wave();
  yf = yfWave.wave();
  ya = yaWave.wave();
  
  // Call the modulate function instead
  x = xWave.mod(xf, xa);
  y = yWave.mod(yf, ya); 
  ellipse(x, y, 1, 1);
}

