class Fire {
  float x;
  float y;
  float r = 3;
  float h;
  float speed = -5;
  boolean isDone = false;

  Fire(float x_) {
    x = x_;
  //  r = r_;
    y = height-(shipR+offset)*2;
  }

  void upDate() {
    y +=speed;
    if (y<0) {
      isDone = true;
    }
  }
  

  void show() {
    for (int i = 0; i<5; i++) {
      noStroke();
      fill(deeppink, (255-i*50));
      ellipse(x, y+i*2*r, 2*r, 2*r);
    }
  }
} 
