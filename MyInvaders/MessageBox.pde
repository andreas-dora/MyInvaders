void messageBox(int velue2){
  fill(0);
  
  int x = 300;
  int y = 200;
  int w = 500;
  int h = 300;
  String zeile1 = "";
  String zeile2 = "";
  


  switch (caseNumber){  
    case 0: //---- has not begun
    zeile1 = "PRESS ANY KEY TO START";
    zeile2 = "";
    break;
    
    case 1: //-------- Countdown
    zeile1 = "GET REDY!";
    zeile2 = "";
   
    break;
    
    case 2: //------------ Running
    zeile1 = "";
    zeile2 = "";
            
    break; 
    
    case 4: //------------------ Level Complete
    zeile1 = "LEVEL COMPLETE";
    zeile2 = "";
     
            // ALles Feuer wird Rückwerts gelöscht
            // Feuer deaktiviert
            // Lenkung bleibt aktiv;
            // Bonus Sekunden werden gut geschrieben
            // Level += 1;
            // weiter zu case 1 (Countdown);
            
     break;  
  }

    strokeWeight(10);
  stroke(myOrange);
  rect(300,200, w, h);
  textFont(arial, 36);
  textAlign(CENTER,CENTER);
  fill(myOrange);
  text(zeile1, x+w/2, y+h/2); 
  text(zeile2+  " " + velue2 , x+w/2, y+h/2+30); 
  
  
}
