//Using noise to change boundaries
float sz, t;

int octaves;
float falloff;

// Freq and amp for octave
float of = 0.01;
float oa = 100;

// Freq and amp for falloff
float ff = of;
float fa = oa;


Cosine oWave = new Cosine(0, of, oa, oa);
Sine fWave = new Sine(0, ff, fa, fa);

// Waves to modulate the base x-y waves
// Modulating the x and y frequencies
// The bigger fa is, the more complex your pathway will be
float freqa = .01;
Tan ofWave = new Tan(0, of, freqa, freqa);
Sine ffWave = new Sine(0, ff, freqa, freqa);

// Modulating the x and y amplitudes
// The bigger aa is, the bigger your pathway will be
float aa = 100;
Cosine oaWave = new Cosine(0, of, aa, aa);
Sine faWave = new Sine(0, ff, aa, aa);

void setup() {
  size(800, 400);
  background(255);
  
  println("UP/DOWN to adjust octaves. RIGHT/LEFT to adjust falloff");
}


void draw() {
  t+=.01;
  
  of = ofWave.run();
  oa = oaWave.run();
  ff = ffWave.run();
  fa = faWave.run();
  
  // Call the modulate function instead
  octaves = int(oWave.mod(of, oa));
  falloff = fWave.mod(ff, fa);
  
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
