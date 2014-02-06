class Rain {

  ArrayList<Drop> drops = new ArrayList<Drop>();

  Rain() {
  }

  void add(float num) {
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
  }
}





