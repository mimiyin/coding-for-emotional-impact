// A class to manage the changing rgb values for its area of the screen
class Area {

  Color r, g, b;


  Area(PVector rgb, PVector ratios, float speed) {
    r = new Color(rgb.x, ratios.x, speed);
    g = new Color(rgb.y, ratios.y, speed);
    b = new Color(rgb.z, ratios.z, speed);
  }

  PVector run() {   
    return new PVector(r.run(), g.run(), b.run());
  }
  void update(PVector ratios) {
    r.update(ratios.x);
    g.update(ratios.y);
    b.update(ratios.z);
  }
}

