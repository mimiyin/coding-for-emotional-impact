class Line {
  float y;
  int octaves, origOct, index;
  float falloff, origFall;
  
  float labelX = 2*width/3;

  Line(int i) {
    index = i;
    octaves = index + 1;
    falloff = index*0.2+0.01;
    origOct = octaves;
    origFall = falloff;
  }
  
  // Change number of octaves and falloff for this line
  void modulate(int _octaves, float _falloff) {
    if (mode.equals("Octaves")) {
      octaves = _octaves;
      falloff = origFall;
    }
    else if (mode.equals("Falloff")) {
      falloff = _falloff;
      octaves = origOct;
    }
    else {
      octaves = origOct;
      falloff = origFall;
    }
  }
  
  // Keep moving along the noise function
  void update() {
    noiseDetail(octaves, falloff);
    y = noise(t)*100;    
  }

  void display() {
    pushMatrix();
    // translate to the ith row in the window
    // total number of rows = total number of lines
    // height of each row is height/num of lines
    translate(0, (index*height/lines.length));
    fill(16);
    rect(labelX, 20, width/3, 20);
    fill(200);
    text("MODE: " + mode + "\tOCTS: " + octaves + "\tFALLOFF: " + Float.toString(falloff).substring(0,3), labelX+5, 35);
    fill(255, 200);
    ellipse(x, y, 1, 1);
    noStroke();
    popMatrix();
  }
}

