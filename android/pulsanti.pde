void checkKeyPress(){

  if (keyPressed){
    
    // movimento braccio
    if (keyCode == UP){
      lean -= 0.05;
    }
    if (keyCode == DOWN){
      lean += 0.05;
    }
    if (keyCode == RIGHT){
      plan -= 0.01;
    }
    if (keyCode == LEFT){
      plan += 0.01;
    }
    // movimento camera
    if (key == 'g'){
      eyeR += 5;
    }
    if (key == 'h'){
      eyeR -= 5;
    }
    //rotazione polso
    if (key == 'q'){
      wrist += 0.05;
    }
    if (key == 'w'){
      wrist -= 0.05;
    }
    //profondità sfera
    if (key == 'n'){
      zObj += 5;
    }
    if (key == 'm'){
      zObj -= 5;
    }
    if (key == 'k'){
      yObj += 5;
    }
    if (key == 'j'){
      yObj -= 5;
    }
    if (key == 'i'){
      xObj += 5;
    }
    if (key == 'u'){
      xObj -= 5;
    }
    // chiusura mano
    if (keyCode == SHIFT){
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
    if (keyCode == ALT){
      if (open == 0){
        open = 1;
        close = 0;
        blocked = false;
      }
    }

    if (key == 'a'){
        balance = 1;
    }
    if (key == 's'){
        balance = 0;
    }
    if (key == 'z'){
      thetaDes = PI/2;
    }
    if (key == 'x'){
      thetaDes = -PI/2;
    }
    if (key == 'c'){
      thetaDes = 0;
    }
    if (key == 'e'){
      lean += 0.05;
    }
    if (key == 'r'){
      lean -= 0.05;
    }
  }
}