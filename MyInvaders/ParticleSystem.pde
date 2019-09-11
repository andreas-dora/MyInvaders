
class ParticleSystem {
  boolean maxArray  = false;
;

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed
  float lifespan = 1;
  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = v.get();                        // Store the origin point
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
   // Iterator<Particle> it = particles.iterator();
    //while(it.hasNext()){
    //  Particle p = it.next();
    //  p.run();
    //  if(p.isDead()){
    //    it.remove();
    //    lifespan -=3;

      
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        lifespan -=3;
        particles.remove(i);
      }
      if (particles.size() > 50){
        maxArray = true;
      }

    }
  }

  void addParticle() {
    if(maxArray == false){
  //  if(particles.size() < 50){
    particles.add(new Particle(origin));
    }
   
  }
  boolean isDone() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
  // A method to test if the particle system still has particles
  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}
