
/*
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++        MYINVADERS                                      ++
++        by Andreas Breitwieser                          ++
++                                                        ++
++                                                        ++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*/


ArrayList<Alien> alien;
ArrayList<Ship> oneShip;
ArrayList<Fire> oneFire;
ArrayList<Star> star;
PFont arial;
Timer timer;
Timer fastTimer;

color deeppink = #FF1493;
color gold = #FFD700;
color silver = #C0C0C0;
color alienColor[] = {#FF320A, #7CFC00, #00FFFF};
int alienR;
int abstand;
int shipR;
int playGroundX;
int playGroundY;
int playGroundW;
int playGroundH;

int offset = 5;
int cols = 2;
int rows = 7;
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
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
void setup(){
  size(1080, 640);
  firstStarCounter = firstStars;
  playGroundX = width/2 - height/2 - offset;
  playGroundY = offset;
  playGroundW = height - 2*offset;
  playGroundH = height - 2*offset;
  arial = createFont("Arial", 36);
  alienR = floor(height/36);
  // 
  shipR = floor(height/30);
  println(shipR + "from Setup");
  
  abstand = floor(height/20);
//  play = floor((width-height)/2);
  println("alienR: " + alienR + "   abstand: " + abstand + "   feldX: " + playGroundX);

  oneShip = new ArrayList<Ship>();
  oneShip.add(new Ship(shipR, playGroundX, playGroundX+height));
  
  oneFire = new ArrayList<Fire>();
  
  alien = new ArrayList<Alien>();
  for (int j = 0; j < cols+level; j++){
    for(int i = 0; i <rows-j; i++){
      int k = i%2;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR+(2*alienR+abstand)*j, alienR, k));
    }
  }
  
  star = new ArrayList<Star>();
  for(int i = 0; i < firstStars; i++){
    star.add(new Star());
  }
  timer = new Timer(1000);
  timer.start();
  fastTimer = new Timer(100);
  fastTimer.start();
}

void draw(){
  background(0,10,30);
  strokeWeight(1);
  //line(width/2, 0, width/2, height);
  fill(0,0,0);
  rect(playGroundX, playGroundY, playGroundW, playGroundH);
  
  switch (caseNumber){  
    case 0: //---- has not begun
    fireEnable = false;
    stearingEnable = false; 
    messageBox(0);    
    break;
    
    case 1: //-------- Countdown
//    int cD = countDown;
    fireEnable = false;
    stearingEnable = true;   
    if(timer.isFinished()){
      countDown-=1;
    }
    if(countDown == 0){
    caseNumber = 2;
    }
    messageBox(countDown);      
    //}
  
    break;
    
    case 2: //------------ Running
    fireEnable = true;
    isRunning = true;   
    stearingEnable = true;  
    if(timer.isFinished()){
      timeBonus -=1;
    }
    
            
    break; 
    
    case 3: //------------------ Level Complete
    countDown += 10;  
    level +=1;
    caseNumber +=1;// ALles Feuer wird Rückwerts gelöscht
            // Feuer deaktiviert
            // Lenkung bleibt aktiv;
            // Bonus Sekunden werden gut geschrieben
            // Level += 1;
            // weiter zu case 1 (Countdown);
            
     break;
     
     case 4: //Player Down
 
      fireEnable = false;
      stearingEnable = true; 
      bonus = timeBonus * 100;
      punkte = punkte + bonus;
      messageBox(bonus);
      if(timer.isFinished()){
        countDown -=1;
      }
      if(countDown ==6){
        caseNumber = 1;
      }
      alien = new ArrayList<Alien>();
  for (int j = 0; j < cols+level; j++){
    for(int i = 0; i <rows-j; i++){
      int k = i%2;
        alien.add(new Alien((width - ((2*alienR+abstand)*(rows-j)-(2*alienR+abstand)))/2 +(2*alienR+abstand)*i,2*offset+alienR+(2*alienR+abstand)*j, alienR, k));
    }
  }
    
             // Feuer sperren, Feuer löschen 
             // If Schiffe > 0{
             // Schiffe - 1;
             //  weiter mit Case 1;
             // } else {             
             // weiter mit Case 5;
      break;
             
      case 5:    // -- Game OVer
                 // If Highscore
                 // else case 0;
      fireEnable = false;
    
      break;
             }
  
  // spielfeld
  stroke(255);
  noFill();

  textFont(arial, 24);
  punkteString = nf(punkte, 6,0);
  textAlign(LEFT);
  fill(255);
      text("LEVEL: " + level, offset, abstand);

  text("SCORE: "+punkteString, offset,2*abstand);
  text("TIME BONUS: "+timeBonus, offset,3*abstand);

  textAlign(RIGHT);
  text("x/y: " + mouseX + " / " + mouseY, width-2*offset, abstand);
  text("oneFire: " + oneFire.size(), width-2*offset, 2*abstand);
  text("FirstStars: " + firstStarCounter, width-2*offset, 3*abstand);
  text("CaseNumber: " + caseNumber, width-2*offset, 4*abstand);
    text("countDown: " + countDown, width-2*offset, 5  *abstand);

  for(int i = star.size()-1; i >= 0; i--){
    Star sta = star.get(i);
    sta.upDate(mouseX);
    sta.display();
    if(sta.isDone){
      star.remove(i);
      firstStarCounter -=1;
      star.add(new Star(height));
    }
  }
  
  
  for(Alien al : alien){
    al.update();
    al.show();
  }

  for(Ship sh1 : oneShip){
    sh1.show(mouseX);
    if(stearingEnable){
    sh1.upDate(mouseX);
    } else {
    sh1.upDate(width/2);
    }
      

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
        caseNumber = 3;
     //   levelUp();
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

  
}

//void countDownFunction(int cD){
//    timer.start(1000);
//    if(timer.isFinished()){
//      println("PENG from coundDownFunction");
//      cD-=1;
//      if(cD >0){
//        timer.start(1000);
//      }
//    }
//     if(cD == 0){
//       caseNumber = 2;
//     }
//         messageBox(str(cD));    

//    }
  


void keyPressed(){
 if(caseNumber == 0){
   caseNumber = 1;
 }
  
}
  //if(keyCode == 38){
  //  alien.add(new Alien());
  //  println(alien.size());
  //} else 
  
  
  //if((keyCode == 39)&&(alien.size() >0)){
  //   int i = int(random(alien.size()));
  //   println(i);
  //   alien.remove(i);
     
  //}


void mousePressed(){
  if(fireEnable){
    for(Ship ship : oneShip){
      oneFire.add(new Fire(ship.x));
    }
  }
}
