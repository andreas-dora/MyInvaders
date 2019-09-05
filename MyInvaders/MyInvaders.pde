
/*
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++        MYINVADERS                                      ++
++        by Andreas Breitwieser                          ++
++                                                        ++
++                                                        ++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/

Ship oneShip;

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


int offset = 5;

//-----------------------SPIEL
int punkte;
int timeBonus = 100;
int bonus;
int countDown = 5;
int caseNumber;
int firstStars = 50;
int firstStarCounter;
int level = 1;


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
  firstStarCounter = firstStars;
  playGroundX = width/2 - height/2; 
  playGroundY = 0;
  playGroundW = height;
  playGroundH = height;
  arial = createFont("Arial", 36);
  alienR = floor(height/36);
  // 
  shipR = floor(height/30);
  println(shipR + "from Setup");
  
  abstand = floor(height/20);

  oneShip = new Ship(shipR, height - 2*shipR, gold);
  
  oneFire = new ArrayList<Fire>();
  alienFire = new ArrayList<Fire>();

  alien = new ArrayList<Alien>();
  for (int j = 0; j < cols+level; j++){
    for(int i = 0; i <rows-j; i++){
      int k = i%3;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR-(2*alienR+abstand)*j, alienR, k));
    }
  }
  
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
  fill(0,0,0);
  rect(playGroundX, 0, height, height);
  
  switch (caseNumber){  
    case 0:                   //---------- has not begun
    fireEnable = false;
    stearingEnable = false; 
    messageBox(0);   
    mySpeed = 0;
    break;
    
    case 1:                   //-------- Countdown
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
      punkte += 100;
    }
    if(timeBonus ==0){
      caseNumber = 1;
    }
    //bonus = timeBonus * 100;
    //punkte = punkte + bonus;
    //messageBox(timeBonus);
    //if(timer.isFinished()){
    //  countDown -=1;
    //  }
    // if(countDown ==6){
    //   caseNumber = 1;

   

    break;
             
    case 5:                          // -- -----------------Player Down
    fireEnable = false;
    break;
  }
  
  
  
  // --------------------------------
  // -------------------------------- Anzeige
  textFont(arial, 24);
  textAlign(LEFT);
  fill(255);
  text("LEVEL: " + level, offset, abstand);
  text("SCORE: "+nf(punkte, 6,0), offset,2*abstand);
  text("TIME BONUS: "+timeBonus, offset,3*abstand);

  textAlign(RIGHT);
  text("x/y: " + mouseX + " / " + mouseY, width-2*offset, abstand);
  text("oneFire: " + oneFire.size(), width-2*offset, 2*abstand);
  text("FirstStars: " + firstStarCounter, width-2*offset, 3*abstand);
  text("CaseNumber: " + caseNumber, width-2*offset, 4*abstand);  
  text("shootingSpeed: " + shootingSpeed, width-2*offset, 5  *abstand);
  text("countDown: " + countDown, width-2*offset, 6  *abstand);

//-----------------------------------------------------------------

//----------------------------- BACKGROUND
  for(int i = star.size()-1; i >= 0; i--){
    Star sta = star.get(i);
    sta.upDate( );
    sta.display();
    if(sta.isDone){
      star.remove(i);
      firstStarCounter -=1;
      star.add(new Star(height));
    }
  }
  
 
  oneShip.show(mouseX); 
  if(stearingEnable){
    oneShip.upDate(mouseX);
  } else{ 
    oneShip.upDate(width/2);
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
  
  
  for( int i = 0; i <alien.size(); i++){
    Alien aSh = alien.get(i);
    if(aSh.isDead){
      punkte +=aSh.shipValue;
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
    }
  }
  
  for(int i = oneFire.size()-1; i >= 0; i--){
    Fire fire1 = oneFire.get(i);
    if(fire1.isDone){
      oneFire.remove(i);
    }
  }

  
 
  if(timer.isFinished()){    
    timer.start();
  }  
  if(fastTimer.isFinished()){    
    fastTimer.start();
  }   


  if(shootingTimer.isFinished()){
    for( int i = 0; i <alien.size(); i++){
      Alien aSh = alien.get(i);
      //for( int j = 0; j <alien.size(); j++){
      //  Alien jSh = alien.get(i);  
        if((aSh.hasTarget(oneShip.x, oneShip.r))&&(fireEnable)){         //---------------||(aSh.clearRange(jSh))){
          println("PENG");
          aSh.shoot();
        //}
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
  if(fireEnable){
    oneFire.add(new Fire(oneShip.x, oneShip.y, -0.15, deeppink));
  }
}
  
