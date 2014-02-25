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

  void update() {
    if (mode.equals("Octaves")) {
      octaves = manOct;
      falloff = origFall;
    }
    else if (mode.equals("Falloff")) {
      falloff = manFall;
      octaves = origOct;
    }
    else {
      octaves = origOct;
      falloff = origFall;
    }

    noiseDetail(octaves, falloff);
    y = noise(t)*100;
  }

  void display() {
    pushMatrix();
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

