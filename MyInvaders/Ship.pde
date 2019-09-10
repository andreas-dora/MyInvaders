class Ship{
  float x;
  float y;
  float r;
    PVector location;
  PVector velocity;
  PVector acceleration;
  float updateX;
  float explRad = 1;
  boolean isDead = false;
  boolean isAlive = true;
  int antriebR = 150;
  int antriebL = 150;
  color c;
  
  Ship( float r_, float y_, color c_){
    x = width/2;
    y = y_;
    r = r_;
    c = c_;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }

  void upDate(float mx, float y_){
    location.y = y_;
    location.x=constrain(mx,  playGroundX+r, playGroundX+height-r);
    if(location.x+5 < mx){
      velocity.x +=4;
    } else if(location.x-5 > mx){
      velocity.x -=4;
    } else {
      velocity.x = 0;
    }
    
 
    location.add(velocity);
    location.x = constrain(location.x, playGroundX+r, playGroundX+height-r);


  }
  
  boolean intersec(Fire other) {
    float d = dist(location.x, location.y, other.location.x, other.location.y);
    if (d < r + other.r) {
      return true;
    } else {
      return false;
    }
  }
 
  void show(float mx){
    if(mx < x - 2*r){
      antriebR = 255;
      antriebL = 100;
    } else if(mx > x + 2*r){
      antriebL = 255;
      antriebR = 100;
    } else {
      antriebL = 150;
      antriebR = 150;
    }
      
  //  if(isAlive){

     //for (int i = 0; i<8; i++) { // ---------- rechtes Triebwerk
     // noStroke(); 
     // fill(deeppink, antriebR-(i*10));
     // rect(x-4+1*i, y+i*5, 30-i*2,5);
      
     //}
     
     
     //for (int i = 0; i<8; i++) { // Linkes Triebwerk
     // noStroke(); 
     // fill(deeppink, antriebL-(i*10));
     // rect(x-r+1*i, y+i*5, 30-i*2,5);
     //}
           strokeWeight(2);

      stroke(100);
      fill(#6A5ACD);
      ellipse(location.x, location.y, 2*r+4, 2*r+4);

      stroke(#F0E68C);
      ellipse(location.x, location.y, 2*r, 2*r);
      ellipse(location.x, location.y, r, r);
      noStroke();
      

    //} else { 
 
    //   recurseShip(r);

    //}      
  }


  
  
  void recurseShip(float r_){
    stroke(deeppink);
    fill(0);
    ellipse(location.x, location.y, 2*r_+ +explRad, 2*r_+explRad*1.2);
    if( r_ > 2){
     r_ *=0.60;
     recurseShip(r_);
   }
  }
    void explode(){
  //  isAlive = false;
  } 
}
    
