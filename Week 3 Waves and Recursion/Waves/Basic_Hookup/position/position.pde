Wave xWave = new Wave(PI/2, 0.01, 100);
Wave yWave = new Wave(0, 0.01, 100);
float x, y;

void setup() {
 size(400, 400); 
 background(0);
 noStroke();
}

void draw() {
 translate(width/2, height/2);
 x = xWave.wave();
 y = yWave.wave(); 
 ellipse(x, y, 10, 10);   
}


