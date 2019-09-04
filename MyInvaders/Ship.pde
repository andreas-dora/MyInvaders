class Ship{
  float x;
  float y;
  float r;
  float mini;
  float maxi;
  float updateX;
  float explRad = 1;
  boolean isDead = false;
  boolean isAlive = true;
  int antriebR = 150;
  int antriebL = 150;
  
  Ship( float r_, float mini_, float maxi_){
    x = width/2;
    y = height - 2*r_;
    r = r_;
    mini = mini_+ r_;
    maxi = maxi_  - 2*r_;
  }

  void upDate(float updateX_){
    updateX=constrain(updateX_,  mini, maxi);
    if(x+5 < updateX){
      x +=4;
    } else if(x-5 > updateX){
      x -=4;
    }
    x = constrain(x, mini, maxi);
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
      
     // ellipse(x+r-3, y+i*7, 10,6);
     }
     
     
     for (int i = 0; i<8; i++) { // Linkes Triebwerk
      noStroke(); 
      fill(deeppink, antriebL-(i*10));
      rect(x-r+1*i, y+i*5, 30-i*2,5);
     }
     
      stroke(0);
      fill(0);
      ellipse(x, y, 2*r+4, 2*r+4);

      stroke(gold);
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
    
