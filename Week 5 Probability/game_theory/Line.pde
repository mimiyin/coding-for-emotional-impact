class Line {
  float th;

  Line() {
  }
  
}

class Latitude extends Line {
  Latitude() {
  } 

  void display() {
    stroke(255, 0, 0);
    float y = th*height;
    line(0, y, width, y);
  }
}

class Longitude extends Line {
  Longitude() {
  } 

  void display() {
    stroke(255, 0, 0);
    float x = th*width;
    line(x, 0, x, height);
  }
}

