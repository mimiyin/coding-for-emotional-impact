//this sketch shows how sin and cos can be used to make shapes oscillate

float theta;

void setup() {

  size(400, 400);
  smooth();
  
  theta = 0.0;
}

void draw() {

  background(255);

  //by adding 1, the sin and cos values will oscillate between 0 and 2
  float x = (sin(theta) + 1) * width/2;
  float y = (cos(theta) + 1) * height/2;
  
  //increment theta - the higher the increment value, the faster the oscillation
  theta += 0.05;
  
  //oscillate on x-axis - red ellipse
  fill(255, 70, 0);
  line(width/2, 0, x, height/2);
  ellipse(x, height/2, 30, 30);

  //oscillate on y-axis - green ellipse
  fill(0, 255, 70);
  line(width/2, 0, width/2, y);
  ellipse(width/2, y, 30, 30);

  //oscillate on both x- and y-axis - blue ellipse
  fill(70, 0, 255);
  line(width/2, 0, x, y);
  ellipse(x, y, 30, 30);
}

