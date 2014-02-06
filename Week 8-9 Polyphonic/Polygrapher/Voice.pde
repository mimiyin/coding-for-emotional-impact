class Voice {
  boolean isCurrent;
  boolean hasClips;
  Beat[] beats;
  int index, counter;
  float t, tSpeed = 1;
  float weight, threshhold;
  int firstBeatInd, lastBeatInd, threshold;
  ArrayList<Movie> clips;
  Movie picked;
  Button button;

  PApplet parent;

  Voice(PApplet p, String name, int _index) {
    parent = p;
    index = _index;
    toggle(true);
    button = new Button(name, Controls.SIDEBAR, index);
    reset();
  }

  void toggle(boolean isOn) {
    isCurrent = isOn;
    if (isOn)
      selectVoiceEvent(this);
  }

  void reset() {
    background(255);
    t = 0;
    weight = 1;
    threshold = 0;

    // Init clips arraylist
    initClips();

    // Initialize beats array with 
    // a dot for every x-position
    beats = new Beat[width];
    for (int i = 0; i < beats.length; i++) {
      beats[i] = drawEvent(i, 0, false);
    }
  }

  void loadBeats(Beat[] _beats) {
    beats = _beats;
  }

  // Interpolate beats so that
  // every x-position has a beat value
  void interpolate() {

    // Calculate the first/last beat
    for (int i = 0; i < beats.length; i++) {
      if (beats[i].isUserCreated) {
        firstBeatInd = i;
        break;
      }
    }

    for (int i = beats.length-1; i > 0; i--) {
      if (beats[i].isUserCreated) {
        lastBeatInd = i;
        break;
      }
    }

    int prevBeatInd = firstBeatInd;
    int nextBeatInd = findNextBeat(firstBeatInd + 1);
    int indRange = nextBeatInd-prevBeatInd;
    PVector prevBeat = new PVector (beats[firstBeatInd].beat, beats[firstBeatInd].rawTempo);
    PVector nextBeat = new PVector (beats[nextBeatInd].beat, beats[nextBeatInd].rawTempo);
    PVector range = PVector.sub(nextBeat, prevBeat);
    float progress = 0;
    for (int i = firstBeatInd; i <= lastBeatInd; i++) {
      Beat thisBeat = beats[i];
      float beat = thisBeat.beat;
      float tempo = thisBeat.rawTempo;
      if (thisBeat.isUserCreated) {
        prevBeatInd = i;
        nextBeatInd = findNextBeat(i+1);
        indRange = nextBeatInd - prevBeatInd;
        prevBeat.set(beat, tempo);
        nextBeat.set(beats[nextBeatInd].beat, beats[nextBeatInd].rawTempo);
        range = PVector.sub(nextBeat, prevBeat);
      }
      else {
        progress = ((float)( i - prevBeatInd))/indRange;
        beat = prevBeat.x + Math.round(progress*range.x);
        tempo = prevBeat.y + Math.round(progress*range.y);
        thisBeat = drawEvent(beat, tempo, false);
      }    
      thisBeat.init();
      beats[i] = thisBeat;
    }

    t = firstBeatInd;
  }

  int findNextBeat(int _i) {
    for (int i = _i; i < lastBeatInd+1; i++) {
      if (beats[i].isUserCreated)
        return i;
    }
    // If there are no more beats
    // Send the last beat
    return lastBeatInd;
  }

  void record() {
    if (isOnScreen(new PVector(mouseX, mouseY))) {
      beats[mouseX] = drawEvent(mouseX, mouseY, true);
      isPlayable = true;
    }
  }

  void display() {
    for (Beat beat: beats) {
      if (beat.isUserCreated) {
        color col = isCurrent ? color(255, 0, 0) : color(0, 128);
        beat.display(col);
      }
    }
  }

  void erase() {
    boolean isGoingRight = mouseX > pmouseX;
    if (isGoingRight) {
      for (int i = pmouseX + 1; i < mouseX; i++) {
        beats[i] = drawEvent(i, 0, false);
      }
    }
    else {
      for (int i = pmouseX - 1; i > mouseX; i--) {
        beats[i] = drawEvent(i, 0, false);
      }
    }
  }

  void addClip(String path) {
    try {
      clips.add(new Movie(parent, path));
      hasClips = true;
    }
    catch (Exception e) {
      println("No movie at: " + path);
    }
  }

  void run() {
    if (picked != null) {
      picked.stop();
      picked = null;
    }
    t+=tSpeed; 
    weight = beats[(int)Math.round(t)].tempo;
    counter = 0;
  }

  void pickClip() {
    int m = (int)random(clips.size());
    picked = clips.get(m);  
    picked.play();
  }

  void play() {
    if (hasClips) {
      picked.play();
      image(picked, width/2, height/2, width, height);
    }
    else {
      counter++;
      background(255, 0, 0);
    }
  }

  boolean isDone() {
    if (hasClips && picked.time() >= picked.duration()-1) {
      println("VOICE IS DONE!!!");
      return true;
    }
    else if (counter > weight)
      return true;
    else
      return false;
  }

  void setClipSource() {
    selectFolder("Select source folder for clips.", "loadClipsEvent");
  }

  void initClips() {
    clips = new ArrayList<Movie>();
  }
}

