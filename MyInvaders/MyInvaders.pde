
/*
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++        MYINVADERS                                      ++
++        by Andreas Breitwieser                          ++
++                                                        ++
++                                                        ++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

// fire zusammenfügen


ArrayList<ParticleSystem> systems;

//Ship oneShip;
ArrayList<Ship> oneShip;
ArrayList<Alien> alien;
ArrayList<Fire> oneFire;
ArrayList<Fire> alienFire;
ArrayList<Star> star;
PFont arial;
Timer timer;
Timer fastTimer;
Timer shootingTimer;
color deeppink = #FF1493;
color gold = #FFD700;
color silver = #C0C0C0;
color myOrange = color(255,50,10);
color green = color(0, 200, 50);
color alienColor[] = {#FF320A, #7CFC00, #00FFFF};
color goldenRod = #DAA520;
color dodgerBlue = #1E90FF;  
//----------------------SPIELFELD
int playGroundX;
int playGroundY;
int playGroundW;
int playGroundH;

//----------------------ALIENS
int cols = 2;
int rows = 7;
int alienR;

int shootingSpeed = 1000;


int abstand;

int shipR;
int shipY;
int level = 1;
int shipsOne = 2;
int offset = 5;

//-----------------------SPIEL
int score;
int timeBonus = 100;
int bonus;
int countDown = 5;
int caseNumber;
int firstStars = 50;
//int firstStarCounter;



String punkteString;
String message[] = {"Press any key to start", "Get ready"};

boolean isRunning = false;
boolean fireEnable = false;
boolean stearingEnable = false;
float mySpeed = 0;
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
void setup(){
  size(1080, 640);
  //firstStarCounter = firstStars;
  playGroundX = width/2 - height/2; 

  arial = createFont("Arial-Black", 36);
  alienR = floor(height/32);
  shipY = height - floor(height/16);
  shipR = floor(height/30);
  println(shipR + "from Setup");
  
  abstand = floor(height/20);

  oneShip = new ArrayList<Ship>();
  oneShip.add(new Ship(shipR, shipY, gold));
  
  oneFire = new ArrayList<Fire>();
  alienFire = new ArrayList<Fire>();

  alien = new ArrayList<Alien>();
  for (int j = 0; j < cols+level; j++){
    for(int i = 0; i <rows-j; i++){
      int k = i%3;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR-(2*alienR+abstand)*j, alienR, k));
    }
  }
    systems = new ArrayList<ParticleSystem>();

  star = new ArrayList<Star>();
  for(int i = 0; i < firstStars; i++){
    star.add(new Star());
  }
  timer = new Timer(1000);
  timer.start();
  fastTimer = new Timer(20);
  fastTimer.start();
  shootingTimer = new Timer(shootingSpeed);
}
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
void draw(){
  background(0,10,30);
  strokeWeight(1);
  noStroke();
  fill(0,0,0);
  rect(playGroundX, 0, height, height);
        for (int i = systems.size()-1; i >= 0; i--) {
      ParticleSystem ps = systems.get(i);
    ps.run();
    ps.addParticle(); 
  //  }
    if(ps.dead()){
      systems.remove(i);
    }
  } 
  fill(0);
  text("click mouse to add particle systems",10,height-30);
  switch (caseNumber){  
    case 0:                   //---------- has not begun
    shipsOne = 3;
    score = 0;
    fireEnable = false;
    stearingEnable = false; 
    messageBox(0);   
    mySpeed = 0;
    break;
    
    case 1:  //-------- Countdown
    shipY = height - floor(height/16);
    fireEnable = false;
    stearingEnable = true; 
    timeBonus = 100;
    if(timer.isFinished()){
      countDown-=1;
    }
    if(countDown == 0){
    caseNumber = 2;
    }
    messageBox(countDown);      
    break;
    
    case 2: //------------ Running
    fireEnable = true;
    isRunning = true;   
    stearingEnable = true; 
    mySpeed = 0.1;
    if(timer.isFinished()){
      timeBonus -=1;
    }
    break; 
    
    case 3: //------------------ Level Complete
    countDown += 10;  
    level +=1;
    mySpeed = 0;
    caseNumber +=1;
    shootingSpeed = round(shootingSpeed*=0.9);
    break;
    
    case 4:                //------------------ Next Level
    fireEnable = false;
    stearingEnable = true; 
    countDown = 5;
    alien = new ArrayList<Alien>();
    for (int j = 0; j < cols+level; j++){
      for(int i = 0; i <rows-j; i++){
        int k = i%3;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR-(2*alienR+abstand)*j, alienR, k));
      }
    }
    if((fastTimer.isFinished())&&(timeBonus> 0)){
      timeBonus -=1;
      score += 100;
    }
    if(timeBonus ==0){
      caseNumber = 1;
    }
     messageBox(timeBonus);     
      countDown = 3;
    break;
             
    case 5:                          // -- -----------------Player Down
    mySpeed = 0.0;
    messageBox(-1);   
    if(timer.isFinished()){
      countDown-=1;
      }
      if(countDown == 0){
        oneShip.add(new Ship(shipR, shipY, gold));
        shipsOne -=1;
        countDown =3;
        caseNumber =2;
        countDown = 3;
    }
    break;
    
    case 6:
    fireEnable = false;
    if(timer.isFinished()){ 
      countDown-=1;
      if( countDown ==0){     
        caseNumber = 0;
      }
    }  
    messageBox(-1);   
    break;
  }
  
  
  
  // --------------------------------
  // -------------------------------- Anzeige

  display(goldenRod);
//-----------------------------------------------------------------

//----------------------------- BACKGROUND
  for(int i = star.size()-1; i >= 0; i--){
    Star sta = star.get(i);
    sta.upDate( );
    sta.display();
    if(sta.isDone){
      star.remove(i);
      star.add(new Star(height));
    }
  }
  
 for(Ship sh : oneShip){
   
  sh.show(mouseX); 
  if(stearingEnable){
    sh.upDate(mouseX,shipY);
  } else{ 
    sh.upDate(width/2, shipY);
  }
 }
 
 
 
  for(Alien al : alien){
    al.update(mySpeed);
    al.show();
  }
  
 
  
  for(Fire fire1 : oneFire){
    fire1.upDate();
    fire1.show();
  }
  
  for(Fire afi : alienFire){
    afi.upDate();
    afi.show();
  }
  
  for(int i = alienFire.size()-1; i >= 0; i--){  // --- PLAYER DOWN
    Fire fiA = alienFire.get(i);
    for(int j = 0; j <oneShip.size(); j ++){
      Ship sh = oneShip.get(j);
        if(sh.intersec(fiA)){
          alienFire.remove(i);
          fireEnable = false;
          sh.explode();
          oneShip.remove(j);
          countDown = 3;
          if(shipsOne > 0){
          caseNumber= 5;
          } else {
          caseNumber= 6;
        }
      } 
    }
  }
  
  
  
  
  for( int i = 0; i <alien.size(); i++){
    Alien aSh = alien.get(i);
    if(aSh.isDead){
      explosion(aSh.location.x,aSh.location.y);
 
      score +=aSh.shipValue;
      alien.remove(i);
      if(alien.size() == 0){
        isRunning = false;
        caseNumber = 3;
      }
    }
  
    for(int j = oneFire.size()-1; j >= 0; j--){
      Fire fire1 = oneFire.get(j);
      if(aSh.intersec(fire1)){
        oneFire.remove(j);
        aSh.explode();
      }
     if(fire1.isDone){
      oneFire.remove(j);
    }
  }
  } 
  //for(int i = oneFire.size()-1; i >= 0; i--){
  //  Fire fire1 = oneFire.get(i);
  //  if(fire1.isDone){
  //    oneFire.remove(i);
  //  }
  //}

  
 
  if(timer.isFinished()){    
    timer.start();
  }  
  if(fastTimer.isFinished()){    
    fastTimer.start();
  }   


  if(shootingTimer.isFinished()){
    for( int i = 0; i <alien.size(); i++){
      Alien aSh = alien.get(i);
      for( int j = 0; j < oneShip.size(); j ++){
      Ship sh = oneShip.get(j);
        if((aSh.hasTarget(sh.location.x, sh.r))&&(fireEnable)){         //---------------||(aSh.clearRange(jSh))){
          aSh.shoot();
        }
      }
    }
    shootingTimer.start();
  }  
}


//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
void keyPressed(){
 if(caseNumber == 0){
   caseNumber = 1;
 }
}

void mousePressed(){

  println(playGroundX, playGroundX+height) ; 
  for(Ship sh : oneShip){
  if(fireEnable){
    oneFire.add(new Fire(sh.location.x, sh.location.y, -0.15, deeppink));
  }
  }
}
  
void display(color c){
  int tx = 2*offset;
  int ty =4 *offset;
  int zeile = 30;
  stroke(c);
  strokeWeight(2);
  noFill();
  rect(offset, offset, width/2-height/2-offset, height - 2*offset);
  textFont(arial, 32);
  textAlign(LEFT,TOP);
  fill(c);
  text("PLAYER ONE ", 2*offset, 2*offset);
  textFont(arial, 23);
  text("LEVEL: " + level, tx, ty +zeile);
  text("SHIPS: "+nf(shipsOne, 2,0), tx, ty +2* zeile);
  text("SCORE: ", tx, ty +3* zeile);
  textAlign(RIGHT,TOP);
  text(nf(score, 6,0), width/2-height/2-offset, ty +3* zeile);
  textAlign(LEFT,TOP);
  text("TIMEBONUS: ", tx,ty +4* zeile);
  textAlign(RIGHT,TOP);
  text(timeBonus, width/2-height/2-offset,ty +4* zeile);


  textAlign(RIGHT);
  text("x/y: " + mouseX + " / " + mouseY, width-2*offset, abstand);
  text("fire.size: " + oneFire.size() + " / " + alienFire.size(), width-2*offset, 2*abstand);
  //text("FirstStars: " + firstStarCounter, width-2*offset, 3*abstand);
  text("CaseNumber: " + caseNumber, width-2*offset, 4*abstand);  
  text("shootingSpeed: " + shootingSpeed, width-2*offset, 5  *abstand);
  text("countDown: " + countDown, width-2*offset, 6  *abstand);
    text("shipY: " + shipY, width-2*offset, 7  *abstand);

  
}
void explosion(float tempX, float tempY){
         systems.add(new ParticleSystem(1,new PVector(tempX,tempY)));
}
