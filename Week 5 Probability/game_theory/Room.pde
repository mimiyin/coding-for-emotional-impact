class Room {
  PVector cell;
  float w, h;
  float pitch;

  Room(PVector _cell, PVector cells) {
    cell = _cell;
    w = width/cells.x;
    h = height/cells.y;
    // Assign a pitch based on room position
    pitch = pitchs[int(((cells.x*cell.y) + cell.x))];
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
    
    // Draw a rect when "room" is selected
    pushMatrix();
    translate(cell.x*w, cell.y*h);
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(w/2, h/2, w/2, h/2);
    popMatrix();
    
    // Play note when "room" is selected
    sc.playNote(pitch, 100, 0.5);
  }
}

