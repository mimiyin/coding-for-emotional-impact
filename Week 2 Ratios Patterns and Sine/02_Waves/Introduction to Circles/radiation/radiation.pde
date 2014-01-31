// Number of Rays
int numRays;

// Center of the Sun
PVector center;

// Size of the Sun in terms of 
// distance from center of sun to edge of sun
float radius;

// Starting angle of first ray
// Speed at which we change that starting angle
float rStart, rSpeed;

void setup() {
  size(600, 600); 
  numRays = 10;
  radius = 600;
  center = new PVector(width/2, height/2);
}

void draw() {
  background(0);
  stroke(255);
  rStart+=rSpeed;
  //Loop through all the angles for each sun ray
  //Where the "angle" is TWO_PI divided by the number of rays
  for (float r = rStart; r < TWO_PI+rStart; r+=TWO_PI/numRays) {
    //Calculate x and y-positions of the end of each ray
    //by multiplying the radius of the sun with cos and sin of the angle
    float x =  radius*cos(r);
    float y = radius*sin(r);
    pushMatrix();
    translate(center.x, center.y);
    line(0, 0, x, y); 
    popMatrix();
  }
}

void keyPressed() {
  switch(keyCode) {
  case RIGHT:
    rSpeed+=0.1;
    break;
  case LEFT:
    rSpeed-=0.1;
    break;
  }
  println("RSPEED: " + rSpeed);
}

