void closeFinger(int i){
  if (theta[i][2] > PI/45){
     theta[i][1] += fingerVel[i][1];
  }
  if (theta[i][2] > PI/30){
     theta[i][0] += fingerVel[i][0];
  }
  if (theta[i][2] > PI/6 && theta[i][0] < 4*PI/3){
    theta[i][2] += 0;
  }
  else{
    theta[i][2] += fingerVel[i][2];
  }
  if (theta[i][0] < PI)
  {
    theta[i][0] += fingerVel[i][0];
  }
}

void openFinger(int i){
  if (theta[i][2] < PI/3)
  {
    theta[i][0] -= PI*speed;
  }
  theta[i][1] -= PI*speed;
  theta[i][2] -= PI*speed;
}

void closeThumb(){
  thumb[0] -= thumbVel[0];
  thumb[1] += thumbVel[1];
  thumb[2] += 0.5*thumbVel[2];
  thumb[3] += 0.5*thumbVel[3];
}

void openThumb(){
  thumb[0] += PI*speed; 
  thumb[1] -= PI*speed;
  thumb[2] -= PI*speed;
  thumb[3] -= PI*speed;
}