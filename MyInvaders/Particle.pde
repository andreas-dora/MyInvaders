class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float r = 255;
  float g;
  float b = 0;
  float rad;
  float w;
  float greenMinus;

  Particle(PVector tempVector) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-1,1));
    position = tempVector.copy();
    lifespan = 255.0;
    g = 200.0;
    rad = random(2,8);
    w = random(2,8);
    greenMinus = random(1.5, 3.0);
  }

  void run() {
    update();
    display();
  }

  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2;
    g -=greenMinus;   
  }

  void display() {
    fill(r,g,b,lifespan);
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
