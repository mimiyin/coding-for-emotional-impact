// Chorus of voices
ArrayList<Voice> voices = new ArrayList<Voice>();

void setup() {
  size(800, 600);
  background(255);

  // Create 5 voices, each with a different wave type
  // Parameters for wave objects are t, f, a, o
  voices.add(new Voice(new Sine(0, 0.01, 100, 100)));
  voices.add(new Voice(new Cosine(0, 0.01, 100, 100)));
  voices.add(new Voice(new Tan(PI/2, 0.005, 50, 50)));
  voices.add(new Voice(new Square(PI, 0.01, 10, 10)));
  voices.add(new Voice(new Sawtooth(0, 0.01, 10, 10)));
}

void draw() {
  background(0);
  
  // After 5 seconds, change wave for voice 0 to a high-frequency, high-amplitude Tan wave
  if(frameCount == 300) {
     voices.get(0).init(new Tan(0, 0.05, 500, 0));    
  }  
  //After another 5 seconds, change wave for voice 0 back to original Sine wave 
  else if(frameCount == 600) {
    voices.get(0).change(0);
  }
  //After another 5 seconds, modulate the frequency and amplitude of voice O's wave
  else if(frameCount == 900) {
    voices.get(0).mod(0.05, 250, 0); 
  }

  // Calculate offsets and values both
  // for graphing and picking a voice
  float offset = 0;
  float [] offsets = new float [voices.size()];
  float [] values = new float [voices.size()];

  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    float value = thisVoice.run();
    offset += value;
    values[i] = value;
    offsets[i] = offset;
  }

  // Pick a voice
  // Use ceiling to adjust amount of room for nothing to happen
  float ceiling = offset;
  int v = fire(0, ceiling, offsets);
  if (v >=0) {
    switch(v) {
    case 0:
      println("A");
      break;
    case 1:
      println("B");
      break;
    case 2:
      println("C");
      break;
    case 3:
      println("D");
      break;
    case 4:
      println("E");
      break;
    }
  }
}

// Dartboard function
int fire(float min, float max, float[] zones) {
  float dart = random(min, max); 
  for (int i = 0; i < zones.length; i++) {
    if ( dart < zones[i]) {
      return i;
    }
  }
  return -1;
}

