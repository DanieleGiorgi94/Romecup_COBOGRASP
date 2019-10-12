void gotDistance(int g){
  pushMatrix();
  translate(-spessore, ly[g][2]/2);
  rotateY(PI/2);
  rotateX(PI/20); // per non lasciare la distanza troppo perpendicolare al dito
   
  distance[g] = sensorDist(g);
  if (g != 4){ // se non è il pollice
    for (int i = 0;  i < 3; i++){
       fingerVel[g][i] = 0.01*distance[g]*speed;
    }
  } else { // se è il pollice
    for (int i = 0; i < 4; i++){
       thumbVel[i] = 0.01*distance[g]*speed;
    } 
  }
  popMatrix();
}

float sensorDist(int g){
  float tempDist = 0;
  // viene misurata la distanza dito-palla
  for (w[g] = 0; w[g] < MAXDIST; w[g]+= precision){
    qDist[g][0] = modelX(0,0,-w[g]);
    qDist[g][1] = modelY(0,0,-w[g]);
    qDist[g][2] = modelZ(0,0,-w[g]);
    if (dist(qDist[g][0],qDist[g][1],qDist[g][2],xmObj,ymObj,zmObj) < rObj){break;} // se raggiunge la parete della sfera smette di sparare
  }
  tempDist = w[g];
  return tempDist;
}