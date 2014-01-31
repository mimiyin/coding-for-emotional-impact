/*
* Comparing constant motion to organic variable motion using 
 * sin and cos wave values
 */

PVector constant, conSpeed;
PVector sine, sinSpeed, sinDir;
PVector cosine, cosSpeed, cosDir;
PVector tangent, tanSpeed, tanDir;

float t;
float amp = 1;

void setup() {
  size(640, 500); 

  constant = new PVector(0, height/5);
  conSpeed = new PVector(5, 0);

  sine = new PVector(0, 2*height/5);  
  sinDir = new PVector(1, 1);  

  cosine = new PVector(0, 3*height/5);
  cosDir = new PVector(1, 1);  

  tangent = new PVector(0, 4*height/5);
  tanDir = new PVector(1, 1);  
  
  println("Use UP/DOWN to affect amplitude.");
}

void draw() {
  background(0); 

  ////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////CONSTANT MOTION////////////////////////////////////////// 
  ////////////////////////////////////////////////////////////////////////////////////////////

  if (constant.x < 0 || constant.x > width) conSpeed.x *= -1;

  // With constant Motion, you are moving the ball the same amount with each frame
  constant.add(conSpeed);
  ellipse(constant.x, constant.y, 50, 50); 


  t+=0.01;
  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////SINE MOTION/////////////////////////////////////////////       
  ///////////////////////////////////////////////////////////////////////////////////////////

  if (sine.x > width || sine.x < 0) sinDir.mult(-1);
  sinSpeed = new PVector(sin(t)*amp + amp, 0);
  sinSpeed.x*=sinDir.x;
  sine.add(sinSpeed);
  ellipse(sine.x, sine.y, 50, 50);



  ///////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////COSINE MOTION//////////////////////////////////////////       
  ///////////////////////////////////////////////////////////////////////////////////////////

  if (cosine.x > width || cosine.x < 0) cosDir.mult(-1);  
  cosSpeed = new PVector(cos(t)*amp + amp, 0);
  cosSpeed.x*=cosDir.x;
  cosine.add(cosSpeed);
  ellipse(cosine.x, cosine.y, 50, 50);

  ///////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////TANGENT MOTION/////////////////////////////////////////      
  ///////////////////////////////////////////////////////////////////////////////////////////

  if (tangent.x > width || tangent.x < 0) tanDir.mult(-1);  
  tanSpeed = new PVector(abs(tan(t)), 0);
  tanSpeed.x*=tanDir.x;
  tangent.add(tanSpeed);
  tangent.x = constrain(tangent.x, -1, width+1);
  ellipse(tangent.x, tangent.y, 50, 50);

}

void keyPressed() {
  switch(keyCode) {
  case UP:
    amp++;
    break;
  case DOWN:
    amp--;
    break;
  } 
  
  amp = constrain(amp, 1, 20);
  println("AMP: " + amp);
}

