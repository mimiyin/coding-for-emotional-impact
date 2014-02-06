class Room {
  PVector cell;
  float w, h;

  Room(PVector _cell, PVector cells) {
    cell = _cell;
    w = width/cells.x;
    h = height/cells.y;
  }
  void display() {
    pushMatrix();
    translate(cell.x*w, cell.y*h);
    rectMode(CENTER);
    stroke(0);
    noFill();
    rect(w/2, h/2, w, h);
    popMatrix();
  }

  void select() {
    pushMatrix();
    translate(cell.x*w, cell.y*h);
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(w/2, h/2, w/2, h/2);
    popMatrix();
  }
}

