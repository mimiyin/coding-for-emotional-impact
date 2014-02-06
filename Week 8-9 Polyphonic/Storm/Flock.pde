// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (int i = boids.size()-1; i > 0; i--) {
      Boid thisBoid = boids.get(i);
      thisBoid.run(boids);  // Passing the entire list of boids to each boid individually
      if(thisBoid.isDead()) boids.remove(i);
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
  
}

