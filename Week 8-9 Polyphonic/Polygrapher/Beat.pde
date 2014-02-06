// Keeps track of "tempo" as we move across the storyboard graph

class Beat {
  float beat, tempo, rawTempo, scaledTempo, counter;
  boolean isUserCreated;

  Beat(float _beat, float _tempo, boolean _isUserCreated) {
    beat = _beat;
    tempo = _tempo;
    rawTempo = tempo;
    isUserCreated = _isUserCreated;
  }

  void init() {    
    // A tempo of 1 frame (3 minutes at 60fps) means take all 3 minutes to play out 1 scene
    // Max tempo means 10 scenes will play out in 1 second
    // Tempo values are mapped "on a curve" (natural log curve)
    // Play with expMax and expMin to play with which part of the curve you'd like to map your values to
    float max = 100;
    float expMin = -5;
    float expMax = 2.5;
    float exp = map(rawTempo, height, mouseYMin, expMin, expMax);   
    float log = exp(exp);
    tempo = map(log, exp(expMin), exp(expMax), 1, max);
    //println("Beat: " + beat + "\tRaw Tempo: " + rawTempo + "\tNatural Log: " + log + "\tTempo: " + tempo);
  }

  void display(color col) {
    noStroke();
    fill(col);
    ellipse(beat, rawTempo, 10, 10);    
  }
}








