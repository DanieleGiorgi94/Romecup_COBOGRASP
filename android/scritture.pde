void scritture(){
  fill(0,0,0);
  textSize(20);
  text("Balance Control:"+balance, 0, 0);
  text("thetaDes:"+180*thetaDes/PI, 0, 20);
  text("Ax="+Ax, 0, 40);
  text("Ay="+Ay, 0, 60);
  text("Az="+Az, 0, 80);
  text("Axr="+Axr, 0, 120);
  text("Ayr="+Ayr, 0, 140);
  text("Azr="+Azr, 0, 160);
  text("wrist="+wrist, 0, 200);
  text("wristHat="+wristHat, 0, 220);
  text("open="+open, 0, 240);
  text("close="+close, 0, 260);
  text("X palla = "+(xmObj-xHand), 0, 300);
  text("Y palla = "+(ymObj-yHand), 0, 320);
  text("Z palla = "+(zmObj-zHand), 0, 340);
}