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
  float acc_x;
  float acc_y;
  color c;
  
  Fire(float loc_x, float loc_y, float acc_y_, color c_ ){
    acc_x = 0;
    acc_y = acc_y_;
    x = loc_x;
    y = loc_y;
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(acc_x,acc_y);
    c = c_;
  }

  void upDate(){
    velocity.add(acceleration);
    velocity.limit(topSpeed);
    location.add(velocity);    
    if((location.y <-20)|| (location.y >height+20)){
      isDone = true;
    }
  }

  void show(){
    recurseFire(location.x, location.y, alpha);
  }
  
 void recurseFire(float x_, float y_, float a){
   noStroke();
   fill(c, a);
   ellipse(x_, y_, 2*r, 2*r);
   if( a > 15){
     a *=0.80;
     recurseFire(x_, y_+r, a);
   }
  }
}
 
