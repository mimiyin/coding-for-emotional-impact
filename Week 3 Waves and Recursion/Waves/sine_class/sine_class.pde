float x1, x2, y1, y2;
Sine wave1 = new Sine(0, 0.01, 10, 0);
Sine wave2 = new Sine(0, 0.05, 150, 0);

void setup() {
  size(800, 600);
  background(255);
}



void draw() {
  x1++;
  x2++;
  
  wave1.update();
  y1 = wave1.wave();
  
  wave2.update();
  y2 = wave2.wave();
  
  translate(0, height/2); 
  ellipse(x1, y1, 10, 10);
  ellipse(x2, y2, 10, 10);
}

