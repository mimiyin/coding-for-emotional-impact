

float constantX, constantY, constantXSpeed;
float linearX, linearY, linearXSpeed;
float geometricX, geometricY, geometricXSpeed, geometricXAccel;
float exponentialX, exponentialY, exponentialXSpeed, exponentialXDir;
boolean constant, linear, geometric, exponential;

void setup() {
  size(640, 650); 
  initConstant();
  initLinear();
  initGeometric();
  initExponential();

}

void draw() {
  background(0); 
  
  textAlign(LEFT);  
  text("Press 1, 2, 3 or 4 to turn modes on and off", 10, 30);
  textAlign(CENTER);

  //////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////CONSTANT MOTION/////////////////////////////////////////// 
  ////////////////////////////////////////////////////////////////////////////////////////////
  if (constant) {

    text("CONSTANT MOTION", width/2, constantY);

    if (constantX < 0 || constantX > width) 
      constantXSpeed *= -1;

    // With constant Motion, you are moving the ball the same amount with each frame
    constantX += constantXSpeed;
    ellipse(constantX, constantY, 50, 50);
  }
  ////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////LINEAR MOTION/////////////////////////////////////////// 
  //////////////////////////////////////////////////////////////////////////////////////////

  if (linear) {

    text("LINEAR GROWTH", width/2, linearY);

    if (linearX < 0 || linearX > width) 
      linearXSpeed *= -1;

    if (linearXSpeed > 0)  
      linearXSpeed++; 
    else
      linearXSpeed--; 

    // With Linear Motion, you are moving the ball the same amount faster with each frame
    linearX += linearXSpeed;
    ellipse(linearX, linearY, 50, 50);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////GEOMETRIC MOTION///////////////////////////////////////  
  /////////////////////////////////////////////////////////////////////////////////////////

  if (geometric) {

    text("GEOMETRIC GROWTH", width/2, geometricY);
    if (geometricX < 0 || geometricX > width)
      geometricXSpeed *= -1;

    // With Geometric Motion, you are moving the ball an increasing amount with each frame
    // by multiplying the speed
    geometricXSpeed *= geometricXAccel;
    geometricX += geometricXSpeed;
    ellipse(geometricX, geometricY, 50, 50);
  }
  ///////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////EXPONENTIAL MOTION//////////////////////////////////////       
  ///////////////////////////////////////////////////////////////////////////////////////////

  if (exponential) {

    text("EXPONENTIAL GROWTH", width/2, exponentialY);
    if (exponentialX < 0 || exponentialX > width) 
      exponentialXDir *= -1; 
    // With Exponential Motion, you are moving the ball an increasing amount with each frame
    // by multiplying the speed by itself (or a fraction of itself) with each frame
    exponentialXSpeed = pow(exponentialXSpeed, 1.01);
    exponentialX += exponentialXSpeed*exponentialXDir;

    ellipse(exponentialX, exponentialY, 50, 50);
  }
}

// KeyPress commands to turn modes on and off
void keyPressed() {

  switch(key) {
  case '1':
    constant = !constant;
    initConstant();
    break;
  case '2':
    linear = !linear;
    initLinear();
    break;  
  case '3':
    geometric = !geometric;
    initGeometric();
    break;
  case '4':
    exponential = !exponential;
    initExponential();
    break;
  }
}


// Moved initialization into separate functions so that
// each mode is re-initialized every time it's turned on/off
void initConstant() {

  constantX = 0;
  constantY = 100;
  constantXSpeed = 1;
}

void initLinear() {

  linearX = 0;
  linearY = 250;
  linearXSpeed = 0.01;
}

void initGeometric() {

  geometricX = 1;
  geometricY = 400;
  geometricXSpeed = 1;
  geometricXAccel = 1.01;
}

void initExponential() {

  exponentialX = 0;
  exponentialY = 550;
  exponentialXSpeed = 1.01;
  exponentialXDir = 1;
}

