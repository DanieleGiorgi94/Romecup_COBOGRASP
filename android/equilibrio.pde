void stimaAccelerometro(){

  if (millis() - tempoUltimaMisura > float(1/60) ){
    //aggiorno valori lettura accelerometro esatti
    Ax = g * sin(wrist);
    Ay = g * cos(wrist) * sin(lean);
    Az = g * cos(wrist) * cos(lean);

    if (abs(Ax) < 0.1)
      Ax = 0;
    if (abs(Ay) < 0.1)
      Ay = 0;
    if (abs(Az) < 0.1)
      Az = 0;

    //lettura accelerometro reale
    Axl = Ax + Gaussian(0, stDev);
    Ayl = Ay + Gaussian(0, stDev);
    Azl = Az + Gaussian(0, stDev);

    V = (float) pow(stDev,2) / ( pow(stDev,2) + pow(stDev,2) );

    //stima accelerometro (filtro passa-basso)
    Axr = Axr + V * (Axl - Axr);
    Ayr = Ayr + V * (Ayl - Ayr);
    Azr = Azr + V * (Azl - Azr);

    if (abs(Axr) < 0.1)
      Axr = 0;
    if (abs(Ayr) < 0.1)
      Ayr = 0;
    if (abs(Azr) < 0.1)
      Azr = 0;

    arg = Axr / g;
    if ( abs(arg) >= 0.999){
      if (arg > 0)
        arg = 1;
      else
        arg = -1;
    }
    wristHat = asin(arg); //stima di wrist

    arg = Ayr / (g * cos(wristHat));
    if ( abs(arg) >= 0.999){
      if (arg > 0)
        arg = 1;
      else
        arg = -1;
    }
    leanHat = acos(arg); //stima di lean

    //controllo equilibrio (fatto sia con wrist esatto, sia con stima di wrist)
    if (balance == 1){
      if (abs(wristHat - thetaDes) > 0.01*PI/180)
        balanceControl();
    }
    tempoUltimaMisura = millis();
  }
}

float Gaussian(float media, float stDev){ // Restituisce variabile 
        //N(media,stDev^2) approssimata sfruttando il teorema del limite centrale
  float somma = 0;
  for (int k=0; k<27; k+=1) // 27 in modo che sqrt(3/27)=1/3
    somma = somma + random(-stDev/3,stDev/3);
  return media + somma;
}

void balanceControl(){
  omegaDes = k_omega * (thetaDes - wrist);
  omegaDesR = k_omega * (thetaDes - wristHat);

  alpha = k_alpha * (omegaDes - omega);
  alphaR = k_alpha * (omegaDes - omegaR);

  if (abs(alpha) > 0.3 * omegaPM){
    if (alpha > 0)
      alpha = 0.3 * omegaPM;
    else
      alpha = - 0.3 * omegaPM;
  }

  if (abs(alphaR) > 0.3 * omegaPM){
    if (alphaR > 0)
      alphaR = 0.3 * omegaPM;
    else
      alphaR = - 0.3 * omegaPM;
  }

  wrist = wrist + omega * dt + alpha * pow(dt, 2) / 2;
  wristHat = wristHat + omegaR * dt + alphaR * pow(dt, 2) / 2;
  omega = omega + alpha * dt;
  omegaR = omegaR + alphaR * dt;
}