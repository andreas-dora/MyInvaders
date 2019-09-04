ArrayList<Alien> alien;
ArrayList<Ship> oneShip;
ArrayList<Fire> oneFire;

color deeppink = #FF1493;
color gold = #FFD700;
color alienColor[] = {#FF320A, #7CFC00, #00FFFF};
int alienR;
int abstand;
int shipR;
int feldX;
int offset = 10;
int cols = 3;
int rows = 7;
int punkte;
String punkteString;

boolean isRunning = true;

void setup(){
  size(1080, 640);
  alienR = floor(height/36);
  shipR = floor(height/30);
  abstand = floor(height/20);
  feldX = floor((width-height)/2);
  println("alienR: " + alienR + "   abstand: " + abstand + "   feldX: " + feldX);

  oneShip = new ArrayList<Ship>();
  oneShip.add(new Ship(shipR, feldX, feldX+height));
  
  oneFire = new ArrayList<Fire>();
  
  alien = new ArrayList<Alien>();
  for (int j = 0; j < cols; j++){
    for(int i = 0; i <rows-j; i++){
      int k = i%2;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR+(2*alienR+abstand)*j, alienR, k));
    }
  }
}

void draw(){
  background(0);
  
  
  // spielfeld
  stroke(255);
  noFill();
  line(width/2, 0, width/2, height);
  rect(feldX, offset, height, height-2*offset);
  punkteString = nf(punkte, 6,0);
  textAlign(LEFT);
  fill(255);
  text(punkteString, 2*offset,abstand);
  textAlign(RIGHT);
  text("oneFire: " + oneFire.size(), width-2*offset, abstand);
  
  for(Alien al : alien){
    al.update();
    al.show();
  }

  for(Ship sh1 : oneShip){
    sh1.upDate(mouseX);
    sh1.show();
  }
  
  for(Fire fire1 : oneFire){
    fire1.upDate();
    fire1.show();
  }

  for( int i = 0; i <alien.size(); i++){
    Alien aSh = alien.get(i);
    if(aSh.isDead){
      punkte +=aSh.shipValue;
      alien.remove(i);
      if(alien.size() == 0){
        isRunning = false;
     //   levelUp();
      }
    }
    
    for(int j = oneFire.size()-1; j >= 0; j--){
      Fire fire1 = oneFire.get(j);
      if(fire1.isDone){
        oneFire.remove(j);
      }
      if(aSh.intersec(fire1)){
        oneFire.remove(j);
        aSh.explode();
      }
    }
  }
  
}




void keyPressed(){
  //if(keyCode == 38){
  //  alien.add(new Alien());
  //  println(alien.size());
  //} else 
  
  
  if((keyCode == 39)&&(alien.size() >0)){
     int i = int(random(alien.size()));
     println(i);
     alien.remove(i);
     
  }
}

void mousePressed(){
  if(isRunning){
    for(Ship ship : oneShip){
      oneFire.add(new Fire(ship.x));
    }
  }
}
