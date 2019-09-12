class Spark extends Particle {
  Spark(PVector l) {
    super(l);
  }

  void display() {
    rectMode(CENTER);
    fill(r, g, b,lifespan);
    noStroke();
    pushMatrix();
    translate(position.x,position.y);
    float theta = map(position.x,0,width,0,TWO_PI*2);
    rotate(theta);
    rect(0,0,w,rad);
    popMatrix();
  }
}
