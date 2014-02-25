// MIDI library
import arb.soundcipher.*;
SoundCipher sc;

int cols = 2;
int rows = 2;
Longitude lon = new Longitude();
Latitude lat = new Latitude();
Room[][] rooms = new Room[cols][rows];
int [] pitchs = { 72, 84, 96, 128 };

float t;
boolean auto = true;

void setup() {
  size(800, 400);
  background(255);
  
  sc = new SoundCipher(this);
  
  // Create 4 "rooms" 
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      rooms[x][y] = new Room(new PVector(x, y), new PVector(cols, rows));
    }
  }
}


void draw() {
  background(255);
  
  // Move lines automatically
  if (auto) {
    t+=.01;
    lat.th = cos(t)*.5 + .5;
    lon.th = sin(t)*.5 + .5;
  }
  
  // Every ten frames, pick a room
  if (frameCount % 10 == 0) {
    float pick = random(1);
    int col = pick >= lon.th ? 1 : 0; 
    int row = pick >= lat.th ? 1 : 0;
    rooms[col][row].select();
  }

  // Draw rooms
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      rooms[x][y].display();
    }
  }
  
  // Draw horizontal and vertical probability thresholds
  lat.display();
  lon.display();

  label();
}

void label() {
  noStroke();
  fill(0);
  rectMode(CORNER);
  rect(0, 0, width, 30);
  fill(255);
  text("LAT: " + int(lat.th*100) + "%\tLONG: " + int(lon.th*100) + "%", 10, 20);
}



void keyPressed() {
  // Manually control horizontal and vertical probability thresholds
  if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT) {
    auto = false;
    switch(keyCode) {
    case UP:
      lat.th-=.01;
      break;
    case DOWN:
      lat.th+=.01;
      break;
    case RIGHT:
      lon.th+=.01;
      break;
    case LEFT:
      lon.th-=.01;
      break;
    }
  }
  else {
    auto = true;
  }
}

