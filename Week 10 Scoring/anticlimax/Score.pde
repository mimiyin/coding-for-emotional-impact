class Score {
  Curve c;

  Score(Curve _c) {
    c = _c;
  }
  
  // Move along the score curve
  void update(float change) {
    c.update(0, 0, change, 0);
  }

  float calc() {
    return c.run();
  }
}

