// Chorus of voices
ArrayList<Voice> voices = new ArrayList<Voice>();

// The Circle
float sW, cW, cH;
PVector circle = new PVector (0, 0);

void setup() {
  size(800, 600);
  background(255);

  // Create 5 voices, each with a different wave type
  // Parameters for wave objects are t, f, a, o
  voices.add(new Voice(new Sine(0, 0.01, 100, 0)));
  voices.add(new Voice(new Cosine(0, 0.01, 100, 0)));
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
  
  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    float value = thisVoice.run();
    switch(i) {
    case 0:
      value = map(value, 0, height, 0, width);
      circle.x = value;
      break;
    case 1:
      circle.y = value;
      break;
    case 2:
      cW = value;
      break;
    case 3:
      cH = value;
      break;
    case 4:
      sW = value;
      break;
    }
  }
  
  // Draw the Circle
  translate(width/2, height/2);
  strokeWeight(sW);
  fill(circle.y, circle.x, cH);
  stroke(circle.x, circle.y, cW);
  ellipse(circle.x, circle.y, cW, cH);
  strokeWeight(1);
  stroke(0);
}

