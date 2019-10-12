void drawBlockedObj(){
  pushMatrix();
    rotateX(PI/2);
    rotateZ(-wrist);
    rotateX(-plan-PI/2); 
    rotateZ(-lean); 
    rotateX(-PI/2);
    rotateZ(-PI/2);
    
    stroke(10);
    line(0,0,0,50,0,0);
    line(0,0,0,0,50,0);
    line(0,0,0,0,0,50);
    sphere(10);
    noStroke();
  popMatrix();
    xHand = modelX(0,0,0);
    yHand = modelY(0,0,0);
    zHand = modelZ(0,0,0);
    
  if (blocked == true){
    translate(xObj, yObj, zObj);
    xmObj = modelX(0,0,0);
    ymObj = modelY(0,0,0);
    zmObj = modelZ(0,0,0);
    fill(255, 0, 0);
    sphere(rObj);
  }
}

void drawModelObj(){
  pushMatrix();
  if (blocked == false){
      translate(xmObj, ymObj, zmObj);
      fill(255, 0, 0);
      sphere(rObj);
  }
  popMatrix();
}