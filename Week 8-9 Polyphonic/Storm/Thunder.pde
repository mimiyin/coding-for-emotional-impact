class Thunder {
  AudioPlayer player;
  boolean isThundering;
  float gain;
  
  Thunder() {
    player = minim.loadFile("data/thunder.mp3");
  }

  //Roll thunder
  void roll(float _gain) {
    fill(255, 100);
    rect(0, 0, width, ground);
    isThundering = true;
    // How loud is the thunder
    // Soft sounds farther away
    // Loud sounds closer
    gain = map(_gain, 0, height/4, -80, 10);
  }
  
  void run() {
    // Interrupt thunder only if it's near the end
    if(player.position() > 8000) {
       player.pause();
    }
    
    // If we should be thundering and we aren't, thunder!    
    if(isThundering && !player.isPlaying()) {
      player.setGain(gain);
      player.cue(0);
      player.play();
      isThundering = false;
    }

  }
}

