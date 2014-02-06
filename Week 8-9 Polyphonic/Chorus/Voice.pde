class Voice {
  int lifespan, age;
  int pitch;
  float beat = 1;

  Wave wave; 

  Voice(int index) {
    pitch = pitches[index];

    //Which Curve?
    int w = wb.fire();

    switch(w) {
    case 0:
      wave = new Sine(); 
      break;
    case 1:
      wave = new Cosine(); 
      break;
    case 2:
      wave = new Tan(); 
      break;
    case 3:
      wave = new Square(); 
      break;
    case 4:
      wave = new Sawtooth();
      break;
    }
    

    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////PLAY WITH THESE NUMBERS/////////////////////
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////

    float freq = random(0.01, 0.1);
    float amp = random(100, 1000);
    wave.init(0, freq, amp, amp);

    //Set lifespan of voice
    lifespan = int(random(600, 6000));

    println("INIT VOICE " + index + "\tLIFESPAN: " + lifespan + "\tWAVE TYPE: " + wave.getType() + "\tFREQ: " + freq + "\tAMP: " + amp);
  }


  boolean run() {
    age++;
    if ( age%beat < 1) {
      beat = constrain(wave.run(), 10, wave.run());
      for (int i = 0; i < beat; i++) {
        myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
      } 
      myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
      return true;
    }

    return false;
  }

  boolean isDead() {
    return age > lifespan;
  }
}

