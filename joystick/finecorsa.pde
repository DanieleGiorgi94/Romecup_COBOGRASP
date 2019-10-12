void checkFineCorsa(){
  for (int i=0; i<4; i++){ // fine corsa delle quattro dita
    for (int j=0; j<3; j++){
      if (theta[i][j] >= THMAX[i][j]){
        theta[i][j] = THMAX[i][j];
      }
      if (theta[i][j] <= THMIN[i][j]){
        theta[i][j] = THMIN[i][j];
      }
    }
  }  
  for (int k=0; k<4; k++){ // fine corsa del pollice
    if (thumb[k] >= THBMAX[k]){ 
      thumb[k] = THBMAX[k];
    }
    if (thumb[k] <= THBMIN[k]){
      thumb[k] = THBMIN[k];
    }
  }
  if (wrist <= -PI/9){ // fine corsa del polso
    wrist = -PI/9;
  }
  if (wrist >= PI){
    wrist = PI;
  }
  if (lean <= -PI/2){ // fine corsa del gomito
    lean = -PI/2;
  }
  if (lean >= PI/2){
    lean = PI/2;
  }
  if (plan <= -PI/2){ // fine corsa del gomito
    plan = -PI/2;
  }
  if (plan >= PI/2){
    plan = PI/2;
  }
  if (handy <= -PI/2){ // fine corsa del gomito
    handy = -PI/2;
  }
  if (handy >= PI/2){
    handy = PI/2;
  }
  if (handx <= -PI/2){ // fine corsa del gomito
    handx = -PI/2;
  }
  if (handx >= PI/2){
    handx = PI/2;
  }
}