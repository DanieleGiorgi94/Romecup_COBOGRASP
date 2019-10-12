
void setup() {
  size(1000, 700, P3D);
  createGUI();
  noStroke();
  lpalmo = 4*lz[0][0]+3*spazio;
  wristR = lpalmo/2 - 15;
  tempoUltimaMisura = 0;
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  gpad = control.getMatchedDevice("cobograsp");
  if (gpad == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
}
public void getUserInput(){
  if (gpad.getSlider("handx").getValue() > 0)
    handx += 0.005;
  if (gpad.getSlider("handx").getValue() < 0)
    handx -= 0.005;

  if (gpad.getSlider("handy").getValue() > 0)
    handy += 0.005;
  if (gpad.getSlider("handy").getValue() < 0)
    handy -= 0.005;

  release = gpad.getButton("release").pressed();
}
public void getUserInput2(){
  if (gpad.getSlider("objx").getValue() > 0)
    objx += 10;    
  if (gpad.getSlider("objx").getValue() < 0)
    objx -= 10;

  if (gpad.getSlider("objy").getValue() > 0)
    objy += 10;    
  if (gpad.getSlider("objy").getValue() < 0)
    objy -= 10;

  if (gpad.getHat("objz_h").up())
    objz += 10;
    
  if (gpad.getHat("objz_h").down())
    objz -= 10;
}
void draw() {
  
  grasp = gpad.getButton("grasp").pressed();
  hit = gpad.getButton("hit").pressed();
  sw = gpad.getButton("sw").pressed();
  
  if (sw && !pressed){
    pressed = true;
  }
  if (grasp && pressed){
    pressed = false;
  }
  if (!pressed)
    getUserInput();
  if (pressed)
    getUserInput2();
    
  if (hit)
    wrist = random(0,PI);
  
  background(200);
  lights();
  smooth();
  noStroke();
  camera(width/2.0, height/2.0, eyeR, width/2.0, height/2.0, (height/2.0) / tan(PI*60.0 / 360.0) ,0,1,0);
    
  lean = handy;
  plan = handx;
  
  if (lean < PI/6)
    balance = 1;
  else
    balance = 0;
  
  stimaAccelerometro();
  
  scritture();
  
    if (grasp){
      if (close == 0){
        close = 1;
        open = 0;
        if (blocked == false){
          xObj = R[0][0]*(xmObj-xHand)+R[0][1]*(ymObj-yHand)+R[0][2]*(zmObj-zHand);
          yObj = R[1][0]*(xmObj-xHand)+R[1][1]*(ymObj-yHand)+R[1][2]*(zmObj-zHand);
          zObj = R[2][0]*(xmObj-xHand)+R[2][1]*(ymObj-yHand)+R[2][2]*(zmObj-zHand);
        }
        blocked = true;
      }
    }
    // apertura mano
   if (release){
      if (open == 0){
        open = 1;
        close = 0;
        blocked = false;
      }
    }
    
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
