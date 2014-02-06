// A class to manage the changing rgb values for its area of the screen
class Area {

  Color r;
  Color g;
  Color b;  

  Area(PVector rgb, PVector speed) {
    r = new Color(rgb.x, speed.x);
    g = new Color(rgb.y, speed.y);
    b = new Color(rgb.z, speed.z);
  }
  
  PVector run() {    
    return new PVector(r.run(), g.run(), b.run());
  }
  
}

