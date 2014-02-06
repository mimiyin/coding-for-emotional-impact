// Manages display of your content
class Storyboard {
  Voice current;
  Minim minim;
  AudioPlayer audio;
  boolean hasAudio;

  Storyboard(PApplet parent) {
    minim = new Minim(parent);
  }

  void reset() {
    for (Voice v : voices) {
      v.reset();
    }
  }

  void pickVoice() {
    int sum = 0;
    for (Voice v : voices) {
      v.run();
      sum += v.weight; 
      v.threshold = sum;
    }
    float dart = random(sum);
    for (Voice v : voices) {
      if (dart < v.threshold) {
        current = v;
        if (current.hasClips)
          current.pickClip();
        break;
      }
    }
  }

  void run() {
    current.play();
  }


  void addAudio(String path) {
    audio = minim.loadFile(path);
    audio.cue(0);

    hasAudio = true;
    println("Loaded audio from: " + path);
    println("The audio is " + Math.round(audio.length()/1000) + "s long.");
  }

  void startEvent() {
    if (hasAudio) {
      audio.cue(0);
      audio.play();
    }
  }

  void stopEvent() {
    if (hasAudio)
      audio.pause();
  }


  boolean isDone() {
    if (current == null || current.isDone()) {
      println("STORYBOARD IS DONE!!!");
      return true;
    }
    else
      return false;
  }
}

