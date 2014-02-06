import processing.video.*;
import ddf.minim.*;

int fRate = 30;

// Gatekeepers for drawing, playing and exporting modes
boolean isDrawable, isDrawing;
boolean isPlayable, isExporting;
String exportPath;


// Voices
ArrayList<Voice> voices;
Voice selected;

// Managing moving through your content
Storyboard sb;

// Your content
ArrayList<Movie> movies;
Minim minim;
AudioPlayer audio;


// Keeping track oftime
// elapsed since clicking
// Play button
float timer, startTime;
ToggleButton play;
Button clearAll, clear, load, loadAudio, save, export;
Button addVoice, removeVoice, loadClips;

// Highest point you can draw
int mouseYMin = 50;
int mouseXMin = 100;

void setup() {
  size(640, 480);

  export = new Button("Export", Controls.TOPRIGHT, 1);
  save = new Button("Save", Controls.TOPRIGHT, 2);
  load = new Button("Load", Controls.TOPRIGHT, 3);

  play = new ToggleButton("Play", Controls.TOPRIGHT, 5, "Stop");
  clearAll = new Button("Clear All", Controls.TOPRIGHT, 6);
  clear = new Button("Clear", Controls.TOPRIGHT, 7);

  loadAudio = new Button("Audio", Controls.TOPRIGHT, 9);

  removeVoice = new Button("Remove", Controls.BOTTOMLEFT, 0);
  addVoice = new Button("Add", Controls.BOTTOMLEFT, 1);
  loadClips = new Button("Clips", Controls.BOTTOMLEFT, 2);

  imageMode(CENTER);
  frameRate(fRate);

  minim = new Minim(this);
  sb = new Storyboard(this);
  voices = new ArrayList<Voice>();

  // Always start with at least one voice
  voices.add(new Voice(this, "0", 0));

  reset(true);
}

void draw() {

  // Drawing the storyboard graph
  if (isDrawable) {
    background(255);
    if (isDrawing) {
      selected.record();
    }
    for (Voice v : voices) {
      v.display();
    }
  }
  else {
    //Calculate time elapsed
    //Since beginning of storyboard
    String clock = "";
    int time = 0;
    time = int(timer/1000) + 1;
    clock = time + "s";
    textAlign(CENTER);
    textSize(48);
    float textWidth = textWidth(clock+5);

    if (play.isOn) {
      println("STILL PLAYING? " + sb.isDone());
      if (sb.isDone()) {
        println("PICKING A NEW VOICE!");
        sb.pickVoice();
      }
      sb.run();
      timer = millis() - startTime;
    }
    // When stopped, show end-time
    else {
      fill(0);
      rectMode(CENTER);
      rect(width-50, height-30, textWidth, 70);
    }

    // Display clock
    stroke(255);
    fill(255);
    text(clock, width-textWidth/2-5, height-10);
  }

  showButtons();
}

void reset(boolean isResettingAll) {
  background(255);
  if (isResettingAll) {
    for (int v = voices.size()-1; v >= 0; v--) {
      voices.get(v).reset();
      if (v > 0)
        voices.remove(v);
    }
    isPlayable = false;
  }
  else
    selected.reset();
  pauseEvent();
}

//////////////////////////////////////////
//////////////////////////////////////////
/////////////// INTERACTION //////////////
//////////////////////////////////////////
//////////////////////////////////////////
void mousePressed() {
  isDrawing = true;
  // Play or Stop storyboard
  if (play.isHovered() && isPlayable) {
    if (play.isOn)
      pauseEvent();
    else
      playEvent();
  }
  else if (isDrawable) {
    pauseEvent();
  }
}

void mouseReleased() {
  isDrawing = false;
  if (isDrawable)
    selected.interpolate();

  if (play.isHovered() && isPlayable && !play.isOn)
    isDrawable = true;

  // Clear graph
  // Re-initialize beats array
  else if (clearAll.isHovered())
    reset(true);
  else if (clear.isHovered())
    reset(false);
  else if (save.isHovered())
    save();
  else if (export.isHovered()) {
    setExportFolder();
    isExporting = true;
  }
  else if (load.isHovered())
    load();
  else if (loadAudio.isHovered())
    setAudioFile();
  else if (addVoice.isHovered())
    addVoice();
  else if (removeVoice.isHovered())
    removeVoice();
  else if (loadClips.isHovered())
    selected.setClipSource();
  else {
    for (Voice v : voices) {
      if (v.button.isHovered())
        changeVoice(v);
    }
  }
}

void mouseDragged() {
  if (isOnScreen(new PVector(mouseX, mouseY)) && isOnScreen(new PVector(pmouseX, pmouseY)))
    selected.erase();
}

boolean isOnScreen(PVector pos) {
  return pos.x >= mouseXMin && pos.x <= width && pos.y >= mouseYMin && pos.y <= height-100;
}

//////////////////////////////////////////
//////////////////////////////////////////
////////////////// EVENTS ////////////////
//////////////////////////////////////////
//////////////////////////////////////////

Beat drawEvent(float x, float y, boolean isUserCreated) {
  if (y == 0)
    y = 0;
  x = constrain(x, 0, width);
  y = constrain(y, -height, height);
  return new Beat(x, y, isUserCreated);
}

void playEvent() {

  play.toggle(true);
  isPlayable = true;
  isDrawable = false;
  startTime = millis();
  sb.startEvent();
}

void pauseEvent() {
  play.toggle(false);

  sb.stopEvent();
  isDrawable = true;
  isExporting = false;
}

void selectVoiceEvent(Voice v) {
  selected = v;
}

void loadClipsEvent(File folder) {
  if (folder == null) {
    println("Loading images/movies cancelled.");  
    return;
  }

  selected.initClips();

  File [] files = folder.listFiles();
  // Try to load images
  for (int i = 0; i < files.length; i++) {
    String filename = files[i].getName().toLowerCase();
    String path = files[i].getAbsolutePath();
    if (filename.matches(".+\\.mov$")) {
      selected.addClip(path);
    }
  }
  // Update button label with folder name
  selected.button.update(folder.getName());
}

void showButtons() {
  load.display();
  export.display();
  save.display();
  play.display();
  clearAll.display();
  clear.display();
  loadAudio.display();
  addVoice.display();
  removeVoice.display();
  loadClips.display();

  for (Voice v : voices)
    v.button.display();
}

void movieEvent(Movie m) {
  if (m.available())
    m.read();
}

