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
  float alpha = 255;

  Fire(float x_) {    
    x = x_;
    y = height-(shipR+offset)*2;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,-0.15);
  }

  void upDate(){
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);    
    if(location.y <0){
      isDone = true;
    }
  }

  void show(){
    noStroke();
    fill(deeppink); 
    recurseFire(location.x, location.y, alpha);
  }
  
 void recurseFire(float x_, float y_, float a){
   noStroke();
   fill(deeppink, a);
   ellipse(x_, y_, 2*r, 2*r);
   if( a > 15){
     a *=0.80;
     recurseFire(x_, y_+r, a);
   }
  }
}
 
