class Ship{
  float x;
  float y;
  float r;
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

  }

  void upDate(float updateX_){
    updateX=constrain(updateX_,  playGroundX+r, playGroundX+height-r);
    if(x+5 < updateX){
      x +=4;
    } else if(x-5 > updateX){
      x -=4;
    }
    x = constrain(x, playGroundX+r, playGroundX+height-r);
    
    if(!isAlive){
      if(explRad < 70){
        explRad +=1;
      } else {
        isDead = true;
      }
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
      
    if(isAlive){

     for (int i = 0; i<8; i++) { // ---------- rechtes Triebwerk
      noStroke(); 
      fill(deeppink, antriebR-(i*10));
      rect(x-4+1*i, y+i*5, 30-i*2,5);
      
     }
     
     
     for (int i = 0; i<8; i++) { // Linkes Triebwerk
      noStroke(); 
      fill(deeppink, antriebL-(i*10));
      rect(x-r+1*i, y+i*5, 30-i*2,5);
     }
     
      stroke(0);
      fill(0);
      ellipse(x, y, 2*r+4, 2*r+4);

      stroke(c);
      strokeWeight(3);
      ellipse(x, y, 2*r, 2*r);
      ellipse(x, y, r, r);
      noStroke();
      

    } else { 
      stroke(deeppink);
      strokeWeight(2);
      fill(deeppink);
      ellipse(x, y, 2*r-explRad/3, 2*r-explRad/3);
      noFill();
      ellipse(x, y, 2*r+explRad/2, 2*r+explRad/2);
      ellipse(x, y,  r+explRad, r+explRad);
      ellipse(x, y, 2*r+explRad, 2*r+explRad);
      
     // fill(gold);
      //textFont(f1, 24+explRad/4);
      //textAlign(CENTER);
      //text("A", x, y+r/2);

    }
  }
  
    void explode(){
    isAlive = false;
  } 
}
    
