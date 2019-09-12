class Alien {
  int shipValue;
  int typ;
  float x;
  float y;
  float r;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  float topSpeed = 0.3;
  float explRad = 1;
  float t_y;
  int tryToShoot;
  boolean isDead = false;
  boolean isAlive = true;

  PVector friendFireTest;
  
  Alien(float x_, float y_, float r_, int typ_){
    x = x_;
    y = y_;
    r = r_;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    target = new PVector(x, height);
    shipValue = (typ_ + 1) * 100;
    typ = typ_;
  }
  
  boolean hasTarget(float temp_x, float temp_r){
    float d = dist(temp_x, height, target.x, target.y);
    if(d <  temp_r +3){
      return true;
    } else {
      return false;
    }
  }
      
  
  //boolean clearRange(Alien family){
  //  float d = dist(target.x, target.y, family.target.x, family.target.y); 
  //  if ((d < family.r + 3) && (family.location.y > location.y)){  //3 sollte
  //    return false;
  //  } else {
  //    return true;
  //  }
  //}
  
  boolean intersec(Fire other) {
    float d = dist(location.x, location.y, other.location.x, other.location.y);
    if (d < r + other.r) {
      return true;
    } else {
      return false;
    }
  }

  
  
  
  boolean isShooting(int a_){
    tryToShoot = int(random(10*a_));
    if((tryToShoot < a_)&&(isAlive)) {
      return true;
    } else { 
      return false;
    }
  }
    
  void shoot(){
            alienFire.add(new Fire(location.x, location.y, 0.14, green));
  
  }
  
  void update(float acc_y){
    acceleration.y = acc_y;
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity); 
    

    //if(!isAlive){
    //  if(explRad < 3*r){
    //    explRad +=1;
    //  } else {
    //    isDead = true;
    //  }
    //}
  }
  
  
  void show() {

    stroke(alienColor[typ]);  
    if(isAlive){
      strokeWeight(3);
      fill(0);
      ellipse(location.x, location.y, 2*r, 2*r);
      textFont(arial, 12);

      textAlign(CENTER, CENTER);
      fill(255);
      text(typ, location.x,location.y);
   } else { 

      
      //ellipse(location.x, location.y, 2*r-explRad/3, 2*r-explRad/3);
      //noFill();
      //ellipse(location.x,location.y, 2*r+explRad/2, 2*r+explRad/2);
      //ellipse(location.x, location.y,  r+explRad, r+explRad);
      //ellipse(location.x, location.y, 2*r+explRad, 2*r+explRad);

      recurseShip(r);
            fill(gold);
     // textFont(f1, 24+explRad/4);
    textFont(arial, 20);
      textAlign(CENTER);
      text(shipValue, location.x, location.y+r/2);
    }      
  }


  
  
  void recurseShip(float r_){
    stroke(deeppink);
    fill(0);
    ellipse(location.x, location.y, 2*r_+ +explRad, 2*r_+explRad);
    if( r_ > 2){
     r_ *=0.60;
     recurseShip(r_);
   }
  }
  
  void explode(){
    isDead = true;
  } 
}
