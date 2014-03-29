// Drawing the graph
float x, y;

// Starting freq and amp for waves
float frequency = 0.005;
float amplitude = 10;

// Selected type of wave
int type;

// Wave types
String [] types = { 
  "SIN", "COS", "TAN", "SQU", "SAW"
};

// Chorus of voices
ArrayList<Voice> voices = new ArrayList<Voice>();
// Selected voice
Voice voice = new Voice(-1);

// Each word is a voice
String [] jabber = "i you don't love me".split(" ");
int max = jabber.length; // Total number of "voices"



void setup() {
  size(800, 600);
  background(255);

  // Base amplitude on window height
  amplitude = height/(max*2);

  // Create max number of Voices
  for (int i = 0; i < max; i++) {
    voices.add(new Voice(i, jabber[i]));
  }
}

void draw() {
  background(0);
  // Run each voice
  for (int i = 0; i < voices.size(); i++) {
    Voice thisVoice = voices.get(i);
    if (thisVoice.on) {
      float beat = thisVoice.ready();
      // If voice returns a beat, draw the word
      if(beat >= 0) {
          String word = jabber[i];
          textSize(beat);
          textAlign(CENTER, CENTER);
          text(word, width/2, height/2);
       }
      thisVoice.run();
    }
  }

  // Draw label
  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 50);
  fill(255);
  
  String waveTypes = "";
  for (int i = 0; i < voices.size(); i++) {
    waveTypes += jabber[i] + ": " + voices.get(i).getType() + "\t\t";
  }
  textAlign(LEFT, TOP);
  textSize(14);
  text("Press TAB to change WAVE TYPE: " + types[type] + "\t\t\t(mouseY)\tAMP: " + amplitude + "\t\t\t(mouseX)\tFREQ: " + frequency, 10, 20);
  text("Pres NUM KEY to turn on VOICE: " + waveTypes + "\t\t\tSelected Voice: " + jabber[voice.index >= 0 ? voice.index : 0], 10, 40 );
}

void mouseMoved() {
  amplitude = map(mouseY, 0, height, 0, height/2);
  frequency = map(mouseX, 0, width, 0.001, 0.1);

  if (voice.on) {
    voice.mod();
  }
}

void keyPressed() {
  // Toggle Voices on and off
  int index = parseInt(key)-49;
  if (index >=0 && index < max) {
    voice = voices.get(index);
    voice.toggle(type);
    if (!voice.on) voice = new Voice(-1);
  }

  switch(keyCode) {
  case TAB:
    type++;
    type%=types.length;
    break;
  }

  if (key == 32) {
    type++;
    type%=types.length;
  }
}

