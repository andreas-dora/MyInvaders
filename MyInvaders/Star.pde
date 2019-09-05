class Star{
  float x;
  float y;
  float r;  
  float z;
  float alpha;
  float speed;
  float rz;
  boolean isDone = false;
  PVector location;
  PVector velocity;
  PVector accelaraion;
  
  Star(){
   x = random(playGroundX, playGroundX+height);
   y = random(-height, height);
   z = random(0.5, 4);
   r = random(1, 4); 
   rz = round(z*r);
   speed = 0.03*z;
   
   alpha = 40 * z;
  }
   Star(float y_){
   x = random(playGroundX, playGroundX+height);
   y = random(0, -height) - y_;
   z = random(0.5, 4);
   r = random(1, 4); 
   rz = round(z*r);
   speed = 0.03*z;
   
   alpha = 30 * z;
  }
  
  void upDate(float mx) {
    y +=speed;
    if (y>height+r) {
      isDone = true;
    }
    //if(mx < width/2){
    //  x +=0.02*z;
    //}
    //if(mx > width/2){
    //  x-=0.02*z;
    //}
    //if(x > width){
    //  x= 0;
    //}
    //if( x < 0){
    //  x = width;
    //}
  }
  
  
  void display(){
    noStroke();
    fill(silver, alpha);
    ellipse(x,y,rz,rz);
    
  }
  
}
