class Fire {
  float x;
  float y;
  float r = 3;
  float speed = -5;
  boolean isDone = false;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topSpeed =5;

  Fire(float x_) {    
    x = x_;
    y = height-(shipR+offset)*2;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,-0.1);
  }

  void upDate(){
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);    
    if(location.y <0){
      isDone = true;
    }
  }
    
  //  y +=speed;
  //  if (y<0) {
  //    isDone = true;
  //  }
  //} 

  void show(){
    noStroke();
    fill(deeppink);   
    ellipse(location.x, location.y, 2*r, 2*r);
  }
}
  
//    for (int i = 0; i<5; i++) {
//      noStroke();
//      fill(deeppink, (255-i*50));
//      ellipse(x, y+i*2*r, 2*r, 2*r);
//    }
//  }
//} 
