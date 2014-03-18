class Thunder {
  AudioPlayer player;
  boolean isThundering;
  Thunder() {
    player = minim.loadFile("data/thunder.mp3");
  }

  //Roll thunder
  void roll() {
    fill(255, 100);
    rect(0, 0, width, ground);
    isThundering = true;
  }
  
  void run() {
    // Interrupt thunder only if it's near the end
    if(player.position() > 8000) {
       player.pause();
    }
    
    // If we should be thundering and we aren't, thunder!    
    if(isThundering && !player.isPlaying()) {
      player.cue(0);
      player.play();
      isThundering = false;
    }

  }
}

