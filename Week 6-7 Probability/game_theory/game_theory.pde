int cols = 2;
int rows = 2;
Longitude lon = new Longitude();
Latitude lat = new Latitude();
Room[][] rooms = new Room[cols][rows];

float t;
boolean auto = true;

void setup() {
  size(800, 400);
  background(255);

  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      rooms[x][y] = new Room(new PVector(x, y), new PVector(cols, rows));
    }
  }
}


void draw() {
  background(255);
  if (auto) {
    t+=.01;
    lat.th = cos(t)*.5 + .5;
    lon.th = sin(t)*.5 + .5;
  }

  if (frameCount % 10 == 0) {
    float pick = random(1);
    int col = pick <= lon.th ? 1 : 0; 
    int row = pick <= lat.th ? 1 : 0;
    rooms[col][row].select();
  }


  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      rooms[x][y].display();
    }
  }

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
    auto = false;
  }
}

