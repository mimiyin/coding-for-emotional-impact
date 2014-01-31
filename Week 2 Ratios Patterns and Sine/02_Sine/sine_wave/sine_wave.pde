/*
* Animation demonstrating the relationship between a sin wave
* and the changing height of moving around the circumference of a circle
*/


PVector circle, speed;
float d, r, theta, tSpeed;

void setup() {
  size(int(TWO_PI*100), 400);
  circle = new PVector(0, height/2);
  speed = new PVector((width/TWO_PI)*.01, 0);
  d = 100;
  r = d/2;
  
  // Fit the speed to the width of the window
  // Make sure a complete sine-wave is drawn
  tSpeed = (width/TWO_PI)*.0001;
}

void draw() {
  background(255);

  noStroke();
  fill(128);
  
  // Draw all the points until the current "theta"
  for (float t = 0; t < theta; t+=abs(tSpeed)) {
    ellipse(t*100, circle.y + r*sin(t), 1, 1);
  }

  stroke(225);
  line(0, circle.y, width, circle.y);
  
  // Calculate position of dot going around the circumference of the circle  
  PVector circum = new PVector(circle.x + r*cos(theta), circle.y + r*sin(theta));

  noStroke();
  // Red Center of Circle
  fill(255, 0, 0);
  ellipse(circle.x, circle.y, 10, 10);

  // Green Y-Position Dot
  fill(0, 255, 0);
  ellipse(circle.x, circum.y, 10, 10);


  // Blue Circumference Dot
  fill(0, 0, 255);
  ellipse(circum.x, circum.y, 10, 10);

  stroke(0);
  //Height line
  line(circle.x, circle.y, circle.x, circum.y);

  stroke(200);
  //Horizontal height line
  line(circum.x, circum.y, circle.x, circum.y);
  //Vertical height Line
  line(circum.x, circum.y, circum.x, circle.y);

  noFill();
  ellipse(circle.x, circle.y, d, d);

  // Bounce back and forth
  if (circle.x > width || circle.x < 0) {
    speed.mult(-1);
    tSpeed *= -1;
  }
  
  //Move the circle
  circle.add(speed);
  
  //Move forward through the degrees of the circle for the sin and cos calculations
  theta += tSpeed;
}

