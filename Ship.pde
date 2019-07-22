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
  
  Ship( float r_, float mini_, float maxi_){
    x = width/2;
    y = height - 2*r_;
    r = r_;
    mini = mini_+ r_;
    maxi = maxi_  - r_;
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
  void show(){

    if(isAlive){
      stroke(gold);
      noFill();
      fill(0);
      ellipse(x, y, 2*r, 2*r);
      ellipse(x, y, r, r);


    } else { 
      stroke(deeppink);
      strokeWeight(1);
      fill(deeppink);
      ellipse(x, y, 2*r-explRad/3, 2*r-explRad/3);
      noFill();
      ellipse(x, y, 2*r+explRad/2, 2*r+explRad/2);
      ellipse(x, y,  r+explRad, r+explRad);
      ellipse(x, y, 2*r+explRad, 2*r+explRad);
      fill(gold);
      //textFont(f1, 24+explRad/4);
      //textAlign(CENTER);
      //text("A", x, y+r/2);

    }
  }
  
    void explode(){
    isAlive = false;
  } 
}
    
