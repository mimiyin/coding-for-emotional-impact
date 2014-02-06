class Drop {
  PVector loc;
  PVector speed;

  Drop(PVector _loc) {
    loc = _loc;
    speed = new PVector(0, random(1, 5));
  }

  void run() {
    update();
    display();
  }
  void update() {
    loc.add(speed);
  }

  void display() {
    stroke(255);
    pushMatrix();
    translate(loc.x, loc.y);
    line(0, 0, 0, random(3,5));
    popMatrix();
    noStroke();
  }
  
 boolean isDead() {
    if(loc.y > ground) {
       return true;
    } 
    return false;
 }
}

