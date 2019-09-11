class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r;
  float g;
  float rad;

  Particle(PVector l) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-3,3),random(-3,3));
    position = l.get();
    lifespan = 255.0;
    r = 255.0;
    g = 200.0;
    rad = random(6,16);
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.5;
    r -=1;
    g -=2;
    
  }

  // Method to display
  void display() {

    fill(r,g,0,lifespan);
    ellipse(position.x,position.y,rad,rad);
  }
  
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
