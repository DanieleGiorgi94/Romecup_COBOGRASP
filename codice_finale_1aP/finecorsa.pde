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
  if (wrist <= -PI/2){ // fine corsa del polso
    wrist = -PI/2;
  }
  if (wrist >= PI/2){
    wrist = PI/2;
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
}