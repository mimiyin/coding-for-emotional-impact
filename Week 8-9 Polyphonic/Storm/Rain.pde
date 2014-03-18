class Rain {

  ArrayList<Drop> drops = new ArrayList<Drop>();
  AudioPlayer player;
  float gain = -40;
  
  Rain() {
    player = minim.loadFile("rain.mp3");
    player.loop();
    player.setGain(gain);    
  }

  void drop(float num) {
    for (int i = 0; i < num; i++) {
      drops.add(new Drop(new PVector(random(width), -10)));
    }
  }

  void run() {
    for (int i = drops.size()-1; i > 0; i--) {
      Drop thisDrop = drops.get(i);
      thisDrop.run();
      if(thisDrop.isDead()) {
         drops.remove(i);
      }
    }
    gain = map(drops.size(), 0, 100, -40, 10);
    player.setGain(gain);
  }  
}





