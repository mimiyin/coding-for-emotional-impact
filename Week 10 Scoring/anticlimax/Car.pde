class Car {
  PVector location, velocity, acceleration;
  float diameter = 10;
  
  
  Car(PVector _location, PVector _velocity, PVector _acceleration) {
    location = _location;
    velocity = _velocity;
    acceleration = _acceleration;    
  }
  
  void run() {
    update();
    display();
  }

  void update() {
    // Accelerate
    velocity.add(acceleration);
    // Move
    location.add(velocity);    
  }
  
  void setSize(float sz) {
     diameter = sz; 
  }

  void display() {
    float o = map(acceleration.x, 0, 1, 100, 255);
    fill(255, 0, 0, o);
    ellipse(location.x, location.y, diameter, diameter);
  }  
}

