class Alien {
  int shipValue;
  int typ;
  float x;
  float y;
  float r;
  float speed = 0.1;
  float explRad = 1; //(ExplosionRAdius)
  int test = 0;
  boolean isDead = false;
  boolean isAlive = true;
  
  Alien(float x_, float y_, float r_, int alienT_){
    x = x_;
    y = y_;
    r = r_;
    shipValue = (alienT_ + 1) * 100;
    typ = alienT_;
  }
  
  boolean intersec(Fire other) {
    float d = dist(x, y, other.x, other.y);
    if (d < r + other.r) {
      return true;
    } else {
      return false;
    }
  }
  boolean isShooting(int a_){
    test = int(random(10*a_));
    if((test < a_)&&(isAlive)) {
      return true;
    } else { 
      return false;
    }
  }
    

  
  void update(float speed_){
    speed = speed_;
    y = y+speed;

    if(!isAlive){
      if(explRad < 3*r){
        explRad +=1;
      } else {
        isDead = true;
      }
    }
  }
  
  
  void show() {
    stroke(alienColor[typ]);  
    if(isAlive){
      strokeWeight(2);
      fill(80);
      ellipse(x, y, 2*r, 2*r);
      textFont(arial, 12);

      textAlign(CENTER, CENTER);
      fill(255);
      text(typ, x,y);
   } else { 
      stroke(deeppink);
      fill(deeppink);
      ellipse(x, y, 2*r-explRad/3, 2*r-explRad/3);
      noFill();
      ellipse(x, y, 2*r+explRad/2, 2*r+explRad/2);
      ellipse(x, y,  r+explRad, r+explRad);
      ellipse(x, y, 2*r+explRad, 2*r+explRad);
      fill(gold);
    //  textFont(f1, 24+explRad/4);
    textFont(arial, 12);
      textAlign(CENTER);
      text(shipValue, x, y+r/2);

    }      
  }
  
  void explode(){
    isAlive = false;
  } 
}
    
