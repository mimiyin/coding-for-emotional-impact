class Score {
  Curve c;

  Score(Curve _c) {
    c = _c;
  }

  void update(float change) {
    //c.update(0, 0, change, 0);
    c.update(change, 0, 0, 0);
  }

  float calc() {
    return c.run();
  }
}

