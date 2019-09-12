void messageBox(int velue2){
  fill(0);
   rectMode(CORNER);
 
  int x = 300;
  int y = 200;
  int w = 500;
  int h = 300;
  String zeile1 = "";
  


  switch (caseNumber){  
    case 0: //---- has not begun
    zeile1 = "PRESS ANY KEY TO START";
    break;
    
    case 1: //-------- Countdown
    zeile1 = "GET READY!";
  text(velue2 , x+w/2, y+h/2+30); 
   
    break;
    
    case 2: //------------ Running
    zeile1 = "";
            
    break; 
    
    case 4: //------------------ Level Complete
    zeile1 = "LEVEL COMPLETE";
  text(velue2 , x+w/2, y+h/2+30); 
     
            
     break;  
      case 5: //------------------ Level Complete
    zeile1 = "ARE YOU BLIND?";
 
     break;
     
      case 6: //------------------ Level Complete
    zeile1 = "GAME OVER";

            
     break;
  }

  textFont(arial, 36);
  textAlign(CENTER,CENTER -80);
  fill(goldenRod);
  text(zeile1, x+w/2, y+h/2); 
  
  
}
