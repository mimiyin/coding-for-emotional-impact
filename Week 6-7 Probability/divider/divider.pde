float y1, y2, px, py, t;
float threshold = 0.5;

void setup() {
  size(800, 400);
  background(255);
  y1 = height/2;
  y2 = height/2;
}


void draw() {
  auto();
  stroke(0, 100);
  line(0, y1, width, y2);
  float m = (y2-y1)/width;
  px = random(width);
  py = m*px + y1;

  if (random(1) > threshold) {
    py = random(0, py);
  } 
  else {
    py = random(py, height);
  }
  noStroke();
  fill(threshold*255, 0, 0, 100);
  ellipse(px, py, 10, 10);
  
  label();
}

void label() {
  fill(0);
  rect(0, 0, width, 40);
  fill(255);
  text(threshold, 10, 20);    
}

void auto() {
  t+=.001;
  //threshold = sin(t);
}


void keyPressed() {

  if (key == 'q' || key == 'w' || key == 'a' || key == 's') {
    if (key =='q') {
      threshold -= .1;
    }
    else if (key == 'w') {
      threshold += .1;
    }
    else if (key =='a') {
      threshold -= .001;
    }
    else if (key == 's') {
      threshold += .001;
    }
    threshold = constrain(threshold, 0, 1);
  }
  else {
    if (keyCode == UP || keyCode == DOWN || keyCode == RIGHT || keyCode == LEFT) {
      background(255);
      switch(keyCode) {
      case UP:
        y1--;
        break;
      case DOWN:
        y1++;
        break;
      case RIGHT:
        y2--;
        break;
      case LEFT:
        y2++;
        break;
      }
    }
  }
}

