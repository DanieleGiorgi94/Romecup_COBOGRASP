/*
Frecce UP, DOWN, LEFT, RIGHT --> spostano camera
Tasti q,w --> ruotano il polso
Tasti e,r --> ruotano il gomito
Tasti v,b --> apertura/chiusura mano (GUI da rivedere)
Tasti a,s --> attiva/disattiva controllo (GUI)
Tasto z --> controllo rotazione polso tale che palmo sia verso l'alto (GUI)
Tasto x --> controllo rotazione polso tale che palmo sia verso il basso (GUI)
Tasto c --> controllo rotazione polso tale che palmo sia verso destra (GUI)
Tasti u,i --> aumenta/diminuisce coordinata x dell'oggetto (GUI)
Tasti j,k --> aumenta/diminuisce coordinata y dell'oggetto (GUI)
Tasti n,m --> aumenta/diminuisce coordinata z dell'oggetto (GUI)
Tasti g,h --> aumenta/diminuisce eyeZ (GUI)
*/
import g4p_controls.*;
import com.onlylemi.processing.android.capture.*;

AndroidSensor as;

void setup() {
  size(1000, 700, P3D);
  createGUI();
  noStroke();
  lpalmo = 4*lz[0][0]+3*spazio;
  wristR = lpalmo/2 - 15;
  tempoUltimaMisura = 0;
  
  as = new AndroidSensor(0);
  as.start();
}

void draw() {
  background(200);
  lights();
  smooth();
  noStroke();
  camera(width/2.0, height/2.0, eyeR, width/2.0, height/2.0, (height/2.0) / tan(PI*60.0 / 360.0) ,0,1,0);
  stimaAccelerometro();
  scritture();
 
  checkKeyPress(); // gestione eventi da tastiera
  checkFineCorsa(); // controlla tutti i fine corsa (cinque dita e polso)

  disegno();
  
  if (close == 1){
    for (int i=0; i<4; i++){
      closeFinger(i);
    }
    closeThumb(); 
  }

  if (open == 1){
    for (int i=0; i<4; i++){
      openFinger(i);
    }
    openThumb(); 
  }  
}