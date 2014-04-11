class Score {
  Curve c;

  Score(Curve _c) {
    c = _c;
  }

  void update(int dir) {
    c.adjust(dir);
  }

  float calc() {
    return c.calc();
  }
}

