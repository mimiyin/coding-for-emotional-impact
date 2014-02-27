float x, y;
float xf = 0.01;
float xa = 1;
float yf = xf;
float ya = xa;

/* TRY SWAPPING OUT DIFFERENT WAVE TYPES FOR ALL
THE VARIOUS WAVE VARIABLES BELOW AND SEE WHAT YOU GET*/

Cosine xWave = new Cosine(0, xf, xa, 0);
Sine yWave = new Sine(0, yf, ya, 0);

// Waves to modulate the base x-y waves
// Modulating the x and y frequencies
// The bigger fa is, the more complex your pathway will be
float fa = .01;
Tan xfWave = new Tan(0, xf, fa, fa);
Sine yfWave = new Sine(0, yf, fa, fa);

// Modulating the x and y amplitudes
// The bigger aa is, the bigger your pathway will be
float aa = 100;
Cosine xaWave = new Cosine(0, xf, aa, aa);
Sine yaWave = new Sine(0, yf, aa, aa);


void setup() {
  size(400, 400); 
  background(0);
  noStroke();
}

void draw() {
  translate(width/2, height/2);
  
  xf = xfWave.run();
  xa = xaWave.run();
  yf = yfWave.run();
  ya = yaWave.run();
  
  // Call the modulate function instead
  x = xWave.mod(xf, xa);
  y = yWave.mod(yf, ya); 
  
  ellipse(x, y, 1, 1);
}

