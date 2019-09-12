
class ParticleSystem {
  int maxSize;
  boolean hasMaxSize  = false;
  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;        // An origin point for where particles are birthed
  
  ParticleSystem(PVector tempVector) {
    particles = new ArrayList<Particle>();   // Initialize the arraylist
    origin = tempVector.copy();  
    maxSize =  50; //int(random(50, 100));
    // Store the origin point
    //for (int i = 0; i < num; i++) {
    //  particles.add(new Particle(origin));    // Add "num" amount of particles to the arraylist
    //}
  }

  void run(){
    Iterator<Particle> it = particles.iterator();
    while(it.hasNext()){
      Particle p = it.next();
      p.run();
      if(p.isDead()){
        it.remove();
      }
    }
    if (particles.size() > maxSize){
      hasMaxSize = true;
    }
  }

  void addParticle(){
    if(hasMaxSize == false){
      if(particles.size()< 15){
        particles.add(new Spark(origin));
      }else {
        particles.add(new Particle(origin));
      }
    }
  }

  boolean isDone() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }
}
